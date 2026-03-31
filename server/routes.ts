import type { Express, Request, Response, NextFunction } from "express";
import { createServer, type Server } from "http";
import session from "express-session";
import { storage } from "./storage";
import { db } from "./db";
import { insertUserSchema, loginSchema, insertTeamSchema, insertWeekSchema, insertChampionSchema, questions, answers } from "@shared/schema";
import { z } from "zod";
import bcrypt from "bcryptjs";
import { eq } from "drizzle-orm";

declare module "express-session" {
  interface SessionData {
    userId: string;
  }
}

function requireAuth(req: Request, res: Response, next: NextFunction) {
  if (!req.session.userId) {
    return res.status(401).json({ message: "Not authenticated" });
  }
  next();
}

async function requireAdmin(req: Request, res: Response, next: NextFunction) {
  if (!req.session.userId) {
    return res.status(401).json({ message: "Not authenticated" });
  }
  const user = await storage.getUser(req.session.userId);
  if (!user?.isAdmin) {
    return res.status(403).json({ message: "Admin access required" });
  }
  next();
}

export async function registerRoutes(
  httpServer: Server,
  app: Express
): Promise<Server> {
  // Session setup
  app.use(
    session({
      secret: process.env.SESSION_SECRET || "tuesday-trivia-secret-key",
      resave: false,
      saveUninitialized: false,
      cookie: {
        secure: false,
        httpOnly: true,
        maxAge: 7 * 24 * 60 * 60 * 1000, // 7 days
      },
    })
  );

  // ===== AUTH ROUTES =====
  app.post("/api/auth/register", async (req, res) => {
    try {
      const data = insertUserSchema.parse(req.body);
      
      const existing = await storage.getUserByEmail(data.email);
      if (existing) {
        return res.status(400).json({ message: "Email already registered" });
      }

      // Check if this is the first user - make them admin automatically
      const userCount = await storage.getUserCount();
      const isFirstUser = userCount === 0;

      const hashedPassword = await bcrypt.hash(data.password, 10);
      let user = await storage.createUser({
        ...data,
        password: hashedPassword,
      });

      // Make first user an admin
      if (isFirstUser) {
        user = await storage.updateUser(user.id, { isAdmin: true }) || user;
      }

      req.session.userId = user.id;
      res.json({ user: { ...user, password: undefined } });
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: error.errors[0].message });
      }
      console.error(error);
      res.status(500).json({ message: "Registration failed" });
    }
  });

  app.post("/api/auth/login", async (req, res) => {
    try {
      const data = loginSchema.parse(req.body);
      
      const user = await storage.getUserByEmail(data.email);
      if (!user) {
        return res.status(401).json({ message: "Invalid email or password" });
      }

      const valid = await bcrypt.compare(data.password, user.password);
      if (!valid) {
        return res.status(401).json({ message: "Invalid email or password" });
      }

      req.session.userId = user.id;
      res.json({ user: { ...user, password: undefined } });
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: error.errors[0].message });
      }
      res.status(500).json({ message: "Login failed" });
    }
  });

  app.post("/api/auth/logout", (req, res) => {
    req.session.destroy((err) => {
      if (err) {
        return res.status(500).json({ message: "Logout failed" });
      }
      res.json({ message: "Logged out" });
    });
  });

  app.get("/api/auth/me", async (req, res) => {
    if (!req.session.userId) {
      return res.status(401).json({ message: "Not authenticated" });
    }
    const user = await storage.getUser(req.session.userId);
    if (!user) {
      return res.status(401).json({ message: "User not found" });
    }
    res.json({ user: { ...user, password: undefined } });
  });

  app.post("/api/auth/forgot-password", async (req, res) => {
    try {
      const { email } = req.body;
      if (!email) {
        return res.status(400).json({ message: "Email is required" });
      }
      // Always return success to prevent email enumeration
      // In a real app, this would send an email with a reset token
      res.json({ message: "If an account exists, reset instructions have been sent" });
    } catch (error) {
      res.status(500).json({ message: "Request failed" });
    }
  });

  // ===== TEAM ROUTES =====
  app.get("/api/teams", requireAuth, async (req, res) => {
    const teams = await storage.getAllTeamsWithMembers();
    res.json(teams);
  });

  app.get("/api/teams/my-team", requireAuth, async (req, res) => {
    const member = await storage.getTeamMember(req.session.userId!);
    if (!member || !member.isApproved) {
      return res.json(null);
    }
    const team = await storage.getTeamWithMembers(member.teamId);
    res.json(team);
  });

  app.post("/api/teams", requireAuth, async (req, res) => {
    try {
      const data = insertTeamSchema.parse(req.body);
      
      const existingMember = await storage.getTeamMember(req.session.userId!);
      if (existingMember) {
        return res.status(400).json({ message: "You are already on a team" });
      }

      const existingTeam = await storage.getTeamByName(data.name);
      if (existingTeam) {
        return res.status(400).json({ message: "Team name already taken" });
      }

      const team = await storage.createTeam(data, req.session.userId!);
      await storage.addTeamMember(team.id, req.session.userId!, true);
      
      res.json(team);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: error.errors[0].message });
      }
      res.status(500).json({ message: "Failed to create team" });
    }
  });

  app.post("/api/teams/:teamId/join", requireAuth, async (req, res) => {
    const { teamId } = req.params;
    
    const existingMember = await storage.getTeamMember(req.session.userId!);
    if (existingMember) {
      return res.status(400).json({ message: "You are already on a team" });
    }

    const team = await storage.getTeamWithMembers(teamId);
    if (!team) {
      return res.status(404).json({ message: "Team not found" });
    }

    const memberCount = team.members.filter(m => m.isApproved).length;
    if (memberCount >= 4) {
      return res.status(400).json({ message: "This team is full (maximum 4 members)" });
    }

    await storage.addTeamMember(teamId, req.session.userId!, true);
    res.json({ message: "Successfully joined team" });
  });

  app.post("/api/teams/leave", requireAuth, async (req, res) => {
    const member = await storage.getTeamMember(req.session.userId!);
    if (!member) {
      return res.status(400).json({ message: "You are not on a team" });
    }
    await storage.removeTeamMember(member.id);
    res.json({ message: "Left team" });
  });

  // Note: Approval/reject routes removed since direct team joining (no approval workflow) is now used

  // ===== WEEK ROUTES =====
  app.get("/api/weeks", requireAuth, async (req, res) => {
    const weeks = await storage.getAllWeeks();
    res.json(weeks);
  });

  app.get("/api/weeks/active", requireAuth, async (req, res) => {
    const week = await storage.getActiveWeek();
    res.json(week || null);
  });

  app.get("/api/weeks/archived", requireAuth, async (req, res) => {
    const weeks = await storage.getArchivedWeeks();
    res.json(weeks);
  });

  app.get("/api/weeks/archived/with-submissions", requireAuth, async (req, res) => {
    try {
      const member = await storage.getTeamMember(req.session.userId!);
      if (!member || !member.isApproved) {
        const archivedWeeks = await storage.getArchivedWeeks();
        return res.json(archivedWeeks.map(w => ({ ...w, teamSubmission: null })));
      }
      const weeksWithSubmissions = await storage.getArchivedWeeksWithSubmissions(member.teamId);
      res.json(weeksWithSubmissions);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Failed to fetch archived weeks" });
    }
  });

  app.get("/api/weeks/:weekId", requireAuth, async (req, res) => {
    const week = await storage.getWeekWithQuestions(req.params.weekId);
    if (!week) {
      return res.status(404).json({ message: "Week not found" });
    }
    res.json(week);
  });

  // ===== SUBMISSION ROUTES =====
  app.get("/api/submissions/my-team", requireAuth, async (req, res) => {
    const member = await storage.getTeamMember(req.session.userId!);
    if (!member || !member.isApproved) {
      return res.json([]);
    }
    const submissions = await storage.getTeamSubmissions(member.teamId);
    res.json(submissions);
  });

  app.get("/api/submissions/my-team/:weekId", requireAuth, async (req, res) => {
    const member = await storage.getTeamMember(req.session.userId!);
    if (!member || !member.isApproved) {
      return res.json(null);
    }
    const submission = await storage.getSubmissionWithAnswers(member.teamId, req.params.weekId);
    res.json(submission || null);
  });

  app.post("/api/submissions", requireAuth, async (req, res) => {
    try {
      const { weekId, answers: answerData } = req.body;
      
      const member = await storage.getTeamMember(req.session.userId!);
      if (!member || !member.isApproved) {
        return res.status(400).json({ message: "You must be on a team" });
      }

      const week = await storage.getWeek(weekId);
      if (!week || !week.isActive) {
        return res.status(400).json({ message: "Week is not accepting submissions" });
      }

      if (week.deadline && new Date(week.deadline) < new Date()) {
        return res.status(400).json({ message: "The submission deadline has passed" });
      }

      let submission = await storage.getSubmission(member.teamId, weekId);
      if (submission) {
        await storage.deleteAnswersBySubmission(submission.id);
        // Update submission with new submitter and timestamp
        await storage.updateSubmission(submission.id, { 
          submittedById: req.session.userId,
          submittedAt: new Date()
        });
      } else {
        submission = await storage.createSubmission(member.teamId, weekId, req.session.userId!);
      }

      for (const answer of answerData) {
        await storage.createAnswer(submission.id, answer.questionId, answer.answerText);
      }

      res.json({ message: "Submission saved" });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Submission failed" });
    }
  });

  // ===== LEADERBOARD =====
  app.get("/api/leaderboard", requireAuth, async (req, res) => {
    const leaderboard = await storage.getLeaderboard();
    res.json(leaderboard);
  });

  // ===== ADMIN ROUTES =====
  app.get("/api/admin/stats", requireAdmin, async (req, res) => {
    const teamCount = await storage.getTeamCount();
    const userCount = await storage.getUserCount();
    res.json({ teamCount, userCount });
  });

  app.get("/api/admin/pending-submissions-count", requireAdmin, async (req, res) => {
    const count = await storage.getPendingSubmissionsCount();
    res.json(count);
  });

  app.post("/api/admin/weeks", requireAdmin, async (req, res) => {
    try {
      const { weekNumber, title, introText, deadline, questions: questionData } = req.body;
      
      // Check if week number already exists
      const existingWeek = await storage.getWeekByNumber(weekNumber);
      if (existingWeek) {
        return res.status(400).json({ message: `Week ${weekNumber} already exists. Please choose a different week number.` });
      }
      
      const week = await storage.createWeek({ weekNumber, title, introText, deadline: deadline ? new Date(deadline) : null });
      
      for (let i = 0; i < questionData.length; i++) {
        await storage.createQuestion({
          weekId: week.id,
          questionNumber: i + 1,
          questionText: questionData[i].questionText,
          correctAnswer: questionData[i].correctAnswer,
          maxPoints: questionData[i].maxPoints || 1,
          imageUrl: questionData[i].imageUrl || null,
        });
      }

      res.json(week);
    } catch (error: any) {
      console.error(error);
      if (error?.code === "23505") {
        return res.status(400).json({ message: "Week number already exists. Please choose a different number." });
      }
      res.status(500).json({ message: "Failed to create week. Please check your inputs and try again." });
    }
  });

  app.put("/api/admin/weeks/:weekId", requireAdmin, async (req, res) => {
    try {
      const { weekNumber, title, introText, deadline, questions: questionData } = req.body;
      const weekId = req.params.weekId;
      
      const existingWeek = await storage.getWeek(weekId);
      if (!existingWeek) {
        return res.status(404).json({ message: "Week not found" });
      }
      
      // Check if changing to a week number that already exists (and isn't this week)
      if (weekNumber !== existingWeek.weekNumber) {
        const weekWithNumber = await storage.getWeekByNumber(weekNumber);
        if (weekWithNumber) {
          return res.status(400).json({ message: `Week ${weekNumber} already exists. Please choose a different week number.` });
        }
      }
      
      // Update week details
      await storage.updateWeek(weekId, { weekNumber, title, introText, deadline: deadline ? new Date(deadline) : null });
      
      // Update questions — strategy depends on whether submissions exist
      const weekSubmissions = await storage.getWeekSubmissions(weekId);
      const existingWeekWithQuestions = await storage.getWeekWithQuestions(weekId);

      if (weekSubmissions.length === 0) {
        // No submissions yet: safe to delete and recreate questions
        if (existingWeekWithQuestions) {
          for (const q of existingWeekWithQuestions.questions) {
            await db.delete(answers).where(eq(answers.questionId, q.id));
          }
          await db.delete(questions).where(eq(questions.weekId, weekId));
        }
        for (let i = 0; i < questionData.length; i++) {
          await storage.createQuestion({
            weekId,
            questionNumber: i + 1,
            questionText: questionData[i].questionText,
            correctAnswer: questionData[i].correctAnswer,
            maxPoints: questionData[i].maxPoints || 1,
            imageUrl: questionData[i].imageUrl || null,
          });
        }
      } else {
        // Submissions exist: update question text/answer/points in-place to preserve answer references
        const sortedExisting = (existingWeekWithQuestions?.questions ?? [])
          .sort((a, b) => a.questionNumber - b.questionNumber);
        for (let i = 0; i < sortedExisting.length && i < questionData.length; i++) {
          await storage.updateQuestion(sortedExisting[i].id, {
            questionText: questionData[i].questionText,
            correctAnswer: questionData[i].correctAnswer,
            maxPoints: questionData[i].maxPoints || 1,
            imageUrl: questionData[i].imageUrl || null,
          });
        }
      }
      
      const updatedWeek = await storage.getWeekWithQuestions(weekId);
      res.json(updatedWeek);
    } catch (error: any) {
      console.error(error);
      if (error?.code === "23505") {
        return res.status(400).json({ message: "Week number already exists. Please choose a different number." });
      }
      res.status(500).json({ message: "Failed to update week. Please try again." });
    }
  });

  app.delete("/api/admin/weeks/:weekId", requireAdmin, async (req, res) => {
    try {
      const week = await storage.getWeek(req.params.weekId);
      if (!week) {
        return res.status(404).json({ message: "Week not found" });
      }
      
      await storage.deleteWeek(req.params.weekId);
      res.json({ message: "Week deleted successfully" });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Failed to delete week. Please try again." });
    }
  });

  app.post("/api/admin/weeks/:weekId/activate", requireAdmin, async (req, res) => {
    // Deactivate all other weeks first
    const allWeeks = await storage.getAllWeeks();
    for (const week of allWeeks) {
      if (week.isActive) {
        await storage.updateWeek(week.id, { isActive: false });
      }
    }
    
    await storage.updateWeek(req.params.weekId, { isActive: true });
    res.json({ message: "Week activated" });
  });

  app.post("/api/admin/weeks/:weekId/deactivate", requireAdmin, async (req, res) => {
    await storage.updateWeek(req.params.weekId, { isActive: false });
    res.json({ message: "Week deactivated" });
  });

  app.get("/api/admin/submissions/:weekId", requireAdmin, async (req, res) => {
    const submissions = await storage.getWeekSubmissions(req.params.weekId);
    res.json(submissions);
  });

  // Returns all teams + their submission (if any) + week questions for grading
  app.get("/api/admin/weeks/:weekId/grade-data", requireAdmin, async (req, res) => {
    try {
      const { weekId } = req.params;
      const week = await storage.getWeekWithQuestions(weekId);
      if (!week) return res.status(404).json({ message: "Week not found" });
      const allTeams = await storage.getAllTeamsWithMembers();
      const submissions = await storage.getWeekSubmissions(weekId);
      res.json({ week, allTeams, submissions });
    } catch (error) {
      res.status(500).json({ message: "Failed to load grade data" });
    }
  });

  // Grade a team that did not submit — creates submission + placeholder answers + applies points
  app.post("/api/admin/weeks/:weekId/grade-nonsubmitter/:teamId", requireAdmin, async (req, res) => {
    try {
      const { weekId, teamId } = req.params;
      const { questionGrades, reason } = req.body; // [{ questionId, points }]

      const week = await storage.getWeekWithQuestions(weekId);
      if (!week) return res.status(404).json({ message: "Week not found" });

      const isRegrade = week.isPublished;
      if (isRegrade && !reason) {
        return res.status(400).json({ message: "A reason is required when re-grading a published week" });
      }

      // Check if they already have a submission (shouldn't, but be safe)
      let submission = await storage.getSubmission(teamId, weekId);
      if (!submission) {
        // Create a submission on behalf of admin
        submission = await storage.createSubmission(teamId, weekId, req.session.userId!);
        // Create placeholder answers for all questions
        for (const q of week.questions) {
          await storage.createAnswer(submission.id, q.id, "No submission");
        }
      }

      // Now fetch the submission with its newly created answers
      const submissionWithAnswers = await storage.getSubmissionWithAnswers(teamId, weekId);
      if (!submissionWithAnswers) return res.status(500).json({ message: "Failed to load submission" });

      const questionToAnswer: Record<string, { answerId: string; oldPoints: string }> = {};
      for (const answer of submissionWithAnswers.answers) {
        questionToAnswer[answer.questionId] = {
          answerId: answer.id,
          oldPoints: answer.pointsAwarded?.toString() || "0",
        };
      }

      let total = 0;
      for (const { questionId, points } of questionGrades) {
        const question = week.questions.find(q => q.id === questionId);
        const maxPoints = question?.maxPoints || 1;
        const clampedPoints = Math.max(0, Math.min(points, maxPoints));
        const entry = questionToAnswer[questionId];
        if (!entry) continue;

        if (isRegrade && parseFloat(entry.oldPoints) !== clampedPoints) {
          await storage.createScoreEdit({
            submissionId: submission.id,
            questionId,
            oldPoints: entry.oldPoints,
            newPoints: clampedPoints.toString(),
            reason: reason || "",
            editedById: req.session.userId!,
          });
        }

        await storage.updateAnswer(entry.answerId, { pointsAwarded: clampedPoints.toString() });
        total += clampedPoints;
      }

      await storage.updateSubmission(submission.id, { isGraded: true, totalPoints: total.toString() });
      await storage.updateWeek(weekId, { isGraded: true });
      res.json({ message: "Grading saved" });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Grading failed" });
    }
  });

  app.post("/api/admin/weeks/:weekId/grade", requireAdmin, async (req, res) => {
    try {
      const { grades, reason } = req.body;
      
      const week = await storage.getWeekWithQuestions(req.params.weekId);
      if (!week) {
        return res.status(404).json({ message: "Week not found" });
      }

      const isRegrade = week.isPublished;
      
      if (isRegrade && !reason) {
        return res.status(400).json({ message: "A reason is required when re-grading a published week" });
      }
      
      const submissions = await storage.getWeekSubmissions(req.params.weekId);
      const answerToMaxPoints: Record<string, number> = {};
      const answerToOldPoints: Record<string, string> = {};
      const answerToSubmissionId: Record<string, string> = {};
      const answerToQuestionId: Record<string, string> = {};
      for (const submission of submissions) {
        for (const answer of submission.answers) {
          answerToMaxPoints[answer.id] = answer.question.maxPoints || 1;
          answerToOldPoints[answer.id] = answer.pointsAwarded?.toString() || "0";
          answerToSubmissionId[answer.id] = submission.id;
          answerToQuestionId[answer.id] = answer.questionId;
        }
      }
      
      for (const grade of grades) {
        const maxPoints = answerToMaxPoints[grade.answerId] || 1;
        const clampedPoints = Math.max(0, Math.min(grade.points, maxPoints));
        const oldPoints = answerToOldPoints[grade.answerId] || "0";
        
        if (isRegrade && parseFloat(oldPoints) !== clampedPoints) {
          await storage.createScoreEdit({
            submissionId: answerToSubmissionId[grade.answerId],
            questionId: answerToQuestionId[grade.answerId],
            oldPoints: oldPoints,
            newPoints: clampedPoints.toString(),
            reason: reason || "",
            editedById: req.session.userId!,
          });
        }
        
        await storage.updateAnswer(grade.answerId, { pointsAwarded: clampedPoints.toString() });
      }

      for (const submission of submissions) {
        const total = submission.answers.reduce((sum, answer) => {
          const grade = grades.find((g: any) => g.answerId === answer.id);
          if (grade) {
            const maxPoints = answer.question.maxPoints || 1;
            const clampedPoints = Math.max(0, Math.min(grade.points, maxPoints));
            return sum + clampedPoints;
          }
          return sum + parseFloat(answer.pointsAwarded?.toString() || "0");
        }, 0);
        await storage.updateSubmission(submission.id, { 
          isGraded: true, 
          totalPoints: total.toString() 
        });
      }

      await storage.updateWeek(req.params.weekId, { isGraded: true });
      res.json({ message: "Grading saved" });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Grading failed" });
    }
  });

  app.get("/api/admin/score-edits/:weekId", requireAdmin, async (req, res) => {
    const edits = await storage.getScoreEditsByWeek(req.params.weekId);
    res.json(edits);
  });

  app.post("/api/admin/weeks/:weekId/publish", requireAdmin, async (req, res) => {
    await storage.updateWeek(req.params.weekId, { isPublished: true });
    res.json({ message: "Scores published" });
  });

  app.post("/api/admin/leaderboard/override", requireAdmin, async (req, res) => {
    // In a real app, this would update a separate points override table
    res.json({ message: "Leaderboard updated" });
  });

  app.post("/api/admin/leaderboard/recalculate", requireAdmin, async (req, res) => {
    // Leaderboard is calculated dynamically from submissions
    res.json({ message: "Leaderboard recalculated" });
  });

  // ===== CHAMPIONS ROUTES =====
  app.get("/api/champions", async (req, res) => {
    const allChampions = await storage.getAllChampions();
    res.json(allChampions);
  });

  app.post("/api/admin/champions", requireAdmin, async (req, res) => {
    try {
      const data = insertChampionSchema.parse(req.body);
      const champion = await storage.createChampion(data);
      res.json(champion);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: error.errors[0].message });
      }
      console.error(error);
      res.status(500).json({ message: "Failed to create champion entry" });
    }
  });

  app.put("/api/admin/champions/:id", requireAdmin, async (req, res) => {
    try {
      const existing = await storage.getChampion(req.params.id);
      if (!existing) {
        return res.status(404).json({ message: "Champion entry not found" });
      }
      const data = insertChampionSchema.partial().parse(req.body);
      const champion = await storage.updateChampion(req.params.id, data);
      res.json(champion);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: error.errors[0].message });
      }
      console.error(error);
      res.status(500).json({ message: "Failed to update champion entry" });
    }
  });

  app.delete("/api/admin/champions/:id", requireAdmin, async (req, res) => {
    try {
      const existing = await storage.getChampion(req.params.id);
      if (!existing) {
        return res.status(404).json({ message: "Champion entry not found" });
      }
      await storage.deleteChampion(req.params.id);
      res.json({ message: "Champion entry deleted" });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Failed to delete champion entry" });
    }
  });

  return httpServer;
}

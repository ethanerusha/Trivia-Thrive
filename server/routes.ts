import type { Express, Request, Response, NextFunction } from "express";
import { createServer, type Server } from "http";
import session from "express-session";
import { storage } from "./storage";
import { insertUserSchema, loginSchema, insertTeamSchema, insertWeekSchema } from "@shared/schema";
import { z } from "zod";
import bcrypt from "bcryptjs";

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

      const hashedPassword = await bcrypt.hash(data.password, 10);
      const user = await storage.createUser({
        ...data,
        password: hashedPassword,
      });

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
      const { weekNumber, title, questions: questionData } = req.body;
      
      const week = await storage.createWeek({ weekNumber, title });
      
      for (let i = 0; i < questionData.length; i++) {
        await storage.createQuestion({
          weekId: week.id,
          questionNumber: i + 1,
          questionText: questionData[i].questionText,
          correctAnswer: questionData[i].correctAnswer,
          maxPoints: questionData[i].maxPoints || 1,
        });
      }

      res.json(week);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Failed to create week" });
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

  app.post("/api/admin/weeks/:weekId/grade", requireAdmin, async (req, res) => {
    try {
      const { grades } = req.body;
      
      // Get week with questions to validate maxPoints
      const week = await storage.getWeekWithQuestions(req.params.weekId);
      if (!week) {
        return res.status(404).json({ message: "Week not found" });
      }
      
      // Get all submissions to map answer IDs to question maxPoints
      const submissions = await storage.getWeekSubmissions(req.params.weekId);
      const answerToMaxPoints: Record<string, number> = {};
      for (const submission of submissions) {
        for (const answer of submission.answers) {
          answerToMaxPoints[answer.id] = answer.question.maxPoints || 1;
        }
      }
      
      // Apply grades with clamping to valid range
      for (const grade of grades) {
        const maxPoints = answerToMaxPoints[grade.answerId] || 1;
        const clampedPoints = Math.max(0, Math.min(grade.points, maxPoints));
        await storage.updateAnswer(grade.answerId, { pointsAwarded: clampedPoints.toString() });
      }

      // Calculate total points per submission
      for (const submission of submissions) {
        const total = submission.answers.reduce((sum, answer) => {
          const grade = grades.find((g: any) => g.answerId === answer.id);
          if (grade) {
            const maxPoints = answer.question.maxPoints || 1;
            const clampedPoints = Math.max(0, Math.min(grade.points, maxPoints));
            return sum + clampedPoints;
          }
          return sum;
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

  return httpServer;
}

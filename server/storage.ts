import { 
  users, teams, teamMembers, weeks, questions, submissions, answers,
  type User, type InsertUser, type Team, type InsertTeam, type TeamMember,
  type Week, type InsertWeek, type Question, type InsertQuestion, 
  type Submission, type Answer, type TeamWithMembers, type WeekWithQuestions,
  type SubmissionWithAnswers, type LeaderboardEntry
} from "@shared/schema";
import { db } from "./db";
import { eq, and, desc, sql } from "drizzle-orm";

export interface IStorage {
  // Users
  getUser(id: string): Promise<User | undefined>;
  getUserByEmail(email: string): Promise<User | undefined>;
  createUser(user: InsertUser): Promise<User>;
  updateUser(id: string, data: Partial<User>): Promise<User | undefined>;
  getUserCount(): Promise<number>;
  
  // Teams
  getTeam(id: string): Promise<Team | undefined>;
  getTeamByName(name: string): Promise<Team | undefined>;
  getTeamWithMembers(id: string): Promise<TeamWithMembers | undefined>;
  getAllTeamsWithMembers(): Promise<TeamWithMembers[]>;
  createTeam(team: InsertTeam, leadId: string): Promise<Team>;
  getTeamCount(): Promise<number>;
  
  // Team Members
  getTeamMember(userId: string): Promise<TeamMember | undefined>;
  getTeamMemberById(id: string): Promise<TeamMember | undefined>;
  addTeamMember(teamId: string, userId: string, isLead: boolean): Promise<TeamMember>;
  approveTeamMember(memberId: string): Promise<void>;
  removeTeamMember(memberId: string): Promise<void>;
  
  // Weeks
  getWeek(id: string): Promise<Week | undefined>;
  getWeekByNumber(weekNumber: number): Promise<Week | undefined>;
  getWeekWithQuestions(id: string): Promise<WeekWithQuestions | undefined>;
  getAllWeeks(): Promise<Week[]>;
  getActiveWeek(): Promise<Week | undefined>;
  getArchivedWeeks(): Promise<WeekWithQuestions[]>;
  createWeek(week: InsertWeek): Promise<Week>;
  updateWeek(id: string, data: Partial<Week>): Promise<void>;
  deleteWeek(id: string): Promise<void>;
  
  // Questions
  createQuestion(question: InsertQuestion): Promise<Question>;
  
  // Submissions
  getSubmission(teamId: string, weekId: string): Promise<Submission | undefined>;
  getSubmissionWithAnswers(teamId: string, weekId: string): Promise<SubmissionWithAnswers | undefined>;
  getTeamSubmissions(teamId: string): Promise<SubmissionWithAnswers[]>;
  getWeekSubmissions(weekId: string): Promise<SubmissionWithAnswers[]>;
  createSubmission(teamId: string, weekId: string, submittedById: string): Promise<Submission>;
  updateSubmission(id: string, data: Partial<Submission>): Promise<void>;
  getPendingSubmissionsCount(): Promise<number>;
  
  // Answers
  createAnswer(submissionId: string, questionId: string, answerText: string): Promise<Answer>;
  updateAnswer(id: string, data: Partial<Answer>): Promise<void>;
  deleteAnswersBySubmission(submissionId: string): Promise<void>;
  
  // Leaderboard
  getLeaderboard(): Promise<LeaderboardEntry[]>;
  updateTeamPoints(teamId: string, points: number): Promise<void>;
}

export class DatabaseStorage implements IStorage {
  // Users
  async getUser(id: string): Promise<User | undefined> {
    const [user] = await db.select().from(users).where(eq(users.id, id));
    return user || undefined;
  }

  async getUserByEmail(email: string): Promise<User | undefined> {
    const [user] = await db.select().from(users).where(eq(users.email, email));
    return user || undefined;
  }

  async createUser(insertUser: InsertUser): Promise<User> {
    const [user] = await db.insert(users).values(insertUser).returning();
    return user;
  }

  async updateUser(id: string, data: Partial<User>): Promise<User | undefined> {
    const [user] = await db.update(users).set(data).where(eq(users.id, id)).returning();
    return user || undefined;
  }

  async getUserCount(): Promise<number> {
    const result = await db.select({ count: sql<number>`count(*)` }).from(users);
    return Number(result[0].count);
  }

  // Teams
  async getTeam(id: string): Promise<Team | undefined> {
    const [team] = await db.select().from(teams).where(eq(teams.id, id));
    return team || undefined;
  }

  async getTeamByName(name: string): Promise<Team | undefined> {
    const [team] = await db.select().from(teams).where(eq(teams.name, name));
    return team || undefined;
  }

  async getTeamWithMembers(id: string): Promise<TeamWithMembers | undefined> {
    const [team] = await db.select().from(teams).where(eq(teams.id, id));
    if (!team) return undefined;

    const [lead] = await db.select().from(users).where(eq(users.id, team.leadId));
    const members = await db
      .select()
      .from(teamMembers)
      .where(eq(teamMembers.teamId, id));

    const membersWithUsers = await Promise.all(
      members.map(async (member) => {
        const [user] = await db.select().from(users).where(eq(users.id, member.userId));
        return { ...member, user };
      })
    );

    const approvedCount = membersWithUsers.filter(m => m.isApproved).length;

    return {
      ...team,
      lead,
      members: membersWithUsers,
      memberCount: approvedCount,
    };
  }

  async getAllTeamsWithMembers(): Promise<TeamWithMembers[]> {
    const allTeams = await db.select().from(teams);
    
    return Promise.all(
      allTeams.map(async (team) => {
        const [lead] = await db.select().from(users).where(eq(users.id, team.leadId));
        const members = await db.select().from(teamMembers).where(eq(teamMembers.teamId, team.id));
        
        const membersWithUsers = await Promise.all(
          members.map(async (member) => {
            const [user] = await db.select().from(users).where(eq(users.id, member.userId));
            return { ...member, user };
          })
        );

        const approvedCount = membersWithUsers.filter(m => m.isApproved).length;

        return {
          ...team,
          lead,
          members: membersWithUsers,
          memberCount: approvedCount,
        };
      })
    );
  }

  async createTeam(team: InsertTeam, leadId: string): Promise<Team> {
    const [newTeam] = await db.insert(teams).values({ ...team, leadId }).returning();
    return newTeam;
  }

  async getTeamCount(): Promise<number> {
    const result = await db.select({ count: sql<number>`count(*)` }).from(teams);
    return Number(result[0].count);
  }

  // Team Members
  async getTeamMember(userId: string): Promise<TeamMember | undefined> {
    const [member] = await db.select().from(teamMembers).where(eq(teamMembers.userId, userId));
    return member || undefined;
  }

  async getTeamMemberById(id: string): Promise<TeamMember | undefined> {
    const [member] = await db.select().from(teamMembers).where(eq(teamMembers.id, id));
    return member || undefined;
  }

  async addTeamMember(teamId: string, userId: string, isLead: boolean): Promise<TeamMember> {
    const [member] = await db
      .insert(teamMembers)
      .values({ teamId, userId, isLead, isApproved: isLead })
      .returning();
    return member;
  }

  async approveTeamMember(memberId: string): Promise<void> {
    await db.update(teamMembers).set({ isApproved: true }).where(eq(teamMembers.id, memberId));
  }

  async removeTeamMember(memberId: string): Promise<void> {
    await db.delete(teamMembers).where(eq(teamMembers.id, memberId));
  }

  // Weeks
  async getWeek(id: string): Promise<Week | undefined> {
    const [week] = await db.select().from(weeks).where(eq(weeks.id, id));
    return week || undefined;
  }

  async getWeekByNumber(weekNumber: number): Promise<Week | undefined> {
    const [week] = await db.select().from(weeks).where(eq(weeks.weekNumber, weekNumber));
    return week || undefined;
  }

  async getWeekWithQuestions(id: string): Promise<WeekWithQuestions | undefined> {
    const [week] = await db.select().from(weeks).where(eq(weeks.id, id));
    if (!week) return undefined;

    const weekQuestions = await db.select().from(questions).where(eq(questions.weekId, id));
    return { ...week, questions: weekQuestions };
  }

  async getAllWeeks(): Promise<Week[]> {
    return db.select().from(weeks).orderBy(desc(weeks.weekNumber));
  }

  async getActiveWeek(): Promise<Week | undefined> {
    const [week] = await db.select().from(weeks).where(eq(weeks.isActive, true));
    return week || undefined;
  }

  async getArchivedWeeks(): Promise<WeekWithQuestions[]> {
    const archivedWeeks = await db
      .select()
      .from(weeks)
      .where(eq(weeks.isPublished, true))
      .orderBy(desc(weeks.weekNumber));

    return Promise.all(
      archivedWeeks.map(async (week) => {
        const weekQuestions = await db.select().from(questions).where(eq(questions.weekId, week.id));
        return { ...week, questions: weekQuestions };
      })
    );
  }

  async createWeek(week: InsertWeek): Promise<Week> {
    const [newWeek] = await db.insert(weeks).values(week).returning();
    return newWeek;
  }

  async updateWeek(id: string, data: Partial<Week>): Promise<void> {
    await db.update(weeks).set(data).where(eq(weeks.id, id));
  }

  async deleteWeek(id: string): Promise<void> {
    // Delete all answers for submissions in this week
    const weekSubmissions = await db.select().from(submissions).where(eq(submissions.weekId, id));
    for (const sub of weekSubmissions) {
      await db.delete(answers).where(eq(answers.submissionId, sub.id));
    }
    // Delete submissions
    await db.delete(submissions).where(eq(submissions.weekId, id));
    // Delete questions
    await db.delete(questions).where(eq(questions.weekId, id));
    // Delete week
    await db.delete(weeks).where(eq(weeks.id, id));
  }

  // Questions
  async createQuestion(question: InsertQuestion): Promise<Question> {
    const [newQuestion] = await db.insert(questions).values(question).returning();
    return newQuestion;
  }

  // Submissions
  async getSubmission(teamId: string, weekId: string): Promise<Submission | undefined> {
    const [submission] = await db
      .select()
      .from(submissions)
      .where(and(eq(submissions.teamId, teamId), eq(submissions.weekId, weekId)));
    return submission || undefined;
  }

  async getSubmissionWithAnswers(teamId: string, weekId: string): Promise<SubmissionWithAnswers | undefined> {
    const [submission] = await db
      .select()
      .from(submissions)
      .where(and(eq(submissions.teamId, teamId), eq(submissions.weekId, weekId)));
    
    if (!submission) return undefined;

    const [team] = await db.select().from(teams).where(eq(teams.id, teamId));
    const submissionAnswers = await db.select().from(answers).where(eq(answers.submissionId, submission.id));
    
    const answersWithQuestions = await Promise.all(
      submissionAnswers.map(async (answer) => {
        const [question] = await db.select().from(questions).where(eq(questions.id, answer.questionId));
        return { ...answer, question };
      })
    );

    let submittedBy = null;
    if (submission.submittedById) {
      const [user] = await db.select().from(users).where(eq(users.id, submission.submittedById));
      submittedBy = user || null;
    }

    return { ...submission, answers: answersWithQuestions, team, submittedBy };
  }

  async getTeamSubmissions(teamId: string): Promise<SubmissionWithAnswers[]> {
    const teamSubmissions = await db
      .select()
      .from(submissions)
      .where(eq(submissions.teamId, teamId));

    const [team] = await db.select().from(teams).where(eq(teams.id, teamId));

    return Promise.all(
      teamSubmissions.map(async (submission) => {
        const submissionAnswers = await db.select().from(answers).where(eq(answers.submissionId, submission.id));
        const answersWithQuestions = await Promise.all(
          submissionAnswers.map(async (answer) => {
            const [question] = await db.select().from(questions).where(eq(questions.id, answer.questionId));
            return { ...answer, question };
          })
        );
        
        let submittedBy = null;
        if (submission.submittedById) {
          const [user] = await db.select().from(users).where(eq(users.id, submission.submittedById));
          submittedBy = user || null;
        }
        
        return { ...submission, answers: answersWithQuestions, team, submittedBy };
      })
    );
  }

  async getWeekSubmissions(weekId: string): Promise<SubmissionWithAnswers[]> {
    const weekSubmissions = await db
      .select()
      .from(submissions)
      .where(eq(submissions.weekId, weekId));

    return Promise.all(
      weekSubmissions.map(async (submission) => {
        const [team] = await db.select().from(teams).where(eq(teams.id, submission.teamId));
        const submissionAnswers = await db.select().from(answers).where(eq(answers.submissionId, submission.id));
        const answersWithQuestions = await Promise.all(
          submissionAnswers.map(async (answer) => {
            const [question] = await db.select().from(questions).where(eq(questions.id, answer.questionId));
            return { ...answer, question };
          })
        );
        
        let submittedBy = null;
        if (submission.submittedById) {
          const [user] = await db.select().from(users).where(eq(users.id, submission.submittedById));
          submittedBy = user || null;
        }
        
        return { ...submission, answers: answersWithQuestions, team, submittedBy };
      })
    );
  }

  async createSubmission(teamId: string, weekId: string, submittedById: string): Promise<Submission> {
    const [submission] = await db
      .insert(submissions)
      .values({ teamId, weekId, submittedById })
      .returning();
    return submission;
  }

  async updateSubmission(id: string, data: Partial<Submission>): Promise<void> {
    await db.update(submissions).set(data).where(eq(submissions.id, id));
  }

  async getPendingSubmissionsCount(): Promise<number> {
    const result = await db
      .select({ count: sql<number>`count(*)` })
      .from(submissions)
      .where(eq(submissions.isGraded, false));
    return Number(result[0].count);
  }

  // Answers
  async createAnswer(submissionId: string, questionId: string, answerText: string): Promise<Answer> {
    const [answer] = await db
      .insert(answers)
      .values({ submissionId, questionId, answerText })
      .returning();
    return answer;
  }

  async updateAnswer(id: string, data: Partial<Answer>): Promise<void> {
    await db.update(answers).set(data).where(eq(answers.id, id));
  }

  async deleteAnswersBySubmission(submissionId: string): Promise<void> {
    await db.delete(answers).where(eq(answers.submissionId, submissionId));
  }

  // Leaderboard
  async getLeaderboard(): Promise<LeaderboardEntry[]> {
    const allTeams = await this.getAllTeamsWithMembers();
    const allWeeks = await this.getAllWeeks();
    const publishedWeeks = allWeeks.filter(w => w.isPublished).sort((a, b) => a.weekNumber - b.weekNumber);
    
    const leaderboard = await Promise.all(
      allTeams.map(async (team) => {
        const teamSubmissions = await db
          .select()
          .from(submissions)
          .where(and(eq(submissions.teamId, team.id), eq(submissions.isGraded, true)));
        
        // Build weekly scores array
        const weeklyScores = publishedWeeks.map(week => {
          const submission = teamSubmissions.find(s => s.weekId === week.id);
          return {
            weekNumber: week.weekNumber,
            weekId: week.id,
            points: submission ? parseFloat(submission.totalPoints?.toString() || "0") : 0,
          };
        });
        
        const totalPoints = weeklyScores.reduce((sum, ws) => sum + ws.points, 0);

        return {
          teamId: team.id,
          teamName: team.name,
          memberCount: team.memberCount,
          totalPoints,
          rank: 0,
          weeklyScores,
        };
      })
    );

    // Sort by points and assign ranks
    leaderboard.sort((a, b) => b.totalPoints - a.totalPoints);
    leaderboard.forEach((entry, index) => {
      entry.rank = index + 1;
    });

    return leaderboard;
  }

  async updateTeamPoints(teamId: string, points: number): Promise<void> {
    // This would need a separate points override table in a real app
    // For now, we just recalculate from submissions
  }
}

export const storage = new DatabaseStorage();

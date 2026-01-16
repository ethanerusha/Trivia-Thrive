import { sql, relations } from "drizzle-orm";
import { pgTable, text, varchar, integer, boolean, timestamp, decimal } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod";

// Users table
export const users = pgTable("users", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  email: text("email").notNull().unique(),
  password: text("password").notNull(),
  name: text("name").notNull(),
  isAdmin: boolean("is_admin").default(false).notNull(),
  isVerified: boolean("is_verified").default(true).notNull(),
  verificationToken: text("verification_token"),
});

export const usersRelations = relations(users, ({ one }) => ({
  teamMember: one(teamMembers, {
    fields: [users.id],
    references: [teamMembers.userId],
  }),
}));

// Teams table
export const teams = pgTable("teams", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull().unique(),
  leadId: varchar("lead_id").notNull().references(() => users.id),
});

export const teamsRelations = relations(teams, ({ one, many }) => ({
  lead: one(users, {
    fields: [teams.leadId],
    references: [users.id],
  }),
  members: many(teamMembers),
  submissions: many(submissions),
}));

// Team members table (join table with approval status)
export const teamMembers = pgTable("team_members", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  teamId: varchar("team_id").notNull().references(() => teams.id),
  userId: varchar("user_id").notNull().references(() => users.id),
  isApproved: boolean("is_approved").default(false).notNull(),
  isLead: boolean("is_lead").default(false).notNull(),
});

export const teamMembersRelations = relations(teamMembers, ({ one }) => ({
  team: one(teams, {
    fields: [teamMembers.teamId],
    references: [teams.id],
  }),
  user: one(users, {
    fields: [teamMembers.userId],
    references: [users.id],
  }),
}));

// Weeks table (trivia rounds)
export const weeks = pgTable("weeks", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  weekNumber: integer("week_number").notNull().unique(),
  title: text("title").notNull(),
  isActive: boolean("is_active").default(false).notNull(),
  isGraded: boolean("is_graded").default(false).notNull(),
  isPublished: boolean("is_published").default(false).notNull(),
});

export const weeksRelations = relations(weeks, ({ many }) => ({
  questions: many(questions),
  submissions: many(submissions),
}));

// Questions table
export const questions = pgTable("questions", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  weekId: varchar("week_id").notNull().references(() => weeks.id),
  questionNumber: integer("question_number").notNull(),
  questionText: text("question_text").notNull(),
  correctAnswer: text("correct_answer").notNull(),
});

export const questionsRelations = relations(questions, ({ one, many }) => ({
  week: one(weeks, {
    fields: [questions.weekId],
    references: [weeks.id],
  }),
  answers: many(answers),
}));

// Submissions table (team's submission for a week)
export const submissions = pgTable("submissions", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  teamId: varchar("team_id").notNull().references(() => teams.id),
  weekId: varchar("week_id").notNull().references(() => weeks.id),
  submittedAt: timestamp("submitted_at").defaultNow().notNull(),
  isGraded: boolean("is_graded").default(false).notNull(),
  totalPoints: decimal("total_points", { precision: 4, scale: 1 }).default("0"),
});

export const submissionsRelations = relations(submissions, ({ one, many }) => ({
  team: one(teams, {
    fields: [submissions.teamId],
    references: [teams.id],
  }),
  week: one(weeks, {
    fields: [submissions.weekId],
    references: [weeks.id],
  }),
  answers: many(answers),
}));

// Answers table (individual answers within a submission)
export const answers = pgTable("answers", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  submissionId: varchar("submission_id").notNull().references(() => submissions.id),
  questionId: varchar("question_id").notNull().references(() => questions.id),
  answerText: text("answer_text").notNull(),
  pointsAwarded: decimal("points_awarded", { precision: 2, scale: 1 }).default("0"),
});

export const answersRelations = relations(answers, ({ one }) => ({
  submission: one(submissions, {
    fields: [answers.submissionId],
    references: [submissions.id],
  }),
  question: one(questions, {
    fields: [answers.questionId],
    references: [questions.id],
  }),
}));

// Insert schemas
export const insertUserSchema = createInsertSchema(users).omit({ id: true, isAdmin: true, isVerified: true, verificationToken: true }).extend({
  email: z.string().email().refine((email) => email.endsWith("@wwt.com"), {
    message: "Only @wwt.com email addresses are allowed",
  }),
  password: z.string().min(6, "Password must be at least 6 characters"),
  name: z.string().min(1, "Name is required"),
});

export const loginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(1, "Password is required"),
});

export const insertTeamSchema = createInsertSchema(teams).omit({ id: true, leadId: true });

export const insertQuestionSchema = createInsertSchema(questions).omit({ id: true });

export const insertWeekSchema = createInsertSchema(weeks).omit({ id: true, isActive: true, isGraded: true, isPublished: true });

export const insertSubmissionSchema = createInsertSchema(submissions).omit({ id: true, submittedAt: true, isGraded: true, totalPoints: true });

export const insertAnswerSchema = createInsertSchema(answers).omit({ id: true, pointsAwarded: true });

// Types
export type User = typeof users.$inferSelect;
export type InsertUser = z.infer<typeof insertUserSchema>;
export type Team = typeof teams.$inferSelect;
export type InsertTeam = z.infer<typeof insertTeamSchema>;
export type TeamMember = typeof teamMembers.$inferSelect;
export type Week = typeof weeks.$inferSelect;
export type InsertWeek = z.infer<typeof insertWeekSchema>;
export type Question = typeof questions.$inferSelect;
export type InsertQuestion = z.infer<typeof insertQuestionSchema>;
export type Submission = typeof submissions.$inferSelect;
export type Answer = typeof answers.$inferSelect;

// Extended types for frontend
export type TeamWithMembers = Team & {
  lead: User;
  members: (TeamMember & { user: User })[];
  memberCount: number;
};

export type WeekWithQuestions = Week & {
  questions: Question[];
};

export type SubmissionWithAnswers = Submission & {
  answers: (Answer & { question: Question })[];
  team: Team;
};

export type LeaderboardEntry = {
  teamId: string;
  teamName: string;
  memberCount: number;
  totalPoints: number;
  rank: number;
};

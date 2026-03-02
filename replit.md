# Tuesday Trivia: Season 6

## Overview

Tuesday Trivia is a corporate team-based trivia competition web application for WWT employees. Teams compete weekly by answering trivia questions, with any team member able to submit answers and admins grading responses. The app features open registration for WWT employees, simple team joining (no approval workflow), weekly trivia rounds, leaderboards, and an admin portal for content management and scoring.

### Team Size Rules
- Teams can have 3 or 4 members (maximum 4)
- Teams of 3 members are **trophy eligible**
- Teams of 4 members can compete but are **not trophy eligible**

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture
- **Framework**: React 18 with TypeScript
- **Routing**: Wouter (lightweight React router)
- **State Management**: TanStack React Query for server state
- **Styling**: Tailwind CSS with CSS variables for theming
- **Component Library**: shadcn/ui (Radix UI primitives with custom styling)
- **Build Tool**: Vite with React plugin

The frontend follows a page-based structure under `client/src/pages/` with shared components in `client/src/components/`. Authentication state is managed via a custom React context (`lib/auth.tsx`).

### Backend Architecture
- **Runtime**: Node.js with Express
- **Language**: TypeScript (compiled with tsx for development, esbuild for production)
- **API Style**: RESTful JSON API under `/api/` prefix
- **Session Management**: express-session with cookie-based authentication

Routes are registered in `server/routes.ts` with middleware for authentication (`requireAuth`) and admin authorization (`requireAdmin`).

### Data Layer
- **ORM**: Drizzle ORM
- **Database**: PostgreSQL (configured via DATABASE_URL environment variable)
- **Schema Location**: `shared/schema.ts` (shared between client and server)
- **Migrations**: Drizzle Kit with migrations output to `./migrations`

The storage layer (`server/storage.ts`) provides a data access abstraction over Drizzle queries.

### Authentication & Authorization
- **Method**: Session-based authentication with bcryptjs password hashing
- **Domain Restriction**: None (open registration for WWT employees)
- **Role System**: Users have `isAdmin` flag for admin access; no team lead concept (any member can submit)
- **First User**: First registered user is automatically made admin

### Key Data Models
- **Users**: Email, password, name, admin status, verification status
- **Teams**: Name; one team per user; 3-4 members allowed
- **Team Members**: Join table linking users to teams (direct join, no approval needed)
- **Weeks**: Trivia rounds with week number, title, `introText` (optional intro paragraph), `deadline` (optional submission deadline), active/archived status
- **Questions**: 10 questions per week with correct answers, configurable `maxPoints` (1-10), and optional `imageUrl`
- **Submissions**: Team answers per week with grading status, tracks `submittedById` to show who submitted
- **Answers**: Individual question responses with `pointsAwarded` (0 to question's maxPoints)
- **Champions**: Hall of Fame entries with year, season, team name, optional team reference, winning score
- **Score Edits**: Audit log for grade changes on closed/published weeks — tracks old/new points, reason, editor, timestamp

## Pages & Routes

### Public Routes
- `/` — Landing page
- `/login` — Login
- `/register` — Registration
- `/forgot-password` — Password reset

### Protected Routes (Authenticated Users)
- `/dashboard` — User dashboard with team status and active week
- `/teams` — Team directory with member names and trophy eligibility
- `/teams/create` — Create a new team
- `/my-team` — Current user's team details
- `/leaderboard` — Season leaderboard with per-week scores
- `/archives` — Past weeks with questions, correct answers, and team's own submissions
- `/hall-of-fame` — Champions from past seasons with crown badges
- `/submit/:weekId` — Submit answers for active week (with countdown timer)
- `/submissions` — View own team's past submissions

### Admin Routes
- `/admin` — Admin dashboard with stats and quick links
- `/admin/weeks` — Manage all trivia weeks
- `/admin/weeks/create` — Create new week with questions and deadline
- `/admin/weeks/:weekId` — View/edit week details
- `/admin/grade/:weekId` — Grade submissions (including re-grading closed weeks with audit log)
- `/admin/leaderboard` — Leaderboard management
- `/admin/champions` — Manage Hall of Fame champion entries

## External Dependencies

### Database
- PostgreSQL database (Replit managed or external via DATABASE_URL)
- connect-pg-simple for session storage

### Frontend Libraries
- @tanstack/react-query for data fetching
- Radix UI components (dialog, dropdown, accordion, etc.)
- react-day-picker for calendar functionality
- embla-carousel-react for carousels
- recharts for data visualization

### Build & Development
- Vite for frontend bundling with HMR
- esbuild for production server bundling
- Replit-specific plugins for development (cartographer, dev-banner, error overlay)

### Environment Variables Required
- `DATABASE_URL`: PostgreSQL connection string
- `SESSION_SECRET`: Secret key for session encryption (optional, has default)

## Completed Features
- User registration and login (open to WWT employees)
- **First user auto-admin**: First registered user becomes admin automatically
- **Password reset flow**: Forgot password page with admin contact fallback
- Team creation with direct joining (no approval needed)
- Team size limits with trophy eligibility display (1-3 members eligible, 4 not)
- **Team directory**: Shows team member names and trophy eligibility for each team
- Weekly trivia submission system (any team member can submit/edit until week closed)
- **Submission tracking**: Shows which team member submitted answers and when
- **Configurable point values**: Each question can have 1-10 max points (e.g., 0/1 for simple, 0-3 for complex)
- **Week intro text**: Optional introduction paragraph displayed on submit page
- **Question images**: Optional image URL for each question displayed on submit page
- **Enhanced grading**: Admin can award 0 to maxPoints per question with slider and quick-select buttons
- **Admin re-grading**: Admin can edit grades on closed/published weeks with required reason and audit trail
- **Admin can view submissions while week is active** (not just after deactivation)
- **Detailed results view**: Shows points earned vs max possible, with color-coded full/partial/wrong indicators
- **Enhanced dashboard**: Displays team submissions with questions and answers prominently
- Admin portal for managing weeks, questions, and grading
- **Enhanced leaderboard**: Shows per-week scores across columns before total
- **Archives with team submissions**: Shows correct answers alongside team's own submissions with color-coded scoring
- **Hall of Fame**: Champions page showing past season winners; crown badge on teams page for past champions
- **Countdown timer**: Admin sets deadline per week; live countdown on submit page; submissions blocked after deadline
- **Score edit audit log**: All grade changes on published weeks are logged with old/new points, reason, and editor
- Navy/Slate/Gold Material Design theme per design_guidelines.md

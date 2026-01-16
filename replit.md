# Tuesday Trivia: Season 10

## Overview

Tuesday Trivia is a corporate team-based trivia competition web application for WWT employees. Teams compete weekly by answering trivia questions, with team leads submitting answers and admins grading responses. The app features user authentication restricted to @wwt.com emails, team management with approval workflows, weekly trivia rounds, leaderboards, and an admin portal for content management and scoring.

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
- **Domain Restriction**: Only @wwt.com email addresses can register
- **Role System**: Users have `isAdmin` flag for admin access; team leads have `isLead` flag in team membership

### Key Data Models
- **Users**: Email, password, name, admin status, verification status
- **Teams**: Name, lead reference; one team per user
- **Team Members**: Join table with approval workflow (isApproved, isLead)
- **Weeks**: Trivia rounds with week number, title, active/archived status
- **Questions**: 10 questions per week with correct answers
- **Submissions**: Team answers per week with grading status
- **Answers**: Individual question responses with points earned

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
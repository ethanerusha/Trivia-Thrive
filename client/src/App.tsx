import { Switch, Route, useLocation } from "wouter";
import { queryClient } from "./lib/queryClient";
import { QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import { AuthProvider, useAuth } from "@/lib/auth";
import { Navbar } from "@/components/layout/navbar";
import NotFound from "@/pages/not-found";
import LandingPage from "@/pages/landing";
import LoginPage from "@/pages/auth/login";
import RegisterPage from "@/pages/auth/register";
import ForgotPasswordPage from "@/pages/auth/forgot-password";
import DashboardPage from "@/pages/dashboard";
import TeamsPage from "@/pages/teams/index";
import CreateTeamPage from "@/pages/teams/create";
import MyTeamPage from "@/pages/my-team";
import LeaderboardPage from "@/pages/leaderboard";
import ArchivesPage from "@/pages/archives";
import SubmitPage from "@/pages/submit";
import SubmissionsPage from "@/pages/submissions";
import AdminDashboardPage from "@/pages/admin/index";
import CreateWeekPage from "@/pages/admin/weeks/create";
import WeekDetailPage from "@/pages/admin/weeks/[weekId]";
import GradePage from "@/pages/admin/grade";
import AdminLeaderboardPage from "@/pages/admin/leaderboard";
import { Loader2 } from "lucide-react";

function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const { user, isLoading } = useAuth();
  const [, setLocation] = useLocation();

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-accent" />
      </div>
    );
  }

  if (!user) {
    setLocation("/login");
    return null;
  }

  return <>{children}</>;
}

function AdminRoute({ children }: { children: React.ReactNode }) {
  const { user, isLoading } = useAuth();
  const [, setLocation] = useLocation();

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-accent" />
      </div>
    );
  }

  if (!user) {
    setLocation("/login");
    return null;
  }

  if (!user.isAdmin) {
    setLocation("/dashboard");
    return null;
  }

  return <>{children}</>;
}

function PublicOnlyRoute({ children }: { children: React.ReactNode }) {
  const { user, isLoading } = useAuth();
  const [, setLocation] = useLocation();

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-accent" />
      </div>
    );
  }

  if (user) {
    setLocation("/dashboard");
    return null;
  }

  return <>{children}</>;
}

function Router() {
  return (
    <Switch>
      <Route path="/">
        <PublicOnlyRoute>
          <LandingPage />
        </PublicOnlyRoute>
      </Route>
      <Route path="/login">
        <PublicOnlyRoute>
          <LoginPage />
        </PublicOnlyRoute>
      </Route>
      <Route path="/register">
        <PublicOnlyRoute>
          <RegisterPage />
        </PublicOnlyRoute>
      </Route>
      <Route path="/forgot-password">
        <PublicOnlyRoute>
          <ForgotPasswordPage />
        </PublicOnlyRoute>
      </Route>
      <Route path="/dashboard">
        <ProtectedRoute>
          <DashboardPage />
        </ProtectedRoute>
      </Route>
      <Route path="/teams">
        <ProtectedRoute>
          <TeamsPage />
        </ProtectedRoute>
      </Route>
      <Route path="/teams/create">
        <ProtectedRoute>
          <CreateTeamPage />
        </ProtectedRoute>
      </Route>
      <Route path="/my-team">
        <ProtectedRoute>
          <MyTeamPage />
        </ProtectedRoute>
      </Route>
      <Route path="/leaderboard">
        <ProtectedRoute>
          <LeaderboardPage />
        </ProtectedRoute>
      </Route>
      <Route path="/archives">
        <ProtectedRoute>
          <ArchivesPage />
        </ProtectedRoute>
      </Route>
      <Route path="/submit/:weekId">
        <ProtectedRoute>
          <SubmitPage />
        </ProtectedRoute>
      </Route>
      <Route path="/submissions">
        <ProtectedRoute>
          <SubmissionsPage />
        </ProtectedRoute>
      </Route>
      <Route path="/admin">
        <AdminRoute>
          <AdminDashboardPage />
        </AdminRoute>
      </Route>
      <Route path="/admin/weeks/create">
        <AdminRoute>
          <CreateWeekPage />
        </AdminRoute>
      </Route>
      <Route path="/admin/weeks/:weekId">
        <AdminRoute>
          <WeekDetailPage />
        </AdminRoute>
      </Route>
      <Route path="/admin/grade/:weekId">
        <AdminRoute>
          <GradePage />
        </AdminRoute>
      </Route>
      <Route path="/admin/leaderboard">
        <AdminRoute>
          <AdminLeaderboardPage />
        </AdminRoute>
      </Route>
      <Route component={NotFound} />
    </Switch>
  );
}

function AppContent() {
  const { user } = useAuth();
  const [location] = useLocation();
  
  const showNavbar = user || !["/", "/login", "/register", "/forgot-password"].includes(location);

  return (
    <>
      {showNavbar && <Navbar />}
      <Router />
    </>
  );
}

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <TooltipProvider>
        <AuthProvider>
          <AppContent />
          <Toaster />
        </AuthProvider>
      </TooltipProvider>
    </QueryClientProvider>
  );
}

export default App;

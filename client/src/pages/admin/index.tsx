import { useQuery } from "@tanstack/react-query";
import { Link } from "wouter";
import { useAuth } from "@/lib/auth";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Shield, Calendar, ClipboardCheck, Trophy, Plus, ArrowRight, Users } from "lucide-react";
import type { Week, LeaderboardEntry } from "@shared/schema";

export default function AdminDashboardPage() {
  const { user } = useAuth();

  const { data: weeks, isLoading: weeksLoading } = useQuery<Week[]>({
    queryKey: ["/api/weeks"],
  });

  const { data: pendingSubmissions, isLoading: submissionsLoading } = useQuery<number>({
    queryKey: ["/api/admin/pending-submissions-count"],
  });

  const { data: stats } = useQuery<{ teamCount: number; userCount: number }>({
    queryKey: ["/api/admin/stats"],
  });

  if (!user?.isAdmin) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <Card className="max-w-md">
          <CardContent className="flex flex-col items-center justify-center py-12">
            <Shield className="h-12 w-12 text-muted-foreground mb-4" />
            <h3 className="text-lg font-semibold mb-2">Access Denied</h3>
            <p className="text-muted-foreground text-center">
              You don't have permission to access the admin portal
            </p>
          </CardContent>
        </Card>
      </div>
    );
  }

  const activeWeek = weeks?.find((w) => w.isActive);
  const ungradedWeeks = weeks?.filter((w) => !w.isGraded && !w.isActive) || [];

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex items-center gap-3 mb-8">
          <Shield className="h-8 w-8 text-accent" />
          <div>
            <h1 className="text-3xl font-bold text-foreground">Admin Portal</h1>
            <p className="text-muted-foreground">Manage Tuesday Trivia: Season 6</p>
          </div>
        </div>

        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4 mb-8">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2 gap-2">
              <CardTitle className="text-sm font-medium">Active Week</CardTitle>
              <Calendar className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              {weeksLoading ? (
                <Skeleton className="h-8 w-24" />
              ) : activeWeek ? (
                <div className="text-2xl font-bold">Week {activeWeek.weekNumber}</div>
              ) : (
                <div className="text-muted-foreground">None</div>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2 gap-2">
              <CardTitle className="text-sm font-medium">Pending Grading</CardTitle>
              <ClipboardCheck className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              {submissionsLoading ? (
                <Skeleton className="h-8 w-16" />
              ) : (
                <div className="text-2xl font-bold">{pendingSubmissions || 0}</div>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2 gap-2">
              <CardTitle className="text-sm font-medium">Total Teams</CardTitle>
              <Users className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{stats?.teamCount || 0}</div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2 gap-2">
              <CardTitle className="text-sm font-medium">Total Users</CardTitle>
              <Users className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{stats?.userCount || 0}</div>
            </CardContent>
          </Card>
        </div>

        <div className="grid gap-6 md:grid-cols-2">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Calendar className="h-5 w-5 text-accent" />
                Manage Weeks
              </CardTitle>
              <CardDescription>Create and manage trivia weeks</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <Link href="/admin/weeks/create">
                <Button className="w-full bg-accent text-accent-foreground hover:bg-accent/90" data-testid="button-create-week">
                  <Plus className="h-4 w-4 mr-2" />
                  Create New Week
                </Button>
              </Link>
              
              {weeksLoading ? (
                <div className="space-y-2">
                  <Skeleton className="h-12 w-full" />
                  <Skeleton className="h-12 w-full" />
                </div>
              ) : weeks && weeks.length > 0 ? (
                <div className="space-y-2">
                  {weeks.slice(0, 5).map((week) => (
                    <Link key={week.id} href={`/admin/weeks/${week.id}`}>
                      <div className="flex items-center justify-between p-3 rounded-lg border hover:bg-muted/50 transition-colors cursor-pointer">
                        <div className="flex items-center gap-3">
                          <Badge variant={week.isActive ? "default" : "secondary"}>
                            Week {week.weekNumber}
                          </Badge>
                          <span className="text-sm truncate max-w-[150px]">{week.title}</span>
                        </div>
                        <div className="flex items-center gap-2">
                          {week.isActive && (
                            <Badge className="bg-success text-success-foreground">Active</Badge>
                          )}
                          {week.isGraded && (
                            <Badge variant="outline">Graded</Badge>
                          )}
                          {week.isPublished && (
                            <Badge className="bg-accent text-accent-foreground">Published</Badge>
                          )}
                          <ArrowRight className="h-4 w-4 text-muted-foreground" />
                        </div>
                      </div>
                    </Link>
                  ))}
                  <Link href="/admin/weeks">
                    <Button variant="ghost" className="w-full" data-testid="link-all-weeks">
                      View All Weeks
                      <ArrowRight className="ml-2 h-4 w-4" />
                    </Button>
                  </Link>
                </div>
              ) : (
                <p className="text-center text-muted-foreground py-4">
                  No weeks created yet
                </p>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <ClipboardCheck className="h-5 w-5 text-accent" />
                Grading Queue
              </CardTitle>
              <CardDescription>Grade pending submissions</CardDescription>
            </CardHeader>
            <CardContent>
              {ungradedWeeks.length > 0 ? (
                <div className="space-y-2">
                  {ungradedWeeks.map((week) => (
                    <Link key={week.id} href={`/admin/grade/${week.id}`}>
                      <div className="flex items-center justify-between p-3 rounded-lg border hover:bg-muted/50 transition-colors cursor-pointer">
                        <div className="flex items-center gap-3">
                          <Badge variant="secondary">Week {week.weekNumber}</Badge>
                          <span className="text-sm">{week.title}</span>
                        </div>
                        <Button size="sm" data-testid={`button-grade-${week.id}`}>
                          Grade
                        </Button>
                      </div>
                    </Link>
                  ))}
                </div>
              ) : (
                <p className="text-center text-muted-foreground py-8">
                  No submissions pending grading
                </p>
              )}
            </CardContent>
          </Card>

          <Card className="md:col-span-2">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Trophy className="h-5 w-5 text-accent" />
                Leaderboard Management
              </CardTitle>
              <CardDescription>Override team points and manage rankings</CardDescription>
            </CardHeader>
            <CardContent>
              <Link href="/admin/leaderboard">
                <Button variant="outline" className="w-full" data-testid="button-manage-leaderboard">
                  <Trophy className="h-4 w-4 mr-2" />
                  Manage Leaderboard
                  <ArrowRight className="ml-2 h-4 w-4" />
                </Button>
              </Link>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
}

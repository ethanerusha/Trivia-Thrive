import { useQuery } from "@tanstack/react-query";
import { Link } from "wouter";
import { useAuth } from "@/lib/auth";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Trophy, Users, ClipboardList, Calendar, ArrowRight, AlertCircle, CheckCircle2 } from "lucide-react";
import type { TeamWithMembers, Week, LeaderboardEntry } from "@shared/schema";

export default function DashboardPage() {
  const { user } = useAuth();

  const { data: myTeam, isLoading: teamLoading } = useQuery<TeamWithMembers | null>({
    queryKey: ["/api/teams/my-team"],
  });

  const { data: activeWeek, isLoading: weekLoading } = useQuery<Week | null>({
    queryKey: ["/api/weeks/active"],
  });

  const { data: leaderboard, isLoading: leaderboardLoading } = useQuery<LeaderboardEntry[]>({
    queryKey: ["/api/leaderboard"],
  });

  const { data: mySubmission } = useQuery({
    queryKey: ["/api/submissions/my-team", activeWeek?.id],
    enabled: !!myTeam && !!activeWeek,
  });

  const isTeamLead = myTeam?.leadId === user?.id;
  const myTeamRank = leaderboard?.find((e) => e.teamId === myTeam?.id);

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-foreground">
            Welcome back, {user?.name?.split(" ")[0]}!
          </h1>
          <p className="text-muted-foreground mt-1">
            Here's what's happening in Tuesday Trivia: Season 10
          </p>
        </div>

        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3 mb-8">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2 gap-2">
              <CardTitle className="text-sm font-medium">My Team</CardTitle>
              <Users className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              {teamLoading ? (
                <Skeleton className="h-8 w-32" />
              ) : myTeam ? (
                <div>
                  <div className="text-2xl font-bold">{myTeam.name}</div>
                  <p className="text-xs text-muted-foreground mt-1">
                    {myTeam.memberCount} member{myTeam.memberCount !== 1 ? "s" : ""}
                    {isTeamLead && (
                      <Badge variant="secondary" className="ml-2 bg-accent/10 text-accent">
                        Team Lead
                      </Badge>
                    )}
                  </p>
                </div>
              ) : (
                <div className="text-muted-foreground text-sm">
                  You're not on a team yet
                </div>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2 gap-2">
              <CardTitle className="text-sm font-medium">Leaderboard Rank</CardTitle>
              <Trophy className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              {leaderboardLoading ? (
                <Skeleton className="h-8 w-20" />
              ) : myTeamRank ? (
                <div>
                  <div className="text-2xl font-bold">
                    #{myTeamRank.rank}
                    {myTeamRank.rank <= 3 && (
                      <span className="ml-2 text-accent">
                        {myTeamRank.rank === 1 ? "🥇" : myTeamRank.rank === 2 ? "🥈" : "🥉"}
                      </span>
                    )}
                  </div>
                  <p className="text-xs text-muted-foreground mt-1">
                    {myTeamRank.totalPoints} points total
                  </p>
                </div>
              ) : (
                <div className="text-muted-foreground text-sm">
                  Join a team to compete
                </div>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2 gap-2">
              <CardTitle className="text-sm font-medium">Current Week</CardTitle>
              <Calendar className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              {weekLoading ? (
                <Skeleton className="h-8 w-24" />
              ) : activeWeek ? (
                <div>
                  <div className="text-2xl font-bold">Week {activeWeek.weekNumber}</div>
                  <p className="text-xs text-muted-foreground mt-1">{activeWeek.title}</p>
                </div>
              ) : (
                <div className="text-muted-foreground text-sm">
                  No active trivia week
                </div>
              )}
            </CardContent>
          </Card>
        </div>

        <div className="grid gap-6 md:grid-cols-2">
          {!myTeam && (
            <Card className="md:col-span-2 border-accent/30">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <AlertCircle className="h-5 w-5 text-accent" />
                  Get Started
                </CardTitle>
                <CardDescription>
                  Join or create a team to participate in Tuesday Trivia
                </CardDescription>
              </CardHeader>
              <CardContent className="flex flex-col sm:flex-row gap-4">
                <Link href="/teams/create" className="flex-1">
                  <Button className="w-full bg-accent text-accent-foreground hover:bg-accent/90" data-testid="button-create-team">
                    Create a Team
                  </Button>
                </Link>
                <Link href="/teams" className="flex-1">
                  <Button variant="outline" className="w-full" data-testid="button-browse-teams">
                    Browse Teams
                  </Button>
                </Link>
              </CardContent>
            </Card>
          )}

          {myTeam && activeWeek && (
            <Card className="border-accent/30">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <ClipboardList className="h-5 w-5 text-accent" />
                  Week {activeWeek.weekNumber} Submission
                </CardTitle>
                <CardDescription>{activeWeek.title}</CardDescription>
              </CardHeader>
              <CardContent>
                {mySubmission ? (
                  <div className="flex items-center gap-2 text-success">
                    <CheckCircle2 className="h-5 w-5" />
                    <span>Answers submitted</span>
                  </div>
                ) : isTeamLead ? (
                  <Link href={`/submit/${activeWeek.id}`}>
                    <Button className="w-full bg-accent text-accent-foreground hover:bg-accent/90" data-testid="button-submit-answers">
                      Submit Answers
                      <ArrowRight className="ml-2 h-4 w-4" />
                    </Button>
                  </Link>
                ) : (
                  <p className="text-muted-foreground text-sm">
                    Only your Team Lead can submit answers
                  </p>
                )}
              </CardContent>
            </Card>
          )}

          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Trophy className="h-5 w-5 text-accent" />
                Top Teams
              </CardTitle>
              <CardDescription>Season 10 Leaderboard</CardDescription>
            </CardHeader>
            <CardContent>
              {leaderboardLoading ? (
                <div className="space-y-2">
                  <Skeleton className="h-10 w-full" />
                  <Skeleton className="h-10 w-full" />
                  <Skeleton className="h-10 w-full" />
                </div>
              ) : leaderboard && leaderboard.length > 0 ? (
                <div className="space-y-2">
                  {leaderboard.slice(0, 5).map((entry) => (
                    <div
                      key={entry.teamId}
                      className={`flex items-center justify-between p-2 rounded-md ${
                        entry.rank === 1
                          ? "bg-accent/10"
                          : entry.rank <= 3
                          ? "bg-muted/50"
                          : ""
                      }`}
                    >
                      <div className="flex items-center gap-3">
                        <span className="font-bold text-lg w-6 text-center">
                          {entry.rank}
                        </span>
                        <span className="font-medium">{entry.teamName}</span>
                      </div>
                      <span className="font-bold text-accent">{entry.totalPoints}</span>
                    </div>
                  ))}
                  <Link href="/leaderboard">
                    <Button variant="ghost" className="w-full mt-2" data-testid="link-full-leaderboard">
                      View Full Leaderboard
                      <ArrowRight className="ml-2 h-4 w-4" />
                    </Button>
                  </Link>
                </div>
              ) : (
                <p className="text-muted-foreground text-sm text-center py-4">
                  No teams on the leaderboard yet
                </p>
              )}
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
}

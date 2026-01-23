import { useQuery } from "@tanstack/react-query";
import { Link } from "wouter";
import { useAuth } from "@/lib/auth";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Trophy, Users, ClipboardList, Calendar, ArrowRight, AlertCircle, CheckCircle2, Edit2, HelpCircle } from "lucide-react";
import type { TeamWithMembers, Week, SubmissionWithAnswers } from "@shared/schema";

export default function DashboardPage() {
  const { user } = useAuth();

  const { data: myTeam, isLoading: teamLoading } = useQuery<TeamWithMembers | null>({
    queryKey: ["/api/teams/my-team"],
  });

  const { data: activeWeek, isLoading: weekLoading } = useQuery<Week | null>({
    queryKey: ["/api/weeks/active"],
  });

  const { data: mySubmission, isLoading: submissionLoading } = useQuery<SubmissionWithAnswers | null>({
    queryKey: ["/api/submissions/my-team", activeWeek?.id],
    enabled: !!myTeam && !!activeWeek,
  });

  const canSubmit = !!myTeam;

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-foreground">
            Welcome back, {user?.name?.split(" ")[0]}!
          </h1>
          <p className="text-muted-foreground mt-1">
            Here's what's happening in Tuesday Trivia: Season 6
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
                    {myTeam.memberCount}/4 members
                    {myTeam.memberCount <= 3 && myTeam.memberCount >= 1 && (
                      <Badge variant="secondary" className="ml-2 bg-accent/10 text-accent">
                        Trophy Eligible
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

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2 gap-2">
              <CardTitle className="text-sm font-medium">Submission Status</CardTitle>
              <ClipboardList className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              {submissionLoading || weekLoading ? (
                <Skeleton className="h-8 w-24" />
              ) : !activeWeek ? (
                <div className="text-muted-foreground text-sm">
                  No active week
                </div>
              ) : mySubmission ? (
                <div className="flex items-center gap-2 text-success">
                  <CheckCircle2 className="h-5 w-5" />
                  <span className="font-semibold">Submitted</span>
                </div>
              ) : (
                <div className="text-muted-foreground text-sm">
                  Not submitted yet
                </div>
              )}
            </CardContent>
          </Card>
        </div>

        <div className="space-y-6">
          {!myTeam && (
            <Card className="border-accent/30">
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
                  <Button className="w-full bg-accent text-accent-foreground" data-testid="button-create-team">
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
                  Week {activeWeek.weekNumber}: {activeWeek.title}
                </CardTitle>
                <CardDescription>
                  {mySubmission 
                    ? `Submitted by ${mySubmission.submittedBy?.name || "a team member"} on ${new Date(mySubmission.submittedAt).toLocaleDateString()}`
                    : "Submit your team's answers below"
                  }
                </CardDescription>
              </CardHeader>
              <CardContent>
                {mySubmission ? (
                  <div className="space-y-4">
                    <div className="bg-muted/50 rounded-lg p-4">
                      <h4 className="font-semibold mb-3 flex items-center gap-2">
                        <CheckCircle2 className="h-4 w-4 text-success" />
                        Your Team's Answers
                      </h4>
                      <div className="space-y-3">
                        {mySubmission.answers
                          .sort((a, b) => a.question.questionNumber - b.question.questionNumber)
                          .map((answer) => (
                            <div key={answer.id} className="flex items-start gap-3 p-3 bg-background rounded-md border">
                              <div className="w-6 h-6 rounded-full bg-primary flex items-center justify-center text-primary-foreground font-bold text-xs flex-shrink-0">
                                {answer.question.questionNumber}
                              </div>
                              <div className="flex-1 min-w-0">
                                <p className="text-sm text-muted-foreground mb-1">{answer.question.questionText}</p>
                                <p className="font-medium">{answer.answerText || <span className="text-muted-foreground italic">No answer</span>}</p>
                              </div>
                            </div>
                          ))}
                      </div>
                    </div>
                    <div className="flex gap-3">
                      <Link href={`/submit/${activeWeek.id}`} className="flex-1">
                        <Button variant="outline" className="w-full" data-testid="button-edit-submission">
                          <Edit2 className="h-4 w-4 mr-2" />
                          Edit Answers
                        </Button>
                      </Link>
                    </div>
                  </div>
                ) : canSubmit ? (
                  <Link href={`/submit/${activeWeek.id}`}>
                    <Button className="w-full bg-accent text-accent-foreground" data-testid="button-submit-answers">
                      Submit Answers
                      <ArrowRight className="ml-2 h-4 w-4" />
                    </Button>
                  </Link>
                ) : null}
              </CardContent>
            </Card>
          )}

          {myTeam && !activeWeek && (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Calendar className="h-12 w-12 text-muted-foreground mb-4" />
                <h3 className="text-lg font-semibold mb-2">No Active Trivia Week</h3>
                <p className="text-muted-foreground text-center mb-4">
                  Check back later for the next round of questions!
                </p>
                <div className="flex gap-3">
                  <Link href="/leaderboard">
                    <Button variant="outline">
                      <Trophy className="h-4 w-4 mr-2" />
                      View Leaderboard
                    </Button>
                  </Link>
                  <Link href="/submissions">
                    <Button variant="outline">
                      <ClipboardList className="h-4 w-4 mr-2" />
                      Past Submissions
                    </Button>
                  </Link>
                </div>
              </CardContent>
            </Card>
          )}

          <div className="grid gap-4 md:grid-cols-2">
            <Link href="/leaderboard">
              <Card className="hover:bg-muted/50 transition-colors cursor-pointer">
                <CardContent className="flex items-center justify-between py-6">
                  <div className="flex items-center gap-3">
                    <Trophy className="h-8 w-8 text-accent" />
                    <div>
                      <p className="font-semibold">Leaderboard</p>
                      <p className="text-sm text-muted-foreground">See team rankings</p>
                    </div>
                  </div>
                  <ArrowRight className="h-5 w-5 text-muted-foreground" />
                </CardContent>
              </Card>
            </Link>
            <Link href="/archives">
              <Card className="hover:bg-muted/50 transition-colors cursor-pointer">
                <CardContent className="flex items-center justify-between py-6">
                  <div className="flex items-center gap-3">
                    <HelpCircle className="h-8 w-8 text-accent" />
                    <div>
                      <p className="font-semibold">Archives</p>
                      <p className="text-sm text-muted-foreground">View past questions</p>
                    </div>
                  </div>
                  <ArrowRight className="h-5 w-5 text-muted-foreground" />
                </CardContent>
              </Card>
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}

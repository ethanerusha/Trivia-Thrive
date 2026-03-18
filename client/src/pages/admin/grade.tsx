import { useState, useEffect } from "react";
import { useParams, Link, useLocation } from "wouter";
import { useQuery, useMutation } from "@tanstack/react-query";
import { apiRequest, queryClient } from "@/lib/queryClient";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Slider } from "@/components/ui/slider";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Textarea } from "@/components/ui/textarea";
import { useToast } from "@/hooks/use-toast";
import { ArrowLeft, CheckCircle2, Loader2, Users, History, AlertTriangle, MinusCircle } from "lucide-react";
import type { SubmissionWithAnswers, WeekWithQuestions, ScoreEditWithDetails, TeamWithMembers } from "@shared/schema";

type GradeData = {
  week: WeekWithQuestions;
  allTeams: TeamWithMembers[];
  submissions: SubmissionWithAnswers[];
};

export default function GradePage() {
  const { weekId } = useParams();
  const [, setLocation] = useLocation();
  const { toast } = useToast();

  // grades keyed by answerId (submitted teams) or questionId (non-submitters)
  const [grades, setGrades] = useState<Record<string, number>>({});
  const [selectedTeamId, setSelectedTeamId] = useState<string | null>(null);
  const [reason, setReason] = useState("");
  const [savingTeamId, setSavingTeamId] = useState<string | null>(null);

  const { data: gradeData, isLoading } = useQuery<GradeData>({
    queryKey: ["/api/admin/weeks", weekId, "grade-data"],
    queryFn: () => fetch(`/api/admin/weeks/${weekId}/grade-data`, { credentials: "include" }).then(r => r.json()),
  });

  const { data: scoreEdits } = useQuery<ScoreEditWithDetails[]>({
    queryKey: ["/api/admin/score-edits", weekId],
  });

  const week = gradeData?.week;
  const allTeams = gradeData?.allTeams ?? [];
  const submissions = gradeData?.submissions ?? [];

  const isRegrade = week?.isGraded || week?.isPublished;

  // Find submission for a team
  const getSubmission = (teamId: string) =>
    submissions.find(s => s.teamId === teamId) ?? null;

  // Initialize grades whenever data loads
  useEffect(() => {
    if (!gradeData) return;
    const initial: Record<string, number> = {};
    // For submitted teams: key = answerId
    for (const sub of gradeData.submissions) {
      for (const answer of sub.answers) {
        initial[answer.id] = parseFloat(answer.pointsAwarded?.toString() || "0");
      }
    }
    // For non-submitting teams: key = `${teamId}:${questionId}` — start at 0
    if (gradeData.week) {
      for (const team of gradeData.allTeams) {
        const hasSubmission = gradeData.submissions.some(s => s.teamId === team.id);
        if (!hasSubmission) {
          for (const q of gradeData.week.questions) {
            const key = `${team.id}:${q.id}`;
            if (initial[key] === undefined) initial[key] = 0;
          }
        }
      }
    }
    setGrades(initial);
    if (!selectedTeamId && gradeData.allTeams.length > 0) {
      setSelectedTeamId(gradeData.allTeams[0].id);
    }
  }, [gradeData]);

  // Grade a submitted team (uses answerId)
  const gradeSubmittedMutation = useMutation({
    mutationFn: async (teamId: string) => {
      const submission = getSubmission(teamId);
      if (!submission) throw new Error("No submission found");
      const gradeData = submission.answers.map(a => ({
        answerId: a.id,
        points: grades[a.id] ?? 0,
      }));
      return await apiRequest("POST", `/api/admin/weeks/${weekId}/grade`, {
        grades: gradeData,
        reason: isRegrade ? reason : undefined,
      });
    },
    onSuccess: () => {
      toast({ title: "Grades saved!", description: isRegrade ? "Scores updated and changes logged." : "Grading complete." });
      queryClient.invalidateQueries({ queryKey: ["/api/admin/weeks", weekId, "grade-data"] });
      queryClient.invalidateQueries({ queryKey: ["/api/admin/score-edits", weekId] });
      queryClient.invalidateQueries({ queryKey: ["/api/leaderboard"] });
      setReason("");
      setSavingTeamId(null);
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Failed to save", description: error.message });
      setSavingTeamId(null);
    },
  });

  // Grade a non-submitting team (uses questionId)
  const gradeNonSubmitterMutation = useMutation({
    mutationFn: async (teamId: string) => {
      if (!week) throw new Error("Week not loaded");
      const questionGrades = week.questions.map(q => ({
        questionId: q.id,
        points: grades[`${teamId}:${q.id}`] ?? 0,
      }));
      return await apiRequest("POST", `/api/admin/weeks/${weekId}/grade-nonsubmitter/${teamId}`, {
        questionGrades,
        reason: isRegrade ? reason : undefined,
      });
    },
    onSuccess: () => {
      toast({ title: "Grades saved!", description: "Admin-entered scores applied for this team." });
      queryClient.invalidateQueries({ queryKey: ["/api/admin/weeks", weekId, "grade-data"] });
      queryClient.invalidateQueries({ queryKey: ["/api/admin/score-edits", weekId] });
      queryClient.invalidateQueries({ queryKey: ["/api/leaderboard"] });
      setReason("");
      setSavingTeamId(null);
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Failed to save", description: error.message });
      setSavingTeamId(null);
    },
  });

  const handleSave = (teamId: string) => {
    if (isRegrade && !reason.trim()) return;
    setSavingTeamId(teamId);
    const submission = getSubmission(teamId);
    if (submission) {
      gradeSubmittedMutation.mutate(teamId);
    } else {
      gradeNonSubmitterMutation.mutate(teamId);
    }
  };

  const calculateTotal = (teamId: string) => {
    const submission = getSubmission(teamId);
    if (submission) {
      return submission.answers.reduce((sum, a) => sum + (grades[a.id] ?? 0), 0);
    }
    if (!week) return 0;
    return week.questions.reduce((sum, q) => sum + (grades[`${teamId}:${q.id}`] ?? 0), 0);
  };

  const isSaving = gradeSubmittedMutation.isPending || gradeNonSubmitterMutation.isPending;

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Skeleton className="h-10 w-48 mb-8" />
          <Skeleton className="h-96 w-full" />
        </div>
      </div>
    );
  }

  if (!week) {
    return (
      <div className="min-h-screen bg-background">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <h3 className="text-lg font-semibold mb-2">Week Not Found</h3>
              <Link href="/admin"><Button variant="outline"><ArrowLeft className="h-4 w-4 mr-2" />Back to Admin</Button></Link>
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  if (allTeams.length === 0) {
    return (
      <div className="min-h-screen bg-background">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Link href="/admin" className="inline-flex items-center text-muted-foreground hover:text-foreground mb-6">
            <ArrowLeft className="h-4 w-4 mr-2" />Back to Admin
          </Link>
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <Users className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2">No Teams Yet</h3>
              <p className="text-muted-foreground text-center">No teams have been created yet.</p>
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  const sortedQuestions = [...(week.questions ?? [])].sort((a, b) => a.questionNumber - b.questionNumber);

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Link href="/admin" className="inline-flex items-center text-muted-foreground hover:text-foreground mb-6">
          <ArrowLeft className="h-4 w-4 mr-2" />Back to Admin
        </Link>

        <div className="mb-8">
          <h1 className="text-3xl font-bold text-foreground" data-testid="text-grade-title">
            {isRegrade ? "Re-grade" : "Grade"} Week {week.weekNumber}
          </h1>
          <p className="text-muted-foreground">{week.title}</p>
          {isRegrade && (
            <div className="flex items-center gap-2 mt-2">
              <AlertTriangle className="h-4 w-4 text-amber-500" />
              <span className="text-sm text-amber-600 dark:text-amber-400">
                This week has already been {week.isPublished ? "published" : "graded"}. Changes will be logged.
              </span>
            </div>
          )}
        </div>

        {isRegrade && (
          <Card className="mb-6">
            <CardHeader>
              <CardTitle className="text-base">Reason for Re-grade</CardTitle>
              <CardDescription>Required when editing grades on a previously graded or published week.</CardDescription>
            </CardHeader>
            <CardContent>
              <Textarea
                value={reason}
                onChange={(e) => setReason(e.target.value)}
                placeholder="Enter the reason for this score change..."
                className="resize-none"
                data-testid="input-regrade-reason"
              />
            </CardContent>
          </Card>
        )}

        <Tabs value={selectedTeamId || undefined} onValueChange={setSelectedTeamId}>
          <TabsList className="mb-6 flex-wrap h-auto gap-1">
            {allTeams.map((team) => {
              const submission = getSubmission(team.id);
              return (
                <TabsTrigger
                  key={team.id}
                  value={team.id}
                  className="data-[state=active]:bg-accent data-[state=active]:text-accent-foreground"
                  data-testid={`tab-team-${team.id}`}
                >
                  {team.name}
                  {!submission && (
                    <MinusCircle className="h-3 w-3 ml-1 text-muted-foreground" />
                  )}
                  <Badge variant="secondary" className="ml-2">
                    {calculateTotal(team.id).toFixed(1)}
                  </Badge>
                </TabsTrigger>
              );
            })}
          </TabsList>

          {allTeams.map((team) => {
            const submission = getSubmission(team.id);
            const isSavingThis = savingTeamId === team.id && isSaving;

            return (
              <TabsContent key={team.id} value={team.id}>
                <Card>
                  <CardHeader>
                    <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                      <div>
                        <CardTitle className="flex items-center gap-2 flex-wrap">
                          {team.name}
                          {submission ? (
                            <Badge>Total: {calculateTotal(team.id).toFixed(1)} pts</Badge>
                          ) : (
                            <Badge variant="outline" className="text-muted-foreground">
                              <MinusCircle className="h-3 w-3 mr-1" />
                              No submission — admin scoring
                            </Badge>
                          )}
                        </CardTitle>
                        <CardDescription>
                          {submission
                            ? `Submitted ${new Date(submission.submittedAt).toLocaleString()}`
                            : "This team did not submit. You can still award points below."}
                        </CardDescription>
                      </div>
                      <Button
                        onClick={() => handleSave(team.id)}
                        disabled={isSavingThis || (isRegrade && !reason.trim())}
                        className="bg-accent text-accent-foreground shrink-0"
                        data-testid={`button-save-grades-${team.id}`}
                      >
                        {isSavingThis ? (
                          <><Loader2 className="mr-2 h-4 w-4 animate-spin" />Saving...</>
                        ) : (
                          <><CheckCircle2 className="mr-2 h-4 w-4" />{isRegrade ? "Save Re-grade" : "Save Grades"}</>
                        )}
                      </Button>
                    </div>
                  </CardHeader>

                  <CardContent className="space-y-6">
                    {sortedQuestions.map((question) => {
                      const answer = submission?.answers.find(a => a.questionId === question.id);
                      const gradeKey = submission ? (answer?.id ?? "") : `${team.id}:${question.id}`;
                      const currentPoints = grades[gradeKey] ?? 0;

                      return (
                        <div key={question.id} className="border rounded-md overflow-hidden">
                          <div className="bg-muted/50 px-4 py-2 flex items-center justify-between gap-2 flex-wrap">
                            <span className="font-medium">Question {question.questionNumber}</span>
                            <Badge variant="outline">
                              {currentPoints.toFixed(1)} / {question.maxPoints} pt{question.maxPoints !== 1 ? "s" : ""}
                            </Badge>
                          </div>
                          <div className="p-4 grid md:grid-cols-2 gap-4">
                            <div>
                              <p className="text-sm font-medium text-muted-foreground mb-1">Question</p>
                              <p className="mb-3">{question.questionText}</p>
                              <p className="text-sm font-medium text-muted-foreground mb-1">Team Answer</p>
                              {answer ? (
                                <p className="p-2 bg-muted/50 rounded-md">{answer.answerText}</p>
                              ) : (
                                <p className="p-2 bg-muted/30 rounded-md text-muted-foreground italic">No answer submitted</p>
                              )}
                            </div>
                            <div>
                              <p className="text-sm font-medium text-muted-foreground mb-1">Correct Answer</p>
                              <p className="p-2 bg-accent/10 rounded-md text-accent font-medium mb-4">
                                {question.correctAnswer}
                              </p>
                              <p className="text-sm font-medium text-muted-foreground mb-2">
                                Points (0–{question.maxPoints})
                              </p>
                              <div className="flex items-center gap-4">
                                <Slider
                                  value={[currentPoints]}
                                  onValueChange={([value]) =>
                                    setGrades(prev => ({ ...prev, [gradeKey]: value }))
                                  }
                                  max={question.maxPoints}
                                  step={question.maxPoints > 1 ? 1 : 0.5}
                                  className="flex-1"
                                  data-testid={`slider-${gradeKey}`}
                                />
                                <span className="font-bold text-lg w-12 text-center">
                                  {currentPoints.toFixed(question.maxPoints > 1 ? 0 : 1)}
                                </span>
                              </div>
                              <div className="flex gap-2 mt-2 flex-wrap">
                                {Array.from({ length: question.maxPoints + 1 }, (_, i) => (
                                  <Button
                                    key={i}
                                    size="sm"
                                    variant={currentPoints === i ? "default" : "outline"}
                                    onClick={() => setGrades(prev => ({ ...prev, [gradeKey]: i }))}
                                    data-testid={`points-btn-${gradeKey}-${i}`}
                                  >
                                    {i}
                                  </Button>
                                ))}
                              </div>
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </CardContent>
                </Card>
              </TabsContent>
            );
          })}
        </Tabs>

        {scoreEdits && scoreEdits.length > 0 && (
          <Card className="mt-8">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <History className="h-5 w-5" />
                Score Edit History
              </CardTitle>
              <CardDescription>Audit log of all score changes for this week</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {scoreEdits.map((edit) => (
                  <div key={edit.id} className="flex flex-col gap-1 border rounded-md p-3" data-testid={`score-edit-${edit.id}`}>
                    <div className="flex items-center justify-between gap-2 flex-wrap">
                      <span className="font-medium text-sm">
                        Q{edit.question?.questionNumber}: {edit.question?.questionText}
                      </span>
                      <div className="flex items-center gap-2">
                        <Badge variant="outline" className="text-destructive">
                          {parseFloat(edit.oldPoints).toFixed(1)}
                        </Badge>
                        <span className="text-muted-foreground text-sm">&rarr;</span>
                        <Badge variant="outline" className="text-accent">
                          {parseFloat(edit.newPoints).toFixed(1)}
                        </Badge>
                      </div>
                    </div>
                    <p className="text-sm text-muted-foreground">Reason: {edit.reason}</p>
                    <p className="text-xs text-muted-foreground">
                      By {edit.editedBy?.name} on {new Date(edit.editedAt).toLocaleString()}
                    </p>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
}

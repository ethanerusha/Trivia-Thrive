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
import { ArrowLeft, CheckCircle2, Loader2, Users, History, AlertTriangle } from "lucide-react";
import type { SubmissionWithAnswers, WeekWithQuestions, ScoreEditWithDetails } from "@shared/schema";

export default function GradePage() {
  const { weekId } = useParams();
  const [, setLocation] = useLocation();
  const { toast } = useToast();

  const [grades, setGrades] = useState<Record<string, number>>({});
  const [selectedSubmission, setSelectedSubmission] = useState<string | null>(null);
  const [reason, setReason] = useState("");

  const { data: week, isLoading: weekLoading } = useQuery<WeekWithQuestions>({
    queryKey: ["/api/weeks", weekId],
  });

  const { data: submissions, isLoading: submissionsLoading } = useQuery<SubmissionWithAnswers[]>({
    queryKey: ["/api/admin/submissions", weekId],
  });

  const { data: scoreEdits } = useQuery<ScoreEditWithDetails[]>({
    queryKey: ["/api/admin/score-edits", weekId],
  });

  const isRegrade = week?.isGraded || week?.isPublished;

  useEffect(() => {
    if (submissions && submissions.length > 0) {
      const initialGrades: Record<string, number> = {};
      submissions.forEach((sub) => {
        sub.answers.forEach((answer) => {
          initialGrades[answer.id] = parseFloat(answer.pointsAwarded?.toString() || "0");
        });
      });
      setGrades(initialGrades);
      if (!selectedSubmission) {
        setSelectedSubmission(submissions[0].id);
      }
    }
  }, [submissions]);

  const gradeMutation = useMutation({
    mutationFn: async () => {
      const gradeData = Object.entries(grades).map(([answerId, points]) => ({
        answerId,
        points,
      }));
      return await apiRequest("POST", `/api/admin/weeks/${weekId}/grade`, { 
        grades: gradeData,
        reason: isRegrade ? reason : undefined,
      });
    },
    onSuccess: () => {
      toast({
        title: "Grading saved!",
        description: isRegrade ? "Scores have been updated and changes logged." : "All submissions have been graded.",
      });
      queryClient.invalidateQueries({ queryKey: ["/api/admin/submissions", weekId] });
      queryClient.invalidateQueries({ queryKey: ["/api/admin/score-edits", weekId] });
      queryClient.invalidateQueries({ queryKey: ["/api/weeks"] });
      queryClient.invalidateQueries({ queryKey: ["/api/leaderboard"] });
      setReason("");
      if (!isRegrade) {
        setLocation(`/admin/weeks/${weekId}`);
      }
    },
    onError: (error: Error) => {
      toast({
        variant: "destructive",
        title: "Grading failed",
        description: error.message,
      });
    },
  });

  const isLoading = weekLoading || submissionsLoading;

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
              <Link href="/admin">
                <Button variant="outline">
                  <ArrowLeft className="h-4 w-4 mr-2" />
                  Back to Admin
                </Button>
              </Link>
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  if (!submissions || submissions.length === 0) {
    return (
      <div className="min-h-screen bg-background">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Link href="/admin" className="inline-flex items-center text-muted-foreground hover:text-foreground mb-6">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Admin
          </Link>
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <Users className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2">No Submissions</h3>
              <p className="text-muted-foreground text-center">
                No teams have submitted answers for Week {week.weekNumber} yet.
              </p>
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  const currentSubmission = submissions.find((s) => s.id === selectedSubmission) || submissions[0];
  const sortedAnswers = [...currentSubmission.answers].sort(
    (a, b) => a.question.questionNumber - b.question.questionNumber
  );

  const calculateTotal = (submissionId: string) => {
    const submission = submissions.find((s) => s.id === submissionId);
    if (!submission) return 0;
    return submission.answers.reduce((sum, answer) => {
      return sum + (grades[answer.id] || 0);
    }, 0);
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Link href="/admin" className="inline-flex items-center text-muted-foreground hover:text-foreground mb-6">
          <ArrowLeft className="h-4 w-4 mr-2" />
          Back to Admin
        </Link>

        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
          <div>
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
          <Button
            onClick={() => gradeMutation.mutate()}
            disabled={gradeMutation.isPending || (isRegrade && !reason.trim())}
            className="bg-accent text-accent-foreground"
            data-testid="button-save-grades"
          >
            {gradeMutation.isPending ? (
              <>
                <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                Saving...
              </>
            ) : (
              <>
                <CheckCircle2 className="mr-2 h-4 w-4" />
                {isRegrade ? "Save Re-grade" : "Save All Grades"}
              </>
            )}
          </Button>
        </div>

        {isRegrade && (
          <Card className="mb-6">
            <CardHeader>
              <CardTitle className="text-base">Reason for Re-grade</CardTitle>
              <CardDescription>
                A reason is required when editing grades on a previously graded or published week.
              </CardDescription>
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

        <Tabs value={selectedSubmission || undefined} onValueChange={setSelectedSubmission}>
          <TabsList className="mb-6 flex-wrap h-auto gap-1">
            {submissions.map((submission) => (
              <TabsTrigger
                key={submission.id}
                value={submission.id}
                className="data-[state=active]:bg-accent data-[state=active]:text-accent-foreground"
              >
                {submission.team.name}
                <Badge variant="secondary" className="ml-2">
                  {calculateTotal(submission.id).toFixed(1)}
                </Badge>
              </TabsTrigger>
            ))}
          </TabsList>

          {submissions.map((submission) => (
            <TabsContent key={submission.id} value={submission.id}>
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    {submission.team.name}
                    <Badge>
                      Total: {calculateTotal(submission.id).toFixed(1)} pts
                    </Badge>
                  </CardTitle>
                  <CardDescription>
                    Submitted {new Date(submission.submittedAt).toLocaleString()}
                  </CardDescription>
                </CardHeader>
                <CardContent className="space-y-6">
                  {sortedAnswers.map((answer) => (
                    <div key={answer.id} className="border rounded-md overflow-hidden">
                      <div className="bg-muted/50 px-4 py-2 flex items-center justify-between gap-2 flex-wrap">
                        <span className="font-medium">Question {answer.question.questionNumber}</span>
                        <Badge variant="outline">
                          {(grades[answer.id] || 0).toFixed(1)} pt
                        </Badge>
                      </div>
                      <div className="p-4 grid md:grid-cols-2 gap-4">
                        <div>
                          <p className="text-sm font-medium text-muted-foreground mb-1">Question</p>
                          <p className="mb-3">{answer.question.questionText}</p>
                          <p className="text-sm font-medium text-muted-foreground mb-1">Team Answer</p>
                          <p className="p-2 bg-muted/50 rounded-md">{answer.answerText}</p>
                        </div>
                        <div>
                          <p className="text-sm font-medium text-muted-foreground mb-1">Correct Answer</p>
                          <p className="p-2 bg-accent/10 rounded-md text-accent font-medium mb-4">
                            {answer.question.correctAnswer}
                          </p>
                          <p className="text-sm font-medium text-muted-foreground mb-2">
                            Points (0-{answer.question.maxPoints})
                          </p>
                          <div className="flex items-center gap-4">
                            <Slider
                              value={[grades[answer.id] || 0]}
                              onValueChange={([value]) =>
                                setGrades((prev) => ({ ...prev, [answer.id]: value }))
                              }
                              max={answer.question.maxPoints}
                              step={answer.question.maxPoints > 1 ? 1 : 0.5}
                              className="flex-1"
                              data-testid={`slider-${answer.id}`}
                            />
                            <span className="font-bold text-lg w-12 text-center">
                              {(grades[answer.id] || 0).toFixed(answer.question.maxPoints > 1 ? 0 : 1)}
                            </span>
                          </div>
                          <div className="flex gap-2 mt-2 flex-wrap">
                            {Array.from({ length: answer.question.maxPoints + 1 }, (_, i) => (
                              <Button
                                key={i}
                                size="sm"
                                variant={grades[answer.id] === i ? "default" : "outline"}
                                onClick={() => setGrades((prev) => ({ ...prev, [answer.id]: i }))}
                              >
                                {i}
                              </Button>
                            ))}
                          </div>
                        </div>
                      </div>
                    </div>
                  ))}
                </CardContent>
              </Card>
            </TabsContent>
          ))}
        </Tabs>

        {scoreEdits && scoreEdits.length > 0 && (
          <Card className="mt-8">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <History className="h-5 w-5" />
                Score Edit History
              </CardTitle>
              <CardDescription>
                Audit log of all score changes for this week
              </CardDescription>
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
                    <p className="text-sm text-muted-foreground">
                      Reason: {edit.reason}
                    </p>
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

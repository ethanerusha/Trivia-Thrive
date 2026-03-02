import { useState, useEffect } from "react";
import { useParams, useLocation, Link } from "wouter";
import { useQuery, useMutation } from "@tanstack/react-query";
import { useAuth } from "@/lib/auth";
import { apiRequest, queryClient } from "@/lib/queryClient";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Skeleton } from "@/components/ui/skeleton";
import { useToast } from "@/hooks/use-toast";
import { ClipboardList, Save, Send, ArrowLeft, Loader2, CheckCircle2, AlertCircle, User, Clock, Ban } from "lucide-react";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";
import type { WeekWithQuestions, TeamWithMembers } from "@shared/schema";

export default function SubmitPage() {
  const { weekId } = useParams();
  const [, setLocation] = useLocation();
  const { user } = useAuth();
  const { toast } = useToast();

  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [timeLeft, setTimeLeft] = useState<{ days: number; hours: number; minutes: number; seconds: number } | null>(null);
  const [isDeadlinePassed, setIsDeadlinePassed] = useState(false);

  const { data: week, isLoading: weekLoading } = useQuery<WeekWithQuestions>({
    queryKey: ["/api/weeks", weekId],
  });

  const { data: myTeam } = useQuery<TeamWithMembers | null>({
    queryKey: ["/api/teams/my-team"],
  });

  const { data: existingSubmission } = useQuery<{
    id: string;
    answers: { questionId: string; answerText: string }[];
    submittedBy?: { id: string; name: string } | null;
    submittedAt: string;
  } | null>({
    queryKey: ["/api/submissions/my-team", weekId],
    enabled: !!weekId && !!myTeam,
  });

  const hasTeam = !!myTeam;

  useEffect(() => {
    if (!week?.deadline) {
      setTimeLeft(null);
      setIsDeadlinePassed(false);
      return;
    }

    const calculateTimeLeft = () => {
      const deadlineTime = new Date(week.deadline!).getTime();
      const now = Date.now();
      const diff = deadlineTime - now;

      if (diff <= 0) {
        setIsDeadlinePassed(true);
        setTimeLeft({ days: 0, hours: 0, minutes: 0, seconds: 0 });
        return;
      }

      setIsDeadlinePassed(false);
      setTimeLeft({
        days: Math.floor(diff / (1000 * 60 * 60 * 24)),
        hours: Math.floor((diff / (1000 * 60 * 60)) % 24),
        minutes: Math.floor((diff / (1000 * 60)) % 60),
        seconds: Math.floor((diff / 1000) % 60),
      });
    };

    calculateTimeLeft();
    const interval = setInterval(calculateTimeLeft, 1000);
    return () => clearInterval(interval);
  }, [week?.deadline]);

  useEffect(() => {
    if (existingSubmission && (existingSubmission as any).answers) {
      const answerMap: Record<string, string> = {};
      (existingSubmission as any).answers.forEach((a: any) => {
        answerMap[a.questionId] = a.answerText;
      });
      setAnswers(answerMap);
    }
  }, [existingSubmission]);

  const submitMutation = useMutation({
    mutationFn: async () => {
      const answerData = Object.entries(answers).map(([questionId, answerText]) => ({
        questionId,
        answerText,
      }));
      return await apiRequest("POST", `/api/submissions`, {
        weekId,
        answers: answerData,
      });
    },
    onSuccess: () => {
      toast({
        title: "Answers submitted!",
        description: "Your team's answers have been recorded.",
      });
      queryClient.invalidateQueries({ queryKey: ["/api/submissions/my-team", weekId] });
      setLocation("/dashboard");
    },
    onError: (error: Error) => {
      toast({
        variant: "destructive",
        title: "Submission failed",
        description: error.message,
      });
    },
  });

  if (!hasTeam) {
    return (
      <div className="min-h-screen bg-background">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <AlertCircle className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2">Join a Team First</h3>
              <p className="text-muted-foreground text-center mb-4">
                You need to be on a team to submit answers
              </p>
              <Link href="/teams">
                <Button variant="outline">
                  <ArrowLeft className="h-4 w-4 mr-2" />
                  Browse Teams
                </Button>
              </Link>
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  if (weekLoading) {
    return (
      <div className="min-h-screen bg-background">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Skeleton className="h-10 w-64 mb-8" />
          <Card>
            <CardContent className="py-8">
              <Skeleton className="h-48 w-full" />
            </CardContent>
          </Card>
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
              <AlertCircle className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2">Week Not Found</h3>
              <Link href="/dashboard">
                <Button variant="outline">
                  <ArrowLeft className="h-4 w-4 mr-2" />
                  Back to Dashboard
                </Button>
              </Link>
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  const sortedQuestions = [...week.questions].sort((a, b) => a.questionNumber - b.questionNumber);
  const answeredCount = Object.values(answers).filter((a) => a.trim()).length;
  const allAnswered = answeredCount === sortedQuestions.length;

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Link href="/dashboard" className="inline-flex items-center text-muted-foreground hover:text-foreground mb-6">
          <ArrowLeft className="h-4 w-4 mr-2" />
          Back to Dashboard
        </Link>

        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
          <div className="flex items-center gap-3">
            <ClipboardList className="h-8 w-8 text-accent" />
            <div>
              <h1 className="text-3xl font-bold text-foreground">Week {week.weekNumber}</h1>
              <p className="text-muted-foreground">{week.title}</p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-sm text-muted-foreground">
              {answeredCount} / {sortedQuestions.length} answered
            </span>
            {allAnswered && <CheckCircle2 className="h-5 w-5 text-success" />}
          </div>
        </div>

        {existingSubmission?.submittedBy && (
          <Card className="mb-6 border-accent/30 bg-accent/5">
            <CardContent className="py-4">
              <div className="flex items-center gap-2 text-sm">
                <User className="h-4 w-4 text-accent" />
                <span>Last submitted by <strong>{existingSubmission.submittedBy.name}</strong></span>
                <span className="text-muted-foreground">
                  on {new Date(existingSubmission.submittedAt).toLocaleDateString()} at {new Date(existingSubmission.submittedAt).toLocaleTimeString()}
                </span>
              </div>
            </CardContent>
          </Card>
        )}

        {week.introText && (
          <Card className="mb-6 bg-muted/30">
            <CardContent className="py-4">
              <p className="text-foreground italic">{week.introText}</p>
            </CardContent>
          </Card>
        )}

        {timeLeft !== null && (
          <Card className={`mb-6 ${isDeadlinePassed ? "border-destructive/50 bg-destructive/5" : "border-accent/30 bg-accent/5"}`}>
            <CardContent className="py-4">
              {isDeadlinePassed ? (
                <div className="flex items-center gap-3" data-testid="status-deadline-passed">
                  <Ban className="h-5 w-5 text-destructive" />
                  <div>
                    <p className="font-semibold text-destructive">Submissions Closed</p>
                    <p className="text-sm text-muted-foreground">The deadline for this week has passed.</p>
                  </div>
                </div>
              ) : (
                <div className="flex flex-col sm:flex-row sm:items-center gap-3" data-testid="status-countdown">
                  <div className="flex items-center gap-2">
                    <Clock className="h-5 w-5 text-accent" />
                    <span className="font-semibold text-foreground">Time Remaining:</span>
                  </div>
                  <div className="flex gap-3">
                    {timeLeft.days > 0 && (
                      <div className="text-center">
                        <span className="text-2xl font-bold text-foreground" data-testid="text-countdown-days">{timeLeft.days}</span>
                        <p className="text-xs text-muted-foreground">days</p>
                      </div>
                    )}
                    <div className="text-center">
                      <span className="text-2xl font-bold text-foreground" data-testid="text-countdown-hours">{String(timeLeft.hours).padStart(2, "0")}</span>
                      <p className="text-xs text-muted-foreground">hours</p>
                    </div>
                    <div className="text-center">
                      <span className="text-2xl font-bold text-foreground" data-testid="text-countdown-minutes">{String(timeLeft.minutes).padStart(2, "0")}</span>
                      <p className="text-xs text-muted-foreground">min</p>
                    </div>
                    <div className="text-center">
                      <span className="text-2xl font-bold text-foreground" data-testid="text-countdown-seconds">{String(timeLeft.seconds).padStart(2, "0")}</span>
                      <p className="text-xs text-muted-foreground">sec</p>
                    </div>
                  </div>
                </div>
              )}
            </CardContent>
          </Card>
        )}

        {isDeadlinePassed ? (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <Ban className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2">Submissions Closed</h3>
              <p className="text-muted-foreground text-center mb-4">
                The deadline for this week has passed. You can no longer submit or update answers.
              </p>
              <Link href="/dashboard">
                <Button variant="outline">
                  <ArrowLeft className="h-4 w-4 mr-2" />
                  Back to Dashboard
                </Button>
              </Link>
            </CardContent>
          </Card>
        ) : (
        <>
        <div className="space-y-6 mb-8">
          {sortedQuestions.map((question) => (
            <Card key={question.id}>
              <CardHeader className="pb-3">
                <div className="flex items-start gap-3">
                  <div className="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-primary-foreground font-bold flex-shrink-0">
                    {question.questionNumber}
                  </div>
                  <div className="flex-1">
                    <CardTitle className="text-lg">{question.questionText}</CardTitle>
                    {question.imageUrl && (
                      <img 
                        src={question.imageUrl} 
                        alt={`Question ${question.questionNumber}`}
                        className="mt-3 max-w-full h-auto rounded-lg max-h-64 object-contain"
                      />
                    )}
                  </div>
                </div>
              </CardHeader>
              <CardContent>
                <Label htmlFor={`answer-${question.id}`} className="sr-only">
                  Your answer
                </Label>
                <Textarea
                  id={`answer-${question.id}`}
                  placeholder="Enter your team's answer..."
                  className="min-h-[100px] resize-none"
                  value={answers[question.id] || ""}
                  onChange={(e) =>
                    setAnswers((prev) => ({ ...prev, [question.id]: e.target.value }))
                  }
                  data-testid={`textarea-answer-${question.questionNumber}`}
                />
              </CardContent>
            </Card>
          ))}
        </div>

        <Card className="sticky bottom-4">
          <CardContent className="py-4">
            <div className="flex flex-col sm:flex-row gap-4 items-center justify-between">
              <p className="text-sm text-muted-foreground">
                {existingSubmission ? "Update your previous submission" : "Submit your answers for grading"}
              </p>
              <AlertDialog>
                <AlertDialogTrigger asChild>
                  <Button
                    className="w-full sm:w-auto bg-accent text-accent-foreground"
                    disabled={!allAnswered || submitMutation.isPending}
                    data-testid="button-submit-answers"
                  >
                    {submitMutation.isPending ? (
                      <>
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                        Submitting...
                      </>
                    ) : (
                      <>
                        <Send className="mr-2 h-4 w-4" />
                        Submit Answers
                      </>
                    )}
                  </Button>
                </AlertDialogTrigger>
                <AlertDialogContent>
                  <AlertDialogHeader>
                    <AlertDialogTitle>Submit answers?</AlertDialogTitle>
                    <AlertDialogDescription>
                      Are you sure you want to submit your team's answers? You can update them until the week is closed.
                    </AlertDialogDescription>
                  </AlertDialogHeader>
                  <AlertDialogFooter>
                    <AlertDialogCancel>Review Answers</AlertDialogCancel>
                    <AlertDialogAction
                      className="bg-accent text-accent-foreground"
                      onClick={() => submitMutation.mutate()}
                    >
                      Submit
                    </AlertDialogAction>
                  </AlertDialogFooter>
                </AlertDialogContent>
              </AlertDialog>
            </div>
          </CardContent>
        </Card>
        </>
        )}
      </div>
    </div>
  );
}

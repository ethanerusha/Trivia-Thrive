import { useParams, Link, useLocation } from "wouter";
import { useQuery, useMutation } from "@tanstack/react-query";
import { apiRequest, queryClient } from "@/lib/queryClient";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { useToast } from "@/hooks/use-toast";
import { ArrowLeft, Calendar, Play, Pause, CheckCircle2, Eye, Loader2 } from "lucide-react";
import type { WeekWithQuestions } from "@shared/schema";
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

export default function WeekDetailPage() {
  const { weekId } = useParams();
  const [, setLocation] = useLocation();
  const { toast } = useToast();

  const { data: week, isLoading } = useQuery<WeekWithQuestions>({
    queryKey: ["/api/weeks", weekId],
  });

  const activateMutation = useMutation({
    mutationFn: async () => {
      return await apiRequest("POST", `/api/admin/weeks/${weekId}/activate`);
    },
    onSuccess: () => {
      toast({ title: "Week activated!" });
      queryClient.invalidateQueries({ queryKey: ["/api/weeks"] });
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Error", description: error.message });
    },
  });

  const deactivateMutation = useMutation({
    mutationFn: async () => {
      return await apiRequest("POST", `/api/admin/weeks/${weekId}/deactivate`);
    },
    onSuccess: () => {
      toast({ title: "Week deactivated" });
      queryClient.invalidateQueries({ queryKey: ["/api/weeks"] });
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Error", description: error.message });
    },
  });

  const publishMutation = useMutation({
    mutationFn: async () => {
      return await apiRequest("POST", `/api/admin/weeks/${weekId}/publish`);
    },
    onSuccess: () => {
      toast({ title: "Scores published!", description: "Results are now visible to all teams." });
      queryClient.invalidateQueries({ queryKey: ["/api/weeks"] });
      queryClient.invalidateQueries({ queryKey: ["/api/leaderboard"] });
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Error", description: error.message });
    },
  });

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Skeleton className="h-10 w-48 mb-8" />
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

  const sortedQuestions = [...week.questions].sort((a, b) => a.questionNumber - b.questionNumber);

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Link href="/admin" className="inline-flex items-center text-muted-foreground hover:text-foreground mb-6">
          <ArrowLeft className="h-4 w-4 mr-2" />
          Back to Admin
        </Link>

        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
          <div className="flex items-center gap-3">
            <Calendar className="h-8 w-8 text-accent" />
            <div>
              <h1 className="text-3xl font-bold text-foreground flex items-center gap-3 flex-wrap">
                Week {week.weekNumber}
                {week.isActive && <Badge className="bg-success text-success-foreground">Active</Badge>}
                {week.isGraded && <Badge variant="outline">Graded</Badge>}
                {week.isPublished && <Badge className="bg-accent text-accent-foreground">Published</Badge>}
              </h1>
              <p className="text-muted-foreground">{week.title}</p>
            </div>
          </div>
        </div>

        <div className="grid gap-4 sm:grid-cols-3 mb-8">
          {!week.isActive && !week.isGraded && (
            <Button
              onClick={() => activateMutation.mutate()}
              disabled={activateMutation.isPending}
              className="bg-success text-success-foreground hover:bg-success/90"
              data-testid="button-activate"
            >
              {activateMutation.isPending ? (
                <Loader2 className="h-4 w-4 mr-2 animate-spin" />
              ) : (
                <Play className="h-4 w-4 mr-2" />
              )}
              Activate Week
            </Button>
          )}
          
          {week.isActive && (
            <AlertDialog>
              <AlertDialogTrigger asChild>
                <Button variant="outline" data-testid="button-deactivate">
                  <Pause className="h-4 w-4 mr-2" />
                  Deactivate
                </Button>
              </AlertDialogTrigger>
              <AlertDialogContent>
                <AlertDialogHeader>
                  <AlertDialogTitle>Deactivate week?</AlertDialogTitle>
                  <AlertDialogDescription>
                    This will close submissions. Teams will no longer be able to submit answers.
                  </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                  <AlertDialogCancel>Cancel</AlertDialogCancel>
                  <AlertDialogAction onClick={() => deactivateMutation.mutate()}>
                    Deactivate
                  </AlertDialogAction>
                </AlertDialogFooter>
              </AlertDialogContent>
            </AlertDialog>
          )}

          {!week.isActive && !week.isGraded && (
            <Link href={`/admin/grade/${week.id}`}>
              <Button variant="outline" className="w-full" data-testid="button-grade">
                <CheckCircle2 className="h-4 w-4 mr-2" />
                Grade Submissions
              </Button>
            </Link>
          )}

          {week.isGraded && !week.isPublished && (
            <AlertDialog>
              <AlertDialogTrigger asChild>
                <Button className="bg-accent text-accent-foreground hover:bg-accent/90" data-testid="button-publish">
                  <Eye className="h-4 w-4 mr-2" />
                  Publish Scores
                </Button>
              </AlertDialogTrigger>
              <AlertDialogContent>
                <AlertDialogHeader>
                  <AlertDialogTitle>Publish scores?</AlertDialogTitle>
                  <AlertDialogDescription>
                    This will make results visible to all teams and update the leaderboard.
                  </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                  <AlertDialogCancel>Cancel</AlertDialogCancel>
                  <AlertDialogAction
                    className="bg-accent text-accent-foreground hover:bg-accent/90"
                    onClick={() => publishMutation.mutate()}
                  >
                    Publish
                  </AlertDialogAction>
                </AlertDialogFooter>
              </AlertDialogContent>
            </AlertDialog>
          )}
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Questions</CardTitle>
            <CardDescription>{sortedQuestions.length} questions</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            {sortedQuestions.map((question) => (
              <div key={question.id} className="border rounded-lg p-4 space-y-2">
                <div className="flex items-start gap-3">
                  <div className="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-primary-foreground font-bold text-sm flex-shrink-0">
                    {question.questionNumber}
                  </div>
                  <div className="flex-1">
                    <p className="font-medium">{question.questionText}</p>
                    <p className="text-sm text-accent mt-2">
                      <span className="text-muted-foreground">Answer: </span>
                      {question.correctAnswer}
                    </p>
                  </div>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}

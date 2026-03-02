import { useState } from "react";
import { useParams, Link, useLocation } from "wouter";
import { useQuery, useMutation } from "@tanstack/react-query";
import { apiRequest, queryClient } from "@/lib/queryClient";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { ArrowLeft, Calendar, Play, Pause, CheckCircle2, Eye, Loader2, Pencil, Trash2, Image, Clock } from "lucide-react";
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
  const [isEditing, setIsEditing] = useState(false);
  const [editData, setEditData] = useState<{
    weekNumber: number;
    title: string;
    introText: string;
    deadline: string;
    questions: { questionText: string; correctAnswer: string; maxPoints: number; imageUrl?: string }[];
  } | null>(null);

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

  const updateMutation = useMutation({
    mutationFn: async (data: typeof editData) => {
      return await apiRequest("PUT", `/api/admin/weeks/${weekId}`, data);
    },
    onSuccess: () => {
      toast({ title: "Week updated!" });
      setIsEditing(false);
      setEditData(null);
      queryClient.invalidateQueries({ queryKey: ["/api/weeks"] });
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Update failed", description: error.message });
    },
  });

  const deleteMutation = useMutation({
    mutationFn: async () => {
      return await apiRequest("DELETE", `/api/admin/weeks/${weekId}`);
    },
    onSuccess: () => {
      toast({ title: "Week deleted" });
      setLocation("/admin");
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Delete failed", description: error.message });
    },
  });

  const handleStartEdit = () => {
    if (week) {
      const sortedQuestions = [...week.questions].sort((a, b) => a.questionNumber - b.questionNumber);
      const deadlineValue = week.deadline 
        ? new Date(week.deadline).toISOString().slice(0, 16)
        : "";
      setEditData({
        weekNumber: week.weekNumber,
        title: week.title,
        introText: week.introText || "",
        deadline: deadlineValue,
        questions: sortedQuestions.map(q => ({
          questionText: q.questionText,
          correctAnswer: q.correctAnswer,
          maxPoints: q.maxPoints || 1,
          imageUrl: q.imageUrl || "",
        })),
      });
      setIsEditing(true);
    }
  };

  const handleSaveEdit = () => {
    if (editData) {
      updateMutation.mutate(editData);
    }
  };

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
  const hasSubmissions = false;

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
              {week.deadline && (
                <p className="text-sm text-muted-foreground flex items-center gap-1 mt-1">
                  <Clock className="h-3 w-3" />
                  Deadline: {new Date(week.deadline).toLocaleString()}
                </p>
              )}
            </div>
          </div>
          <div className="flex gap-2">
            {!week.isGraded && !week.isPublished && (
              <Button variant="outline" onClick={handleStartEdit} data-testid="button-edit-week">
                <Pencil className="h-4 w-4 mr-2" />
                Edit
              </Button>
            )}
            {!week.isActive && !week.isGraded && (
              <AlertDialog>
                <AlertDialogTrigger asChild>
                  <Button variant="outline" className="text-destructive" data-testid="button-delete-week">
                    <Trash2 className="h-4 w-4 mr-2" />
                    Delete
                  </Button>
                </AlertDialogTrigger>
                <AlertDialogContent>
                  <AlertDialogHeader>
                    <AlertDialogTitle>Delete Week {week.weekNumber}?</AlertDialogTitle>
                    <AlertDialogDescription>
                      This will permanently delete this week and all associated questions and submissions. This action cannot be undone.
                    </AlertDialogDescription>
                  </AlertDialogHeader>
                  <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <AlertDialogAction 
                      className="bg-destructive text-destructive-foreground"
                      onClick={() => deleteMutation.mutate()}
                    >
                      {deleteMutation.isPending ? <Loader2 className="h-4 w-4 animate-spin" /> : "Delete"}
                    </AlertDialogAction>
                  </AlertDialogFooter>
                </AlertDialogContent>
              </AlertDialog>
            )}
          </div>
        </div>

        <div className="grid gap-4 sm:grid-cols-3 mb-8">
          {!week.isActive && !week.isGraded && (
            <Button
              onClick={() => activateMutation.mutate()}
              disabled={activateMutation.isPending}
              className="bg-success text-success-foreground"
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

          <Link href={`/admin/grade/${week.id}`}>
            <Button variant="outline" className="w-full" data-testid="button-grade">
              <CheckCircle2 className="h-4 w-4 mr-2" />
              {week.isGraded ? "View Grading" : "Grade Submissions"}
            </Button>
          </Link>

          {week.isGraded && !week.isPublished && (
            <AlertDialog>
              <AlertDialogTrigger asChild>
                <Button className="bg-accent text-accent-foreground" data-testid="button-publish">
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
                    className="bg-accent text-accent-foreground"
                    onClick={() => publishMutation.mutate()}
                  >
                    Publish
                  </AlertDialogAction>
                </AlertDialogFooter>
              </AlertDialogContent>
            </AlertDialog>
          )}
        </div>

        {isEditing && editData ? (
          <Card>
            <CardHeader>
              <CardTitle>Edit Week</CardTitle>
              <CardDescription>Update week details and questions</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="grid gap-4 sm:grid-cols-2">
                <div className="space-y-2">
                  <Label htmlFor="weekNumber">Week Number</Label>
                  <Input
                    id="weekNumber"
                    type="number"
                    value={editData.weekNumber}
                    onChange={(e) => setEditData({ ...editData, weekNumber: parseInt(e.target.value) || 1 })}
                    data-testid="input-week-number"
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="title">Title</Label>
                  <Input
                    id="title"
                    value={editData.title}
                    onChange={(e) => setEditData({ ...editData, title: e.target.value })}
                    data-testid="input-title"
                  />
                </div>
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="introText">Intro Paragraph (Optional)</Label>
                <Textarea
                  id="introText"
                  value={editData.introText}
                  onChange={(e) => setEditData({ ...editData, introText: e.target.value })}
                  placeholder="Add an introduction message for this week's trivia..."
                  rows={3}
                  data-testid="input-intro"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="deadline" className="flex items-center gap-2">
                  <Clock className="h-4 w-4" />
                  Submission Deadline (Optional)
                </Label>
                <Input
                  id="deadline"
                  type="datetime-local"
                  value={editData.deadline}
                  onChange={(e) => setEditData({ ...editData, deadline: e.target.value })}
                  data-testid="input-deadline"
                />
              </div>

              <div className="space-y-4">
                <h3 className="font-semibold">Questions</h3>
                {editData.questions.map((q, index) => (
                  <div key={index} className="border rounded-lg p-4 space-y-3">
                    <div className="flex items-center gap-2 mb-2">
                      <div className="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-primary-foreground font-bold text-sm">
                        {index + 1}
                      </div>
                      <span className="font-medium">Question {index + 1}</span>
                    </div>
                    <Textarea
                      value={q.questionText}
                      onChange={(e) => {
                        const newQuestions = [...editData.questions];
                        newQuestions[index].questionText = e.target.value;
                        setEditData({ ...editData, questions: newQuestions });
                      }}
                      placeholder="Question text"
                      rows={2}
                    />
                    <div className="grid gap-4 sm:grid-cols-3">
                      <div className="sm:col-span-2">
                        <Input
                          value={q.correctAnswer}
                          onChange={(e) => {
                            const newQuestions = [...editData.questions];
                            newQuestions[index].correctAnswer = e.target.value;
                            setEditData({ ...editData, questions: newQuestions });
                          }}
                          placeholder="Correct answer"
                        />
                      </div>
                      <div>
                        <Input
                          type="number"
                          min="1"
                          max="10"
                          value={q.maxPoints}
                          onChange={(e) => {
                            const newQuestions = [...editData.questions];
                            newQuestions[index].maxPoints = parseInt(e.target.value) || 1;
                            setEditData({ ...editData, questions: newQuestions });
                          }}
                          placeholder="Max points"
                        />
                      </div>
                    </div>
                    <div className="flex items-center gap-2">
                      <Image className="h-4 w-4 text-muted-foreground" />
                      <Input
                        value={q.imageUrl || ""}
                        onChange={(e) => {
                          const newQuestions = [...editData.questions];
                          newQuestions[index].imageUrl = e.target.value;
                          setEditData({ ...editData, questions: newQuestions });
                        }}
                        placeholder="Image URL (optional)"
                      />
                    </div>
                  </div>
                ))}
              </div>

              <div className="flex gap-3">
                <Button
                  onClick={handleSaveEdit}
                  disabled={updateMutation.isPending}
                  className="bg-accent text-accent-foreground"
                  data-testid="button-save-edit"
                >
                  {updateMutation.isPending ? <Loader2 className="h-4 w-4 mr-2 animate-spin" /> : null}
                  Save Changes
                </Button>
                <Button variant="outline" onClick={() => { setIsEditing(false); setEditData(null); }}>
                  Cancel
                </Button>
              </div>
            </CardContent>
          </Card>
        ) : (
          <Card>
            <CardHeader>
              <CardTitle>Questions</CardTitle>
              <CardDescription>{sortedQuestions.length} questions</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              {week.introText && (
                <div className="bg-muted/50 p-4 rounded-lg mb-4">
                  <p className="text-muted-foreground italic">{week.introText}</p>
                </div>
              )}
              {sortedQuestions.map((question) => (
                <div key={question.id} className="border rounded-lg p-4 space-y-2">
                  <div className="flex items-start gap-3">
                    <div className="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-primary-foreground font-bold text-sm flex-shrink-0">
                      {question.questionNumber}
                    </div>
                    <div className="flex-1">
                      <p className="font-medium">{question.questionText}</p>
                      {question.imageUrl && (
                        <img 
                          src={question.imageUrl} 
                          alt={`Question ${question.questionNumber}`}
                          className="mt-2 max-w-full h-auto rounded-lg max-h-48 object-contain"
                        />
                      )}
                      <div className="flex items-center justify-between mt-2">
                        <p className="text-sm text-accent">
                          <span className="text-muted-foreground">Answer: </span>
                          {question.correctAnswer}
                        </p>
                        <Badge variant="outline" className="text-xs">
                          {question.maxPoints || 1} pt{(question.maxPoints || 1) > 1 ? "s" : ""}
                        </Badge>
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
}

import { useQuery } from "@tanstack/react-query";
import { Link } from "wouter";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { Badge } from "@/components/ui/badge";
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from "@/components/ui/accordion";
import { ClipboardList, CheckCircle2, XCircle, Clock, HelpCircle } from "lucide-react";
import type { SubmissionWithAnswers, Week } from "@shared/schema";

export default function SubmissionsPage() {
  const { data: submissions, isLoading } = useQuery<SubmissionWithAnswers[]>({
    queryKey: ["/api/submissions/my-team"],
  });

  const { data: weeks } = useQuery<Week[]>({
    queryKey: ["/api/weeks"],
  });

  const getWeekInfo = (weekId: string) => {
    return weeks?.find((w) => w.id === weekId);
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex items-center gap-3 mb-8">
          <ClipboardList className="h-8 w-8 text-accent" />
          <div>
            <h1 className="text-3xl font-bold text-foreground">My Submissions</h1>
            <p className="text-muted-foreground">View your team's answers and results</p>
          </div>
        </div>

        {isLoading ? (
          <div className="space-y-4">
            {[1, 2, 3].map((i) => (
              <Card key={i}>
                <CardHeader>
                  <Skeleton className="h-6 w-32" />
                  <Skeleton className="h-4 w-48" />
                </CardHeader>
                <CardContent>
                  <Skeleton className="h-24 w-full" />
                </CardContent>
              </Card>
            ))}
          </div>
        ) : submissions && submissions.length > 0 ? (
          <Accordion type="single" collapsible className="space-y-4">
            {submissions.map((submission) => {
              const week = getWeekInfo(submission.weekId);
              const totalPoints = parseFloat(submission.totalPoints?.toString() || "0");
              
              return (
                <AccordionItem key={submission.id} value={submission.id} className="border rounded-lg overflow-hidden">
                  <AccordionTrigger className="px-6 py-4 hover:no-underline hover:bg-muted/50 data-[state=open]:bg-muted/50">
                    <div className="flex items-center justify-between w-full mr-4">
                      <div className="flex items-center gap-3">
                        <Badge variant="secondary" className="bg-primary text-primary-foreground">
                          Week {week?.weekNumber || "?"}
                        </Badge>
                        <span className="font-semibold">{week?.title || "Trivia Week"}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        {submission.isGraded ? (
                          <Badge className="bg-accent text-accent-foreground">
                            {totalPoints} pts
                          </Badge>
                        ) : (
                          <Badge variant="outline" className="text-muted-foreground">
                            <Clock className="h-3 w-3 mr-1" />
                            Pending
                          </Badge>
                        )}
                      </div>
                    </div>
                  </AccordionTrigger>
                  <AccordionContent className="px-6 pb-4">
                    <div className="space-y-4 pt-2">
                      {submission.answers
                        .sort((a, b) => a.question.questionNumber - b.question.questionNumber)
                        .map((answer) => {
                          const points = parseFloat(answer.pointsAwarded?.toString() || "0");
                          const isCorrect = submission.isGraded && points > 0;
                          const isWrong = submission.isGraded && points === 0;

                          return (
                            <div key={answer.id} className="border rounded-lg overflow-hidden">
                              <div className="bg-muted/50 px-4 py-2 flex items-center justify-between">
                                <div className="flex items-center gap-2">
                                  <HelpCircle className="h-4 w-4 text-accent" />
                                  <span className="text-sm font-medium">
                                    Question {answer.question.questionNumber}
                                  </span>
                                </div>
                                {submission.isGraded && (
                                  <Badge
                                    variant={isCorrect ? "default" : "secondary"}
                                    className={isCorrect ? "bg-success text-success-foreground" : ""}
                                  >
                                    {points} pt{points !== 1 ? "s" : ""}
                                  </Badge>
                                )}
                              </div>
                              <div className="p-4 space-y-3">
                                <p className="text-foreground font-medium">
                                  {answer.question.questionText}
                                </p>
                                
                                <div className={`flex items-start gap-2 p-3 rounded-md ${
                                  submission.isGraded
                                    ? isCorrect
                                      ? "bg-success/10"
                                      : "bg-destructive/10"
                                    : "bg-muted/50"
                                }`}>
                                  {submission.isGraded ? (
                                    isCorrect ? (
                                      <CheckCircle2 className="h-4 w-4 text-success mt-0.5 flex-shrink-0" />
                                    ) : (
                                      <XCircle className="h-4 w-4 text-destructive mt-0.5 flex-shrink-0" />
                                    )
                                  ) : (
                                    <Clock className="h-4 w-4 text-muted-foreground mt-0.5 flex-shrink-0" />
                                  )}
                                  <div>
                                    <p className="text-xs font-medium text-muted-foreground mb-1">
                                      Your Answer
                                    </p>
                                    <p className={
                                      submission.isGraded
                                        ? isCorrect
                                          ? "text-success font-medium"
                                          : "text-destructive font-medium"
                                        : ""
                                    }>
                                      {answer.answerText}
                                    </p>
                                  </div>
                                </div>

                                {submission.isGraded && (
                                  <div className="flex items-start gap-2 p-3 bg-accent/10 rounded-md">
                                    <CheckCircle2 className="h-4 w-4 text-accent mt-0.5 flex-shrink-0" />
                                    <div>
                                      <p className="text-xs font-medium text-muted-foreground mb-1">
                                        Correct Answer
                                      </p>
                                      <p className="text-accent font-medium">
                                        {answer.question.correctAnswer}
                                      </p>
                                    </div>
                                  </div>
                                )}
                              </div>
                            </div>
                          );
                        })}
                    </div>
                  </AccordionContent>
                </AccordionItem>
              );
            })}
          </Accordion>
        ) : (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <ClipboardList className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2">No Submissions Yet</h3>
              <p className="text-muted-foreground text-center mb-4">
                Your team hasn't submitted any answers yet
              </p>
              <Link href="/dashboard">
                <Button variant="outline">Go to Dashboard</Button>
              </Link>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
}

import { useQuery } from "@tanstack/react-query";
import { Card, CardContent } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { Badge } from "@/components/ui/badge";
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from "@/components/ui/accordion";
import { Archive, CheckCircle2, HelpCircle, XCircle, MinusCircle } from "lucide-react";
import type { ArchivedWeekWithSubmission } from "@shared/schema";

function getPointsIndicator(pointsAwarded: number, maxPoints: number) {
  if (pointsAwarded >= maxPoints) {
    return { color: "text-green-600 dark:text-green-400", bg: "bg-green-50 dark:bg-green-950/30", icon: CheckCircle2, label: "Full points" };
  }
  if (pointsAwarded > 0) {
    return { color: "text-yellow-600 dark:text-yellow-400", bg: "bg-yellow-50 dark:bg-yellow-950/30", icon: MinusCircle, label: "Partial points" };
  }
  return { color: "text-red-600 dark:text-red-400", bg: "bg-red-50 dark:bg-red-950/30", icon: XCircle, label: "No points" };
}

export default function ArchivesPage() {
  const { data: weeks, isLoading } = useQuery<ArchivedWeekWithSubmission[]>({
    queryKey: ["/api/weeks/archived/with-submissions"],
  });

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex items-center gap-3 mb-8">
          <Archive className="h-8 w-8 text-accent" />
          <div>
            <h1 className="text-3xl font-bold text-foreground" data-testid="text-archives-title">Past Questions</h1>
            <p className="text-muted-foreground">Review previous trivia weeks and your team's answers</p>
          </div>
        </div>

        {isLoading ? (
          <div className="space-y-4">
            {[1, 2, 3].map((i) => (
              <Card key={i}>
                <div className="p-6">
                  <Skeleton className="h-6 w-32 mb-2" />
                  <Skeleton className="h-4 w-48 mb-4" />
                  <Skeleton className="h-24 w-full" />
                </div>
              </Card>
            ))}
          </div>
        ) : weeks && weeks.length > 0 ? (
          <Accordion type="single" collapsible className="space-y-4">
            {weeks.map((week) => {
              const submission = week.teamSubmission;
              const totalEarned = submission
                ? submission.answers.reduce((sum, a) => sum + parseFloat(a.pointsAwarded?.toString() || "0"), 0)
                : 0;
              const totalMax = week.questions.reduce((sum, q) => sum + (q.maxPoints || 1), 0);

              return (
                <AccordionItem key={week.id} value={week.id} className="border rounded-md" data-testid={`accordion-week-${week.id}`}>
                  <AccordionTrigger className="px-6 py-4 hover:no-underline hover:bg-muted/50 data-[state=open]:bg-muted/50">
                    <div className="flex items-center justify-between gap-3 w-full mr-4 flex-wrap">
                      <div className="flex items-center gap-3 flex-wrap">
                        <Badge variant="secondary" className="bg-primary text-primary-foreground">
                          Week {week.weekNumber}
                        </Badge>
                        <span className="font-semibold" data-testid={`text-week-title-${week.id}`}>{week.title}</span>
                      </div>
                      <div className="flex items-center gap-2 flex-wrap">
                        {submission && (
                          <Badge variant="outline" data-testid={`text-score-${week.id}`}>
                            {totalEarned}/{totalMax} pts
                          </Badge>
                        )}
                        <Badge variant="outline" className="text-muted-foreground">
                          {week.questions.length} questions
                        </Badge>
                      </div>
                    </div>
                  </AccordionTrigger>
                  <AccordionContent className="px-6 pb-4">
                    <div className="space-y-4 pt-2">
                      {week.questions
                        .sort((a, b) => a.questionNumber - b.questionNumber)
                        .map((question) => {
                          const teamAnswer = submission?.answers.find(
                            (a) => a.questionId === question.id
                          );
                          const pointsAwarded = teamAnswer
                            ? parseFloat(teamAnswer.pointsAwarded?.toString() || "0")
                            : 0;
                          const maxPoints = question.maxPoints || 1;
                          const indicator = teamAnswer
                            ? getPointsIndicator(pointsAwarded, maxPoints)
                            : null;

                          return (
                            <div key={question.id} className="border rounded-md" data-testid={`card-question-${question.id}`}>
                              <div className="bg-muted/50 px-4 py-2 flex items-center justify-between gap-2 flex-wrap">
                                <div className="flex items-center gap-2">
                                  <HelpCircle className="h-4 w-4 text-accent" />
                                  <span className="text-sm font-medium">Question {question.questionNumber}</span>
                                </div>
                                {teamAnswer && indicator && (
                                  <Badge
                                    variant="outline"
                                    className={indicator.color}
                                    data-testid={`text-points-${question.id}`}
                                  >
                                    {pointsAwarded}/{maxPoints} pts
                                  </Badge>
                                )}
                              </div>
                              <div className="p-4 space-y-3">
                                <p className="text-foreground" data-testid={`text-question-${question.id}`}>{question.questionText}</p>

                                <div className="flex items-start gap-2 p-3 bg-accent/10 rounded-md">
                                  <CheckCircle2 className="h-4 w-4 text-accent mt-0.5 flex-shrink-0" />
                                  <div>
                                    <p className="text-xs font-medium text-muted-foreground mb-1">Correct Answer</p>
                                    <p className="text-accent font-medium" data-testid={`text-correct-answer-${question.id}`}>{question.correctAnswer}</p>
                                  </div>
                                </div>

                                {submission ? (
                                  teamAnswer ? (
                                    (() => {
                                      const IndicatorIcon = indicator!.icon;
                                      return (
                                        <div className={`flex items-start gap-2 p-3 rounded-md ${indicator!.bg}`}>
                                          <IndicatorIcon className={`h-4 w-4 mt-0.5 flex-shrink-0 ${indicator!.color}`} />
                                          <div>
                                            <p className="text-xs font-medium text-muted-foreground mb-1">Your Team's Answer</p>
                                            <p className={`font-medium ${indicator!.color}`} data-testid={`text-team-answer-${question.id}`}>
                                              {teamAnswer.answerText}
                                            </p>
                                          </div>
                                        </div>
                                      );
                                    })()
                                  ) : (
                                    <div className="flex items-start gap-2 p-3 rounded-md bg-muted/50">
                                      <MinusCircle className="h-4 w-4 mt-0.5 flex-shrink-0 text-muted-foreground" />
                                      <div>
                                        <p className="text-xs font-medium text-muted-foreground mb-1">Your Team's Answer</p>
                                        <p className="font-medium text-muted-foreground" data-testid={`text-team-answer-${question.id}`}>No answer submitted</p>
                                      </div>
                                    </div>
                                  )
                                ) : (
                                  <div className="flex items-start gap-2 p-3 rounded-md bg-muted/50">
                                    <MinusCircle className="h-4 w-4 mt-0.5 flex-shrink-0 text-muted-foreground" />
                                    <div>
                                      <p className="text-xs font-medium text-muted-foreground mb-1">Your Team's Answer</p>
                                      <p className="font-medium text-muted-foreground" data-testid={`text-no-submission-${question.id}`}>No submission</p>
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
              <Archive className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2" data-testid="text-no-archives">No Archives Yet</h3>
              <p className="text-muted-foreground text-center">
                Past trivia weeks will appear here after they're completed
              </p>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
}

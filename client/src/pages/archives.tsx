import { useQuery } from "@tanstack/react-query";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { Badge } from "@/components/ui/badge";
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from "@/components/ui/accordion";
import { Archive, CheckCircle2, HelpCircle } from "lucide-react";
import type { WeekWithQuestions } from "@shared/schema";

export default function ArchivesPage() {
  const { data: weeks, isLoading } = useQuery<WeekWithQuestions[]>({
    queryKey: ["/api/weeks/archived"],
  });

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex items-center gap-3 mb-8">
          <Archive className="h-8 w-8 text-accent" />
          <div>
            <h1 className="text-3xl font-bold text-foreground">Past Questions</h1>
            <p className="text-muted-foreground">Review previous trivia weeks</p>
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
        ) : weeks && weeks.length > 0 ? (
          <Accordion type="single" collapsible className="space-y-4">
            {weeks.map((week) => (
              <AccordionItem key={week.id} value={week.id} className="border rounded-lg overflow-hidden">
                <AccordionTrigger className="px-6 py-4 hover:no-underline hover:bg-muted/50 data-[state=open]:bg-muted/50">
                  <div className="flex items-center justify-between w-full mr-4">
                    <div className="flex items-center gap-3">
                      <Badge variant="secondary" className="bg-primary text-primary-foreground">
                        Week {week.weekNumber}
                      </Badge>
                      <span className="font-semibold">{week.title}</span>
                    </div>
                    <Badge variant="outline" className="text-muted-foreground">
                      {week.questions.length} questions
                    </Badge>
                  </div>
                </AccordionTrigger>
                <AccordionContent className="px-6 pb-4">
                  <div className="space-y-4 pt-2">
                    {week.questions
                      .sort((a, b) => a.questionNumber - b.questionNumber)
                      .map((question) => (
                        <div key={question.id} className="border rounded-lg overflow-hidden">
                          <div className="bg-muted/50 px-4 py-2 flex items-center gap-2">
                            <HelpCircle className="h-4 w-4 text-accent" />
                            <span className="text-sm font-medium">Question {question.questionNumber}</span>
                          </div>
                          <div className="p-4 space-y-3">
                            <p className="text-foreground">{question.questionText}</p>
                            <div className="flex items-start gap-2 p-3 bg-accent/10 rounded-md">
                              <CheckCircle2 className="h-4 w-4 text-accent mt-0.5 flex-shrink-0" />
                              <div>
                                <p className="text-xs font-medium text-muted-foreground mb-1">Correct Answer</p>
                                <p className="text-accent font-medium">{question.correctAnswer}</p>
                              </div>
                            </div>
                          </div>
                        </div>
                      ))}
                  </div>
                </AccordionContent>
              </AccordionItem>
            ))}
          </Accordion>
        ) : (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <Archive className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2">No Archives Yet</h3>
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

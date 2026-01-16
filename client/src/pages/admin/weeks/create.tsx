import { useState } from "react";
import { useLocation, Link } from "wouter";
import { useForm, useFieldArray } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { useMutation } from "@tanstack/react-query";
import { apiRequest, queryClient } from "@/lib/queryClient";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { useToast } from "@/hooks/use-toast";
import { ArrowLeft, Plus, Trash2, Loader2, Calendar } from "lucide-react";

const questionSchema = z.object({
  questionText: z.string().min(1, "Question is required"),
  correctAnswer: z.string().min(1, "Answer is required"),
  maxPoints: z.coerce.number().min(1, "Points must be at least 1").max(10, "Points cannot exceed 10"),
});

const createWeekSchema = z.object({
  weekNumber: z.coerce.number().min(1, "Week number must be at least 1"),
  title: z.string().min(1, "Title is required"),
  questions: z.array(questionSchema).length(10, "Exactly 10 questions are required"),
});

type CreateWeekForm = z.infer<typeof createWeekSchema>;

export default function CreateWeekPage() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();

  const form = useForm<CreateWeekForm>({
    resolver: zodResolver(createWeekSchema),
    defaultValues: {
      weekNumber: 1,
      title: "",
      questions: Array(10).fill(null).map(() => ({ questionText: "", correctAnswer: "", maxPoints: 1 })),
    },
  });

  const { fields } = useFieldArray({
    control: form.control,
    name: "questions",
  });

  const createMutation = useMutation({
    mutationFn: async (data: CreateWeekForm) => {
      return await apiRequest("POST", "/api/admin/weeks", data);
    },
    onSuccess: () => {
      toast({
        title: "Week created!",
        description: "The trivia week has been created successfully.",
      });
      queryClient.invalidateQueries({ queryKey: ["/api/weeks"] });
      setLocation("/admin");
    },
    onError: (error: Error) => {
      toast({
        variant: "destructive",
        title: "Failed to create week",
        description: error.message,
      });
    },
  });

  const onSubmit = (data: CreateWeekForm) => {
    createMutation.mutate(data);
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Link href="/admin" className="inline-flex items-center text-muted-foreground hover:text-foreground mb-6">
          <ArrowLeft className="h-4 w-4 mr-2" />
          Back to Admin
        </Link>

        <div className="flex items-center gap-3 mb-8">
          <Calendar className="h-8 w-8 text-accent" />
          <div>
            <h1 className="text-3xl font-bold text-foreground">Create Trivia Week</h1>
            <p className="text-muted-foreground">Add 10 questions for a new trivia week</p>
          </div>
        </div>

        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Week Details</CardTitle>
              </CardHeader>
              <CardContent className="grid gap-4 sm:grid-cols-2">
                <FormField
                  control={form.control}
                  name="weekNumber"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Week Number</FormLabel>
                      <FormControl>
                        <Input type="number" min={1} data-testid="input-week-number" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                <FormField
                  control={form.control}
                  name="title"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Title</FormLabel>
                      <FormControl>
                        <Input placeholder="Pop Culture Mania" data-testid="input-week-title" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle>Questions (10 Required)</CardTitle>
                <CardDescription>Enter all 10 questions and their correct answers</CardDescription>
              </CardHeader>
              <CardContent className="space-y-6">
                {fields.map((field, index) => (
                  <div key={field.id} className="border rounded-lg p-4 space-y-4">
                    <div className="flex items-center gap-2">
                      <div className="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-primary-foreground font-bold text-sm">
                        {index + 1}
                      </div>
                      <span className="font-medium">Question {index + 1}</span>
                    </div>
                    <FormField
                      control={form.control}
                      name={`questions.${index}.questionText`}
                      render={({ field }) => (
                        <FormItem>
                          <FormLabel className="sr-only">Question</FormLabel>
                          <FormControl>
                            <Textarea
                              placeholder="Enter the question..."
                              className="min-h-[80px]"
                              data-testid={`textarea-question-${index + 1}`}
                              {...field}
                            />
                          </FormControl>
                          <FormMessage />
                        </FormItem>
                      )}
                    />
                    <div className="grid gap-4 sm:grid-cols-[1fr_auto]">
                      <FormField
                        control={form.control}
                        name={`questions.${index}.correctAnswer`}
                        render={({ field }) => (
                          <FormItem>
                            <FormLabel className="text-sm text-muted-foreground">Correct Answer</FormLabel>
                            <FormControl>
                              <Input
                                placeholder="Enter the correct answer..."
                                data-testid={`input-answer-${index + 1}`}
                                {...field}
                              />
                            </FormControl>
                            <FormMessage />
                          </FormItem>
                        )}
                      />
                      <FormField
                        control={form.control}
                        name={`questions.${index}.maxPoints`}
                        render={({ field }) => (
                          <FormItem className="w-24">
                            <FormLabel className="text-sm text-muted-foreground">Max Points</FormLabel>
                            <FormControl>
                              <Input
                                type="number"
                                min={1}
                                max={10}
                                data-testid={`input-maxpoints-${index + 1}`}
                                {...field}
                              />
                            </FormControl>
                            <FormMessage />
                          </FormItem>
                        )}
                      />
                    </div>
                  </div>
                ))}
              </CardContent>
            </Card>

            <Card className="sticky bottom-4">
              <CardContent className="py-4">
                <div className="flex flex-col sm:flex-row gap-4 items-center justify-between">
                  <p className="text-sm text-muted-foreground">
                    The week will be created as inactive. Activate it when ready.
                  </p>
                  <Button
                    type="submit"
                    className="w-full sm:w-auto bg-accent text-accent-foreground hover:bg-accent/90"
                    disabled={createMutation.isPending}
                    data-testid="button-create-week-submit"
                  >
                    {createMutation.isPending ? (
                      <>
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                        Creating...
                      </>
                    ) : (
                      <>
                        <Plus className="mr-2 h-4 w-4" />
                        Create Week
                      </>
                    )}
                  </Button>
                </div>
              </CardContent>
            </Card>
          </form>
        </Form>
      </div>
    </div>
  );
}

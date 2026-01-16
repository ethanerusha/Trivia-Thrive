import { useState } from "react";
import { useLocation } from "wouter";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { useMutation } from "@tanstack/react-query";
import { apiRequest, queryClient } from "@/lib/queryClient";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage, FormDescription } from "@/components/ui/form";
import { useToast } from "@/hooks/use-toast";
import { Users, Loader2, Crown, ArrowLeft } from "lucide-react";
import { Link } from "wouter";

const createTeamSchema = z.object({
  name: z.string().min(2, "Team name must be at least 2 characters").max(50, "Team name is too long"),
});

type CreateTeamForm = z.infer<typeof createTeamSchema>;

export default function CreateTeamPage() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();

  const form = useForm<CreateTeamForm>({
    resolver: zodResolver(createTeamSchema),
    defaultValues: {
      name: "",
    },
  });

  const createMutation = useMutation({
    mutationFn: async (data: CreateTeamForm) => {
      return await apiRequest("POST", "/api/teams", data);
    },
    onSuccess: () => {
      toast({
        title: "Team created!",
        description: "You are now the Team Lead.",
      });
      queryClient.invalidateQueries({ queryKey: ["/api/teams"] });
      queryClient.invalidateQueries({ queryKey: ["/api/teams/my-team"] });
      queryClient.invalidateQueries({ queryKey: ["/api/leaderboard"] });
      setLocation("/my-team");
    },
    onError: (error: Error) => {
      toast({
        variant: "destructive",
        title: "Failed to create team",
        description: error.message,
      });
    },
  });

  const onSubmit = (data: CreateTeamForm) => {
    createMutation.mutate(data);
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Link href="/teams" className="inline-flex items-center text-muted-foreground hover:text-foreground mb-6">
          <ArrowLeft className="h-4 w-4 mr-2" />
          Back to Teams
        </Link>

        <div className="grid gap-6 md:grid-cols-5">
          <Card className="md:col-span-3">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Users className="h-5 w-5 text-accent" />
                Create a Team
              </CardTitle>
              <CardDescription>
                Start your own team and invite colleagues to join
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Form {...form}>
                <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
                  <FormField
                    control={form.control}
                    name="name"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Team Name</FormLabel>
                        <FormControl>
                          <Input
                            placeholder="The Brainiacs"
                            data-testid="input-team-name"
                            {...field}
                          />
                        </FormControl>
                        <FormDescription>
                          Choose a unique name for your team
                        </FormDescription>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                  <Button
                    type="submit"
                    className="w-full bg-accent text-accent-foreground hover:bg-accent/90"
                    disabled={createMutation.isPending}
                    data-testid="button-submit-create-team"
                  >
                    {createMutation.isPending ? (
                      <>
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                        Creating...
                      </>
                    ) : (
                      <>
                        <Users className="mr-2 h-4 w-4" />
                        Create Team
                      </>
                    )}
                  </Button>
                </form>
              </Form>
            </CardContent>
          </Card>

          <Card className="md:col-span-2 bg-accent/5 border-accent/20">
            <CardHeader>
              <CardTitle className="flex items-center gap-2 text-lg">
                <Crown className="h-5 w-5 text-accent" />
                Team Lead Benefits
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-3 text-sm">
              <div className="flex items-start gap-2">
                <div className="w-1.5 h-1.5 rounded-full bg-accent mt-2" />
                <p>Submit answers on behalf of your team</p>
              </div>
              <div className="flex items-start gap-2">
                <div className="w-1.5 h-1.5 rounded-full bg-accent mt-2" />
                <p>Approve or reject team join requests</p>
              </div>
              <div className="flex items-start gap-2">
                <div className="w-1.5 h-1.5 rounded-full bg-accent mt-2" />
                <p>Manage your team roster</p>
              </div>
              <div className="flex items-start gap-2">
                <div className="w-1.5 h-1.5 rounded-full bg-accent mt-2" />
                <p>Lead your team to Season 10 victory!</p>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
}

import { useQuery } from "@tanstack/react-query";
import { Link } from "wouter";
import { useAuth } from "@/lib/auth";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Users, Crown, Plus, UserPlus } from "lucide-react";
import type { TeamWithMembers } from "@shared/schema";
import { useMutation } from "@tanstack/react-query";
import { apiRequest, queryClient } from "@/lib/queryClient";
import { useToast } from "@/hooks/use-toast";

export default function TeamsPage() {
  const { user } = useAuth();
  const { toast } = useToast();

  const { data: teams, isLoading } = useQuery<TeamWithMembers[]>({
    queryKey: ["/api/teams"],
  });

  const { data: myTeam } = useQuery<TeamWithMembers | null>({
    queryKey: ["/api/teams/my-team"],
  });

  const joinMutation = useMutation({
    mutationFn: async (teamId: string) => {
      return await apiRequest("POST", `/api/teams/${teamId}/join`);
    },
    onSuccess: () => {
      toast({
        title: "Join request sent!",
        description: "The Team Lead will need to approve your request.",
      });
      queryClient.invalidateQueries({ queryKey: ["/api/teams"] });
      queryClient.invalidateQueries({ queryKey: ["/api/teams/my-team"] });
    },
    onError: (error: Error) => {
      toast({
        variant: "destructive",
        title: "Failed to join team",
        description: error.message,
      });
    },
  });

  const getInitials = (name: string) => {
    return name
      .split(" ")
      .map((n) => n[0])
      .join("")
      .toUpperCase()
      .slice(0, 2);
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
          <div>
            <h1 className="text-3xl font-bold text-foreground">Team Directory</h1>
            <p className="text-muted-foreground mt-1">
              Browse all Season 10 teams
            </p>
          </div>
          {!myTeam && (
            <Link href="/teams/create">
              <Button className="bg-accent text-accent-foreground hover:bg-accent/90" data-testid="button-create-team">
                <Plus className="h-4 w-4 mr-2" />
                Create Team
              </Button>
            </Link>
          )}
        </div>

        {isLoading ? (
          <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {[1, 2, 3, 4, 5, 6].map((i) => (
              <Card key={i}>
                <CardHeader>
                  <Skeleton className="h-6 w-32" />
                  <Skeleton className="h-4 w-24" />
                </CardHeader>
                <CardContent>
                  <Skeleton className="h-20 w-full" />
                </CardContent>
              </Card>
            ))}
          </div>
        ) : teams && teams.length > 0 ? (
          <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {teams.map((team) => {
              const isMyTeam = myTeam?.id === team.id;
              const approvedMembers = team.members.filter((m) => m.isApproved);
              const hasPendingRequest = team.members.some(
                (m) => m.userId === user?.id && !m.isApproved
              );

              return (
                <Card key={team.id} className={isMyTeam ? "border-accent" : ""}>
                  <CardHeader>
                    <div className="flex items-start justify-between gap-2">
                      <div className="flex-1 min-w-0">
                        <CardTitle className="flex items-center gap-2 flex-wrap">
                          <span className="truncate">{team.name}</span>
                          {isMyTeam && (
                            <Badge className="bg-accent text-accent-foreground flex-shrink-0">
                              My Team
                            </Badge>
                          )}
                        </CardTitle>
                        <CardDescription className="flex items-center gap-1 mt-1">
                          <Crown className="h-3 w-3 text-accent" />
                          <span className="truncate">{team.lead.name}</span>
                        </CardDescription>
                      </div>
                      <Badge variant="secondary" className="flex-shrink-0">
                        {approvedMembers.length} member{approvedMembers.length !== 1 ? "s" : ""}
                      </Badge>
                    </div>
                  </CardHeader>
                  <CardContent>
                    <div className="flex -space-x-2 mb-4">
                      {approvedMembers.slice(0, 5).map((member) => (
                        <Avatar key={member.id} className="h-8 w-8 border-2 border-background">
                          <AvatarFallback className="text-xs bg-primary text-primary-foreground">
                            {getInitials(member.user.name)}
                          </AvatarFallback>
                        </Avatar>
                      ))}
                      {approvedMembers.length > 5 && (
                        <div className="h-8 w-8 rounded-full bg-muted border-2 border-background flex items-center justify-center text-xs font-medium">
                          +{approvedMembers.length - 5}
                        </div>
                      )}
                    </div>

                    {!myTeam && !hasPendingRequest && (
                      <Button
                        variant="outline"
                        className="w-full"
                        onClick={() => joinMutation.mutate(team.id)}
                        disabled={joinMutation.isPending}
                        data-testid={`button-join-${team.id}`}
                      >
                        <UserPlus className="h-4 w-4 mr-2" />
                        Request to Join
                      </Button>
                    )}
                    {hasPendingRequest && (
                      <Badge variant="secondary" className="w-full justify-center py-2">
                        Pending Approval
                      </Badge>
                    )}
                    {isMyTeam && (
                      <Link href="/my-team">
                        <Button variant="outline" className="w-full" data-testid="button-manage-team">
                          <Users className="h-4 w-4 mr-2" />
                          Manage Team
                        </Button>
                      </Link>
                    )}
                  </CardContent>
                </Card>
              );
            })}
          </div>
        ) : (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <Users className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2">No Teams Yet</h3>
              <p className="text-muted-foreground text-center mb-4">
                Be the first to create a team for Season 10!
              </p>
              <Link href="/teams/create">
                <Button className="bg-accent text-accent-foreground hover:bg-accent/90" data-testid="button-create-first-team">
                  <Plus className="h-4 w-4 mr-2" />
                  Create First Team
                </Button>
              </Link>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
}

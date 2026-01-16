import { useQuery, useMutation } from "@tanstack/react-query";
import { Link } from "wouter";
import { useAuth } from "@/lib/auth";
import { apiRequest, queryClient } from "@/lib/queryClient";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { useToast } from "@/hooks/use-toast";
import { Users, Crown, Check, X, UserMinus, Clock, Trophy, ArrowRight } from "lucide-react";
import type { TeamWithMembers } from "@shared/schema";
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

export default function MyTeamPage() {
  const { user } = useAuth();
  const { toast } = useToast();

  const { data: myTeam, isLoading } = useQuery<TeamWithMembers | null>({
    queryKey: ["/api/teams/my-team"],
  });

  const approveMutation = useMutation({
    mutationFn: async (memberId: string) => {
      return await apiRequest("POST", `/api/teams/members/${memberId}/approve`);
    },
    onSuccess: () => {
      toast({ title: "Member approved!" });
      queryClient.invalidateQueries({ queryKey: ["/api/teams/my-team"] });
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Error", description: error.message });
    },
  });

  const rejectMutation = useMutation({
    mutationFn: async (memberId: string) => {
      return await apiRequest("POST", `/api/teams/members/${memberId}/reject`);
    },
    onSuccess: () => {
      toast({ title: "Request rejected" });
      queryClient.invalidateQueries({ queryKey: ["/api/teams/my-team"] });
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Error", description: error.message });
    },
  });

  const removeMutation = useMutation({
    mutationFn: async (memberId: string) => {
      return await apiRequest("DELETE", `/api/teams/members/${memberId}`);
    },
    onSuccess: () => {
      toast({ title: "Member removed" });
      queryClient.invalidateQueries({ queryKey: ["/api/teams/my-team"] });
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Error", description: error.message });
    },
  });

  const leaveMutation = useMutation({
    mutationFn: async () => {
      return await apiRequest("POST", "/api/teams/leave");
    },
    onSuccess: () => {
      toast({ title: "You have left the team" });
      queryClient.invalidateQueries({ queryKey: ["/api/teams/my-team"] });
      queryClient.invalidateQueries({ queryKey: ["/api/teams"] });
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Error", description: error.message });
    },
  });

  const getInitials = (name: string) => {
    return name.split(" ").map((n) => n[0]).join("").toUpperCase().slice(0, 2);
  };

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Skeleton className="h-10 w-48 mb-8" />
          <Card>
            <CardContent className="py-8">
              <Skeleton className="h-32 w-full" />
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  if (!myTeam) {
    return (
      <div className="min-h-screen bg-background">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <Users className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2">You're not on a team yet</h3>
              <p className="text-muted-foreground text-center mb-6">
                Create your own team or join an existing one
              </p>
              <div className="flex gap-4">
                <Link href="/teams/create">
                  <Button className="bg-accent text-accent-foreground hover:bg-accent/90" data-testid="button-create-team">
                    Create Team
                  </Button>
                </Link>
                <Link href="/teams">
                  <Button variant="outline" data-testid="button-browse-teams">
                    Browse Teams
                  </Button>
                </Link>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  const isTeamLead = myTeam.leadId === user?.id;
  const pendingMembers = myTeam.members.filter((m) => !m.isApproved);
  const approvedMembers = myTeam.members.filter((m) => m.isApproved);

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
          <div>
            <h1 className="text-3xl font-bold text-foreground flex items-center gap-3 flex-wrap">
              {myTeam.name}
              {isTeamLead && (
                <Badge className="bg-accent text-accent-foreground">
                  <Crown className="h-3 w-3 mr-1" />
                  Team Lead
                </Badge>
              )}
            </h1>
            <p className="text-muted-foreground mt-1">
              {approvedMembers.length} active member{approvedMembers.length !== 1 ? "s" : ""}
            </p>
          </div>
          <Link href="/leaderboard">
            <Button variant="outline" data-testid="link-leaderboard">
              <Trophy className="h-4 w-4 mr-2" />
              View Leaderboard
            </Button>
          </Link>
        </div>

        <div className="grid gap-6">
          {isTeamLead && pendingMembers.length > 0 && (
            <Card className="border-accent/30">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Clock className="h-5 w-5 text-accent" />
                  Pending Requests
                  <Badge variant="secondary">{pendingMembers.length}</Badge>
                </CardTitle>
                <CardDescription>
                  Members waiting for your approval
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-3">
                {pendingMembers.map((member) => (
                  <div
                    key={member.id}
                    className="flex items-center justify-between p-3 rounded-lg bg-muted/50"
                  >
                    <div className="flex items-center gap-3">
                      <Avatar className="h-10 w-10">
                        <AvatarFallback className="bg-primary text-primary-foreground">
                          {getInitials(member.user.name)}
                        </AvatarFallback>
                      </Avatar>
                      <div>
                        <p className="font-medium">{member.user.name}</p>
                        <p className="text-sm text-muted-foreground">{member.user.email}</p>
                      </div>
                    </div>
                    <div className="flex gap-2">
                      <Button
                        size="sm"
                        className="bg-success text-success-foreground hover:bg-success/90"
                        onClick={() => approveMutation.mutate(member.id)}
                        disabled={approveMutation.isPending}
                        data-testid={`button-approve-${member.id}`}
                      >
                        <Check className="h-4 w-4" />
                      </Button>
                      <Button
                        size="sm"
                        variant="destructive"
                        onClick={() => rejectMutation.mutate(member.id)}
                        disabled={rejectMutation.isPending}
                        data-testid={`button-reject-${member.id}`}
                      >
                        <X className="h-4 w-4" />
                      </Button>
                    </div>
                  </div>
                ))}
              </CardContent>
            </Card>
          )}

          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Users className="h-5 w-5 text-accent" />
                Team Members
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              {approvedMembers.map((member) => (
                <div
                  key={member.id}
                  className="flex items-center justify-between p-3 rounded-lg hover:bg-muted/50 transition-colors"
                >
                  <div className="flex items-center gap-3">
                    <Avatar className="h-10 w-10 border-2 border-transparent">
                      <AvatarFallback className={`${member.isLead ? "bg-accent text-accent-foreground" : "bg-primary text-primary-foreground"}`}>
                        {getInitials(member.user.name)}
                      </AvatarFallback>
                    </Avatar>
                    <div>
                      <p className="font-medium flex items-center gap-2">
                        {member.user.name}
                        {member.isLead && (
                          <Crown className="h-4 w-4 text-accent" />
                        )}
                      </p>
                      <p className="text-sm text-muted-foreground">{member.user.email}</p>
                    </div>
                  </div>
                  {isTeamLead && !member.isLead && (
                    <AlertDialog>
                      <AlertDialogTrigger asChild>
                        <Button size="sm" variant="ghost" className="text-destructive hover:text-destructive" data-testid={`button-remove-${member.id}`}>
                          <UserMinus className="h-4 w-4" />
                        </Button>
                      </AlertDialogTrigger>
                      <AlertDialogContent>
                        <AlertDialogHeader>
                          <AlertDialogTitle>Remove team member?</AlertDialogTitle>
                          <AlertDialogDescription>
                            Are you sure you want to remove {member.user.name} from the team?
                          </AlertDialogDescription>
                        </AlertDialogHeader>
                        <AlertDialogFooter>
                          <AlertDialogCancel>Cancel</AlertDialogCancel>
                          <AlertDialogAction
                            className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
                            onClick={() => removeMutation.mutate(member.id)}
                          >
                            Remove
                          </AlertDialogAction>
                        </AlertDialogFooter>
                      </AlertDialogContent>
                    </AlertDialog>
                  )}
                </div>
              ))}
            </CardContent>
          </Card>

          {!isTeamLead && (
            <Card>
              <CardContent className="py-6">
                <AlertDialog>
                  <AlertDialogTrigger asChild>
                    <Button variant="outline" className="text-destructive hover:text-destructive" data-testid="button-leave-team">
                      Leave Team
                    </Button>
                  </AlertDialogTrigger>
                  <AlertDialogContent>
                    <AlertDialogHeader>
                      <AlertDialogTitle>Leave team?</AlertDialogTitle>
                      <AlertDialogDescription>
                        Are you sure you want to leave {myTeam.name}? You'll need to request to join again.
                      </AlertDialogDescription>
                    </AlertDialogHeader>
                    <AlertDialogFooter>
                      <AlertDialogCancel>Cancel</AlertDialogCancel>
                      <AlertDialogAction
                        className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
                        onClick={() => leaveMutation.mutate()}
                      >
                        Leave Team
                      </AlertDialogAction>
                    </AlertDialogFooter>
                  </AlertDialogContent>
                </AlertDialog>
              </CardContent>
            </Card>
          )}
        </div>
      </div>
    </div>
  );
}

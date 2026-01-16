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
import { Users, Trophy } from "lucide-react";
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

  const approvedMembers = myTeam.members.filter((m) => m.isApproved);
  const isTrophyEligible = approvedMembers.length === 3;

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
          <div>
            <h1 className="text-3xl font-bold text-foreground flex items-center gap-3 flex-wrap">
              {myTeam.name}
              {isTrophyEligible && (
                <Badge className="bg-accent text-accent-foreground">
                  Trophy Eligible
                </Badge>
              )}
              {approvedMembers.length === 4 && (
                <Badge variant="outline">
                  Full Team
                </Badge>
              )}
            </h1>
            <p className="text-muted-foreground mt-1">
              {approvedMembers.length}/4 members
              {approvedMembers.length < 3 && " - Need at least 3 for trophy eligibility"}
              {approvedMembers.length === 4 && " - Not trophy eligible"}
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
                      <AvatarFallback className="bg-primary text-primary-foreground">
                        {getInitials(member.user.name)}
                      </AvatarFallback>
                    </Avatar>
                    <div>
                      <p className="font-medium">{member.user.name}</p>
                      <p className="text-sm text-muted-foreground">{member.user.email}</p>
                    </div>
                  </div>
                </div>
              ))}
            </CardContent>
          </Card>

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
                      Are you sure you want to leave {myTeam.name}?
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
        </div>
      </div>
    </div>
  );
}

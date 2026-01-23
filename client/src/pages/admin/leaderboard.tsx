import { useState, useEffect } from "react";
import { Link } from "wouter";
import { useQuery, useMutation } from "@tanstack/react-query";
import { apiRequest, queryClient } from "@/lib/queryClient";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Skeleton } from "@/components/ui/skeleton";
import { useToast } from "@/hooks/use-toast";
import { ArrowLeft, Trophy, Save, Loader2, RefreshCw } from "lucide-react";
import type { LeaderboardEntry } from "@shared/schema";

export default function AdminLeaderboardPage() {
  const { toast } = useToast();
  const [overrides, setOverrides] = useState<Record<string, number>>({});

  const { data: leaderboard, isLoading } = useQuery<LeaderboardEntry[]>({
    queryKey: ["/api/leaderboard"],
  });

  useEffect(() => {
    if (leaderboard) {
      const initial: Record<string, number> = {};
      leaderboard.forEach((entry) => {
        initial[entry.teamId] = entry.totalPoints;
      });
      setOverrides(initial);
    }
  }, [leaderboard]);

  const updateMutation = useMutation({
    mutationFn: async () => {
      const updates = Object.entries(overrides).map(([teamId, points]) => ({
        teamId,
        points,
      }));
      return await apiRequest("POST", "/api/admin/leaderboard/override", { updates });
    },
    onSuccess: () => {
      toast({
        title: "Leaderboard updated!",
        description: "Point overrides have been saved.",
      });
      queryClient.invalidateQueries({ queryKey: ["/api/leaderboard"] });
    },
    onError: (error: Error) => {
      toast({
        variant: "destructive",
        title: "Update failed",
        description: error.message,
      });
    },
  });

  const recalculateMutation = useMutation({
    mutationFn: async () => {
      return await apiRequest("POST", "/api/admin/leaderboard/recalculate");
    },
    onSuccess: () => {
      toast({
        title: "Leaderboard recalculated!",
        description: "Points have been recalculated from graded submissions.",
      });
      queryClient.invalidateQueries({ queryKey: ["/api/leaderboard"] });
    },
    onError: (error: Error) => {
      toast({
        variant: "destructive",
        title: "Recalculation failed",
        description: error.message,
      });
    },
  });

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Link href="/admin" className="inline-flex items-center text-muted-foreground hover:text-foreground mb-6">
          <ArrowLeft className="h-4 w-4 mr-2" />
          Back to Admin
        </Link>

        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
          <div className="flex items-center gap-3">
            <Trophy className="h-8 w-8 text-accent" />
            <div>
              <h1 className="text-3xl font-bold text-foreground">Manage Leaderboard</h1>
              <p className="text-muted-foreground">Override team points</p>
            </div>
          </div>
          <div className="flex gap-2">
            <Button
              variant="outline"
              onClick={() => recalculateMutation.mutate()}
              disabled={recalculateMutation.isPending}
              data-testid="button-recalculate"
            >
              {recalculateMutation.isPending ? (
                <Loader2 className="h-4 w-4 mr-2 animate-spin" />
              ) : (
                <RefreshCw className="h-4 w-4 mr-2" />
              )}
              Recalculate
            </Button>
            <Button
              onClick={() => updateMutation.mutate()}
              disabled={updateMutation.isPending}
              className="bg-accent text-accent-foreground"
              data-testid="button-save-overrides"
            >
              {updateMutation.isPending ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  Saving...
                </>
              ) : (
                <>
                  <Save className="mr-2 h-4 w-4" />
                  Save Changes
                </>
              )}
            </Button>
          </div>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Team Points</CardTitle>
            <CardDescription>
              Manually adjust team points. Use recalculate to reset to graded totals.
            </CardDescription>
          </CardHeader>
          <CardContent>
            {isLoading ? (
              <div className="space-y-2">
                {[1, 2, 3, 4, 5].map((i) => (
                  <Skeleton key={i} className="h-16 w-full" />
                ))}
              </div>
            ) : leaderboard && leaderboard.length > 0 ? (
              <div className="space-y-3">
                {leaderboard.map((entry) => (
                  <div
                    key={entry.teamId}
                    className="flex items-center justify-between p-4 rounded-lg border"
                  >
                    <div className="flex items-center gap-4">
                      <span className="font-bold text-lg w-8 text-center">
                        #{entry.rank}
                      </span>
                      <div>
                        <p className="font-semibold">{entry.teamName}</p>
                        <p className="text-sm text-muted-foreground">
                          {entry.memberCount} members
                        </p>
                      </div>
                    </div>
                    <div className="flex items-center gap-2">
                      <Input
                        type="number"
                        step="0.5"
                        min="0"
                        className="w-24 text-right"
                        value={overrides[entry.teamId] ?? entry.totalPoints}
                        onChange={(e) =>
                          setOverrides((prev) => ({
                            ...prev,
                            [entry.teamId]: parseFloat(e.target.value) || 0,
                          }))
                        }
                        data-testid={`input-points-${entry.teamId}`}
                      />
                      <span className="text-sm text-muted-foreground">pts</span>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="flex flex-col items-center justify-center py-12">
                <Trophy className="h-12 w-12 text-muted-foreground mb-4" />
                <h3 className="text-lg font-semibold mb-2">No Teams Yet</h3>
                <p className="text-muted-foreground text-center">
                  Teams will appear here once they're created
                </p>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}

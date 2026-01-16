import { useQuery } from "@tanstack/react-query";
import { useAuth } from "@/lib/auth";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { ScrollArea, ScrollBar } from "@/components/ui/scroll-area";
import { Trophy, Users, Medal } from "lucide-react";
import type { LeaderboardEntry } from "@shared/schema";

export default function LeaderboardPage() {
  const { user } = useAuth();

  const { data: leaderboard, isLoading } = useQuery<LeaderboardEntry[]>({
    queryKey: ["/api/leaderboard"],
  });

  const { data: myTeam } = useQuery({
    queryKey: ["/api/teams/my-team"],
  });

  // Get all week numbers from the first team's weeklyScores (all teams have same weeks)
  const weekNumbers = leaderboard?.[0]?.weeklyScores?.map(ws => ws.weekNumber) || [];

  const getRankStyle = (rank: number) => {
    if (rank === 1) return "bg-gradient-to-r from-amber-100 to-amber-50 dark:from-amber-900/30 dark:to-amber-800/20 border-amber-300 dark:border-amber-600";
    if (rank === 2) return "bg-gradient-to-r from-gray-100 to-gray-50 dark:from-gray-700/30 dark:to-gray-600/20 border-gray-300 dark:border-gray-500";
    if (rank === 3) return "bg-gradient-to-r from-orange-100 to-orange-50 dark:from-orange-900/30 dark:to-orange-800/20 border-orange-300 dark:border-orange-600";
    return "";
  };

  const getRankIcon = (rank: number) => {
    if (rank === 1) return <Medal className="h-6 w-6 text-amber-500" />;
    if (rank === 2) return <Medal className="h-6 w-6 text-gray-400" />;
    if (rank === 3) return <Medal className="h-6 w-6 text-orange-500" />;
    return <span className="w-6 h-6 flex items-center justify-center font-bold text-lg">{rank}</span>;
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex items-center gap-3 mb-8">
          <Trophy className="h-8 w-8 text-accent" />
          <div>
            <h1 className="text-3xl font-bold text-foreground">Leaderboard</h1>
            <p className="text-muted-foreground">Season 6 Rankings</p>
          </div>
        </div>

        <Card>
          <ScrollArea className="w-full">
            <div className="min-w-[600px]">
              <CardHeader className="bg-primary text-primary-foreground rounded-t-lg">
                <div className="flex items-center gap-4 text-sm font-medium">
                  <div className="w-12 text-center shrink-0">Rank</div>
                  <div className="w-40 shrink-0">Team</div>
                  <div className="w-20 text-center shrink-0 hidden sm:block">Members</div>
                  {weekNumbers.map(weekNum => (
                    <div key={weekNum} className="w-14 text-center shrink-0">W{weekNum}</div>
                  ))}
                  <div className="w-20 text-right shrink-0 font-bold">Total</div>
                </div>
              </CardHeader>
              <CardContent className="p-0">
                {isLoading ? (
                  <div className="space-y-2 p-4">
                    {[1, 2, 3, 4, 5].map((i) => (
                      <Skeleton key={i} className="h-16 w-full" />
                    ))}
                  </div>
                ) : leaderboard && leaderboard.length > 0 ? (
                  <div className="divide-y">
                    {leaderboard.map((entry) => {
                      const isMyTeam = (myTeam as any)?.id === entry.teamId;
                      
                      return (
                        <div
                          key={entry.teamId}
                          className={`flex items-center gap-4 p-4 transition-colors ${
                            getRankStyle(entry.rank)
                          } ${isMyTeam ? "ring-2 ring-accent ring-inset" : "hover:bg-muted/50"}`}
                          data-testid={`leaderboard-row-${entry.teamId}`}
                        >
                          <div className="w-12 flex justify-center shrink-0">
                            {getRankIcon(entry.rank)}
                          </div>
                          <div className="w-40 shrink-0">
                            <p className="font-semibold flex items-center gap-2 flex-wrap">
                              {entry.teamName}
                              {isMyTeam && (
                                <span className="text-xs bg-accent text-accent-foreground px-2 py-0.5 rounded">
                                  Your Team
                                </span>
                              )}
                            </p>
                          </div>
                          <div className="w-20 text-center shrink-0 hidden sm:flex items-center justify-center gap-1 text-muted-foreground">
                            <Users className="h-4 w-4" />
                            {entry.memberCount}
                          </div>
                          {entry.weeklyScores?.map((ws) => (
                            <div key={ws.weekId} className="w-14 text-center shrink-0 text-sm">
                              {ws.points > 0 ? ws.points : "-"}
                            </div>
                          ))}
                          <div className="w-20 text-right shrink-0">
                            <span className="text-xl font-bold text-accent">
                              {entry.totalPoints}
                            </span>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                ) : (
                  <div className="flex flex-col items-center justify-center py-12 text-center">
                    <Trophy className="h-12 w-12 text-muted-foreground mb-4" />
                    <h3 className="text-lg font-semibold mb-2">No Rankings Yet</h3>
                    <p className="text-muted-foreground">
                      Teams will appear here after scores are published
                    </p>
                  </div>
                )}
              </CardContent>
            </div>
            <ScrollBar orientation="horizontal" />
          </ScrollArea>
        </Card>
      </div>
    </div>
  );
}

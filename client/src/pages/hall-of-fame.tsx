import { useQuery } from "@tanstack/react-query";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Trophy, Crown, Award } from "lucide-react";
import type { Champion } from "@shared/schema";

export default function HallOfFamePage() {
  const { data: champions, isLoading } = useQuery<Champion[]>({
    queryKey: ["/api/champions"],
  });

  const grouped = champions?.reduce<Record<number, Champion[]>>((acc, c) => {
    if (!acc[c.year]) acc[c.year] = [];
    acc[c.year].push(c);
    return acc;
  }, {});

  const sortedYears = grouped ? Object.keys(grouped).map(Number).sort((a, b) => b - a) : [];

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex items-center gap-3 mb-8">
          <Trophy className="h-8 w-8 text-accent" />
          <div>
            <h1 className="text-3xl font-bold text-foreground" data-testid="text-hall-of-fame-title">Hall of Fame</h1>
            <p className="text-muted-foreground">Celebrating our past champions</p>
          </div>
        </div>

        {isLoading ? (
          <div className="space-y-6">
            {[1, 2, 3].map((i) => (
              <Card key={i}>
                <CardHeader>
                  <Skeleton className="h-6 w-32" />
                </CardHeader>
                <CardContent>
                  <Skeleton className="h-20 w-full" />
                </CardContent>
              </Card>
            ))}
          </div>
        ) : champions && champions.length > 0 ? (
          <div className="space-y-6">
            {sortedYears.map((year) => (
              <div key={year}>
                <h2 className="text-xl font-semibold text-foreground mb-3 flex items-center gap-2" data-testid={`text-year-${year}`}>
                  <Award className="h-5 w-5 text-accent" />
                  {year}
                </h2>
                <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
                  {grouped![year].map((champion) => (
                    <Card key={champion.id} className="border-accent/30">
                      <CardContent className="pt-6">
                        <div className="flex items-start gap-3">
                          <div className="flex-shrink-0 p-2 rounded-md bg-accent/10">
                            <Crown className="h-6 w-6 text-accent" />
                          </div>
                          <div className="flex-1 min-w-0">
                            <p className="font-semibold text-foreground truncate" data-testid={`text-champion-name-${champion.id}`}>
                              {champion.teamName}
                            </p>
                            {champion.season && (
                              <Badge variant="secondary" className="mt-1" data-testid={`badge-season-${champion.id}`}>
                                {champion.season}
                              </Badge>
                            )}
                            {champion.winningScore && parseFloat(champion.winningScore) > 0 && (
                              <p className="text-sm text-muted-foreground mt-1" data-testid={`text-score-${champion.id}`}>
                                Score: {parseFloat(champion.winningScore).toFixed(1)}
                              </p>
                            )}
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>
              </div>
            ))}
          </div>
        ) : (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <Trophy className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2" data-testid="text-no-champions">No Champions Yet</h3>
              <p className="text-muted-foreground text-center">
                Champion entries will appear here once added by an admin.
              </p>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
}

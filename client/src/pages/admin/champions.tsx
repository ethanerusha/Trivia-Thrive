import { useQuery, useMutation } from "@tanstack/react-query";
import { useAuth } from "@/lib/auth";
import { apiRequest, queryClient } from "@/lib/queryClient";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { Shield, Crown, Plus, Pencil, Trash2 } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
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
import { useState } from "react";
import type { Champion } from "@shared/schema";

function ChampionForm({
  champion,
  onSave,
  isPending,
}: {
  champion?: Champion;
  onSave: (data: { year: number; season: string; teamName: string; winningScore: string }) => void;
  isPending: boolean;
}) {
  const [year, setYear] = useState(champion?.year?.toString() || new Date().getFullYear().toString());
  const [season, setSeason] = useState(champion?.season || "");
  const [teamName, setTeamName] = useState(champion?.teamName || "");
  const [winningScore, setWinningScore] = useState(champion?.winningScore || "0");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSave({
      year: parseInt(year),
      season,
      teamName,
      winningScore,
    });
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div className="space-y-2">
        <Label htmlFor="year">Year</Label>
        <Input
          id="year"
          type="number"
          value={year}
          onChange={(e) => setYear(e.target.value)}
          required
          data-testid="input-champion-year"
        />
      </div>
      <div className="space-y-2">
        <Label htmlFor="season">Season (optional)</Label>
        <Input
          id="season"
          value={season}
          onChange={(e) => setSeason(e.target.value)}
          placeholder="e.g. Season 5"
          data-testid="input-champion-season"
        />
      </div>
      <div className="space-y-2">
        <Label htmlFor="teamName">Team Name</Label>
        <Input
          id="teamName"
          value={teamName}
          onChange={(e) => setTeamName(e.target.value)}
          required
          data-testid="input-champion-team-name"
        />
      </div>
      <div className="space-y-2">
        <Label htmlFor="winningScore">Winning Score</Label>
        <Input
          id="winningScore"
          type="number"
          step="0.1"
          value={winningScore}
          onChange={(e) => setWinningScore(e.target.value)}
          data-testid="input-champion-score"
        />
      </div>
      <DialogFooter>
        <Button type="submit" disabled={isPending} data-testid="button-save-champion">
          {isPending ? "Saving..." : champion ? "Update" : "Add Champion"}
        </Button>
      </DialogFooter>
    </form>
  );
}

export default function AdminChampionsPage() {
  const { user } = useAuth();
  const { toast } = useToast();
  const [editOpen, setEditOpen] = useState<string | null>(null);
  const [addOpen, setAddOpen] = useState(false);

  const { data: champions, isLoading } = useQuery<Champion[]>({
    queryKey: ["/api/champions"],
  });

  const createMutation = useMutation({
    mutationFn: async (data: { year: number; season: string; teamName: string; winningScore: string }) => {
      return await apiRequest("POST", "/api/admin/champions", data);
    },
    onSuccess: () => {
      toast({ title: "Champion entry added" });
      queryClient.invalidateQueries({ queryKey: ["/api/champions"] });
      setAddOpen(false);
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Error", description: error.message });
    },
  });

  const updateMutation = useMutation({
    mutationFn: async ({ id, data }: { id: string; data: { year: number; season: string; teamName: string; winningScore: string } }) => {
      return await apiRequest("PUT", `/api/admin/champions/${id}`, data);
    },
    onSuccess: () => {
      toast({ title: "Champion entry updated" });
      queryClient.invalidateQueries({ queryKey: ["/api/champions"] });
      setEditOpen(null);
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Error", description: error.message });
    },
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => {
      return await apiRequest("DELETE", `/api/admin/champions/${id}`);
    },
    onSuccess: () => {
      toast({ title: "Champion entry deleted" });
      queryClient.invalidateQueries({ queryKey: ["/api/champions"] });
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Error", description: error.message });
    },
  });

  if (!user?.isAdmin) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <Card className="max-w-md">
          <CardContent className="flex flex-col items-center justify-center py-12">
            <Shield className="h-12 w-12 text-muted-foreground mb-4" />
            <h3 className="text-lg font-semibold mb-2">Access Denied</h3>
            <p className="text-muted-foreground text-center">
              You don't have permission to manage champions
            </p>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
          <div className="flex items-center gap-3">
            <Crown className="h-8 w-8 text-accent" />
            <div>
              <h1 className="text-3xl font-bold text-foreground" data-testid="text-admin-champions-title">Manage Champions</h1>
              <p className="text-muted-foreground">Add and edit Hall of Fame entries</p>
            </div>
          </div>
          <Dialog open={addOpen} onOpenChange={setAddOpen}>
            <DialogTrigger asChild>
              <Button className="bg-accent text-accent-foreground" data-testid="button-add-champion">
                <Plus className="h-4 w-4 mr-2" />
                Add Champion
              </Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>Add Champion Entry</DialogTitle>
                <DialogDescription>Add a past champion to the Hall of Fame</DialogDescription>
              </DialogHeader>
              <ChampionForm
                onSave={(data) => createMutation.mutate(data)}
                isPending={createMutation.isPending}
              />
            </DialogContent>
          </Dialog>
        </div>

        {isLoading ? (
          <div className="space-y-4">
            {[1, 2, 3].map((i) => (
              <Card key={i}>
                <CardContent className="py-4">
                  <Skeleton className="h-12 w-full" />
                </CardContent>
              </Card>
            ))}
          </div>
        ) : champions && champions.length > 0 ? (
          <div className="space-y-3">
            {champions.map((champion) => (
              <Card key={champion.id}>
                <CardContent className="flex items-center justify-between py-4 gap-4">
                  <div className="flex items-center gap-3 min-w-0">
                    <Crown className="h-5 w-5 text-accent flex-shrink-0" />
                    <div className="min-w-0">
                      <p className="font-semibold truncate" data-testid={`text-admin-champion-${champion.id}`}>{champion.teamName}</p>
                      <div className="flex items-center gap-2 flex-wrap">
                        <span className="text-sm text-muted-foreground">{champion.year}</span>
                        {champion.season && (
                          <Badge variant="secondary">{champion.season}</Badge>
                        )}
                        {champion.winningScore && parseFloat(champion.winningScore) > 0 && (
                          <span className="text-sm text-muted-foreground">
                            Score: {parseFloat(champion.winningScore).toFixed(1)}
                          </span>
                        )}
                      </div>
                    </div>
                  </div>
                  <div className="flex items-center gap-2 flex-shrink-0">
                    <Dialog open={editOpen === champion.id} onOpenChange={(open) => setEditOpen(open ? champion.id : null)}>
                      <DialogTrigger asChild>
                        <Button size="icon" variant="ghost" data-testid={`button-edit-champion-${champion.id}`}>
                          <Pencil className="h-4 w-4" />
                        </Button>
                      </DialogTrigger>
                      <DialogContent>
                        <DialogHeader>
                          <DialogTitle>Edit Champion Entry</DialogTitle>
                          <DialogDescription>Update this Hall of Fame entry</DialogDescription>
                        </DialogHeader>
                        <ChampionForm
                          champion={champion}
                          onSave={(data) => updateMutation.mutate({ id: champion.id, data })}
                          isPending={updateMutation.isPending}
                        />
                      </DialogContent>
                    </Dialog>
                    <AlertDialog>
                      <AlertDialogTrigger asChild>
                        <Button size="icon" variant="ghost" data-testid={`button-delete-champion-${champion.id}`}>
                          <Trash2 className="h-4 w-4 text-destructive" />
                        </Button>
                      </AlertDialogTrigger>
                      <AlertDialogContent>
                        <AlertDialogHeader>
                          <AlertDialogTitle>Delete champion entry?</AlertDialogTitle>
                          <AlertDialogDescription>
                            Remove {champion.teamName} ({champion.year}) from the Hall of Fame?
                          </AlertDialogDescription>
                        </AlertDialogHeader>
                        <AlertDialogFooter>
                          <AlertDialogCancel>Cancel</AlertDialogCancel>
                          <AlertDialogAction
                            className="bg-destructive text-destructive-foreground"
                            onClick={() => deleteMutation.mutate(champion.id)}
                          >
                            Delete
                          </AlertDialogAction>
                        </AlertDialogFooter>
                      </AlertDialogContent>
                    </AlertDialog>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        ) : (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <Crown className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-semibold mb-2" data-testid="text-no-champions-admin">No Champions Yet</h3>
              <p className="text-muted-foreground text-center">
                Add your first champion entry to start building the Hall of Fame.
              </p>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
}

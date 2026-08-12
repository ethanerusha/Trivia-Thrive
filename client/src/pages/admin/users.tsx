import { useState } from "react";
import { Link } from "wouter";
import { useQuery, useMutation } from "@tanstack/react-query";
import { apiRequest } from "@/lib/queryClient";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { ArrowLeft, KeyRound, Loader2, Search, Users, Copy, Shield } from "lucide-react";

interface AdminUser {
  id: string;
  email: string;
  name: string;
  isAdmin: boolean;
}

export default function AdminUsersPage() {
  const { toast } = useToast();
  const [search, setSearch] = useState("");
  const [confirmUser, setConfirmUser] = useState<AdminUser | null>(null);
  const [resetResult, setResetResult] = useState<{ name: string; email: string; tempPassword: string } | null>(null);

  const { data: users, isLoading } = useQuery<AdminUser[]>({
    queryKey: ["/api/admin/users"],
  });

  const resetMutation = useMutation({
    mutationFn: async (userId: string) => {
      const res = await apiRequest("POST", `/api/admin/users/${userId}/reset-password`);
      return (await res.json()) as { tempPassword: string; email: string; name: string };
    },
    onSuccess: (data) => {
      setConfirmUser(null);
      setResetResult(data);
    },
    onError: (error: Error) => {
      toast({ variant: "destructive", title: "Reset failed", description: error.message });
    },
  });

  const filtered = users?.filter(
    (u) =>
      u.name.toLowerCase().includes(search.toLowerCase()) ||
      u.email.toLowerCase().includes(search.toLowerCase())
  );

  const copyTempPassword = () => {
    if (resetResult) {
      navigator.clipboard.writeText(resetResult.tempPassword);
      toast({ title: "Copied to clipboard" });
    }
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Link href="/admin" className="inline-flex items-center gap-1 text-sm text-muted-foreground hover:text-foreground mb-6" data-testid="link-back-to-admin">
          <ArrowLeft className="h-4 w-4" />
          Back to Admin
        </Link>

        <div className="flex items-center gap-3 mb-8">
          <Users className="h-8 w-8 text-accent" />
          <div>
            <h1 className="text-3xl font-bold text-foreground" data-testid="text-users-title">Users</h1>
            <p className="text-muted-foreground">Manage accounts and reset passwords</p>
          </div>
        </div>

        <div className="relative mb-6">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input
            placeholder="Search by name or email..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="pl-9"
            data-testid="input-user-search"
          />
        </div>

        {isLoading ? (
          <div className="space-y-3">
            {[1, 2, 3, 4].map((i) => (
              <Skeleton key={i} className="h-16 w-full" />
            ))}
          </div>
        ) : (
          <div className="space-y-3">
            {filtered?.map((user) => (
              <Card key={user.id} data-testid={`card-user-${user.id}`}>
                <CardContent className="flex items-center justify-between gap-3 py-4 flex-wrap">
                  <div className="min-w-0">
                    <p className="font-medium truncate flex items-center gap-2">
                      {user.name}
                      {user.isAdmin && (
                        <Badge variant="secondary" className="bg-accent/10 text-accent">
                          <Shield className="h-3 w-3 mr-1" />
                          Admin
                        </Badge>
                      )}
                    </p>
                    <p className="text-sm text-muted-foreground truncate">{user.email}</p>
                  </div>
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => setConfirmUser(user)}
                    data-testid={`button-reset-${user.id}`}
                  >
                    <KeyRound className="h-4 w-4 mr-2" />
                    Reset Password
                  </Button>
                </CardContent>
              </Card>
            ))}
            {filtered?.length === 0 && (
              <p className="text-center text-muted-foreground py-8">No users match your search</p>
            )}
          </div>
        )}

        {/* Confirm dialog */}
        <Dialog open={!!confirmUser} onOpenChange={(open) => !open && setConfirmUser(null)}>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>Reset password?</DialogTitle>
              <DialogDescription>
                This generates a new temporary password for {confirmUser?.name} ({confirmUser?.email}).
                Their current password will stop working immediately.
              </DialogDescription>
            </DialogHeader>
            <DialogFooter>
              <Button variant="outline" onClick={() => setConfirmUser(null)} data-testid="button-cancel-reset">
                Cancel
              </Button>
              <Button
                onClick={() => confirmUser && resetMutation.mutate(confirmUser.id)}
                disabled={resetMutation.isPending}
                data-testid="button-confirm-reset"
              >
                {resetMutation.isPending ? (
                  <>
                    <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                    Resetting...
                  </>
                ) : (
                  "Reset Password"
                )}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Result dialog */}
        <Dialog open={!!resetResult} onOpenChange={(open) => !open && setResetResult(null)}>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>Temporary password created</DialogTitle>
              <DialogDescription>
                Send this to {resetResult?.name} ({resetResult?.email}). It's shown only once — after they log
                in, they should change it under Account.
              </DialogDescription>
            </DialogHeader>
            <div className="flex items-center gap-2 p-3 bg-muted rounded-md font-mono text-lg justify-between">
              <span data-testid="text-temp-password">{resetResult?.tempPassword}</span>
              <Button variant="ghost" size="sm" onClick={copyTempPassword} data-testid="button-copy-password">
                <Copy className="h-4 w-4" />
              </Button>
            </div>
            <DialogFooter>
              <Button onClick={() => setResetResult(null)} data-testid="button-close-result">
                Done
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </div>
  );
}

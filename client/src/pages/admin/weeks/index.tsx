import { Link } from "wouter";
import { useQuery } from "@tanstack/react-query";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { ArrowLeft, Calendar, Plus, ArrowRight } from "lucide-react";
import type { Week } from "@shared/schema";

export default function AllWeeksPage() {
  const { data: weeks, isLoading } = useQuery<Week[]>({
    queryKey: ["/api/weeks"],
  });

  const sortedWeeks = weeks?.sort((a, b) => b.weekNumber - a.weekNumber) || [];

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Link href="/admin" className="inline-flex items-center text-muted-foreground hover:text-foreground mb-6">
          <ArrowLeft className="h-4 w-4 mr-2" />
          Back to Admin
        </Link>

        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
          <div className="flex items-center gap-3">
            <Calendar className="h-8 w-8 text-accent" />
            <div>
              <h1 className="text-3xl font-bold text-foreground">All Weeks</h1>
              <p className="text-muted-foreground">Manage all trivia weeks</p>
            </div>
          </div>
          <Link href="/admin/weeks/create">
            <Button className="bg-accent text-accent-foreground" data-testid="button-create-week">
              <Plus className="h-4 w-4 mr-2" />
              Create New Week
            </Button>
          </Link>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Trivia Weeks</CardTitle>
            <CardDescription>
              {sortedWeeks.length} week{sortedWeeks.length !== 1 ? "s" : ""} created
            </CardDescription>
          </CardHeader>
          <CardContent>
            {isLoading ? (
              <div className="space-y-3">
                {[1, 2, 3, 4, 5].map((i) => (
                  <Skeleton key={i} className="h-16 w-full" />
                ))}
              </div>
            ) : sortedWeeks.length > 0 ? (
              <div className="space-y-3">
                {sortedWeeks.map((week) => (
                  <Link key={week.id} href={`/admin/weeks/${week.id}`}>
                    <div className="flex items-center justify-between p-4 rounded-lg border hover:bg-muted/50 transition-colors cursor-pointer" data-testid={`week-row-${week.id}`}>
                      <div className="flex items-center gap-4">
                        <Badge variant={week.isActive ? "default" : "secondary"} className="min-w-[70px] justify-center">
                          Week {week.weekNumber}
                        </Badge>
                        <span className="font-medium">{week.title}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        {week.isActive && (
                          <Badge className="bg-success text-success-foreground">Active</Badge>
                        )}
                        {week.isGraded && (
                          <Badge variant="outline">Graded</Badge>
                        )}
                        {week.isPublished && (
                          <Badge className="bg-accent text-accent-foreground">Published</Badge>
                        )}
                        <ArrowRight className="h-4 w-4 text-muted-foreground" />
                      </div>
                    </div>
                  </Link>
                ))}
              </div>
            ) : (
              <div className="flex flex-col items-center justify-center py-12">
                <Calendar className="h-12 w-12 text-muted-foreground mb-4" />
                <h3 className="text-lg font-semibold mb-2">No Weeks Created</h3>
                <p className="text-muted-foreground text-center mb-4">
                  Create your first trivia week to get started
                </p>
                <Link href="/admin/weeks/create">
                  <Button className="bg-accent text-accent-foreground">
                    <Plus className="h-4 w-4 mr-2" />
                    Create Week
                  </Button>
                </Link>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}

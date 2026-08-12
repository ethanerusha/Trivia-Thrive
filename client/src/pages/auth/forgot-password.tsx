import { Link } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Trophy, ArrowLeft, KeyRound, Mail } from "lucide-react";

const ADMIN_EMAIL = "ethan.erusha@wwt.com";

export default function ForgotPasswordPage() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-background px-4 py-12">
      <Card className="w-full max-w-md">
        <CardHeader className="text-center">
          <div className="flex justify-center mb-4">
            <div className="w-16 h-16 rounded-full bg-accent/10 flex items-center justify-center">
              <Trophy className="h-8 w-8 text-accent" />
            </div>
          </div>
          <CardTitle className="text-2xl">Forgot your password?</CardTitle>
          <CardDescription>
            Password resets are handled by the trivia admins
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="flex items-start gap-3 p-4 bg-muted rounded-md text-sm">
            <KeyRound className="h-5 w-5 text-accent mt-0.5 flex-shrink-0" />
            <p>
              Email the trivia admin and we'll send you a temporary password. You can then change it
              under <span className="font-medium">Account</span> after logging in.
            </p>
          </div>
          <Button asChild className="w-full" data-testid="button-email-admin">
            <a href={`mailto:${ADMIN_EMAIL}?subject=Tuesday Trivia password reset`}>
              <Mail className="h-4 w-4 mr-2" />
              Email {ADMIN_EMAIL}
            </a>
          </Button>
          <Link href="/login" className="flex items-center justify-center gap-1 text-sm text-muted-foreground hover:text-foreground" data-testid="link-back-to-login">
            <ArrowLeft className="h-4 w-4" />
            Back to login
          </Link>
        </CardContent>
      </Card>
    </div>
  );
}

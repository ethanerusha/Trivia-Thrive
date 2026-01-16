import { Link } from "wouter";
import { Button } from "@/components/ui/button";
import { Trophy, Users, ClipboardList, Award } from "lucide-react";
import heroImage from "@assets/generated_images/corporate_trivia_competition_hero.png";

export default function LandingPage() {
  return (
    <div className="min-h-screen">
      <div className="relative h-[70vh] min-h-[500px] flex items-center justify-center overflow-hidden">
        <div
          className="absolute inset-0 bg-cover bg-center"
          style={{ backgroundImage: `url(${heroImage})` }}
        />
        <div className="absolute inset-0 bg-gradient-to-b from-primary/90 via-primary/85 to-primary/95" />
        
        <div className="relative z-10 text-center px-4 max-w-4xl mx-auto">
          <div className="flex items-center justify-center gap-3 mb-6">
            <Trophy className="h-12 w-12 text-accent" />
          </div>
          <h1 className="text-4xl sm:text-5xl lg:text-6xl font-bold text-white mb-4">
            Tuesday Trivia
          </h1>
          <p className="text-2xl sm:text-3xl text-accent font-semibold italic mb-6">
            Season 6
          </p>
          <p className="text-lg sm:text-xl text-white/90 mb-8 max-w-2xl mx-auto">
            Where WWT teams compete weekly for trivia glory. 
            Form your team, answer questions, and climb the leaderboard!
          </p>
          <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
            <Link href="/register">
              <Button 
                size="lg" 
                className="bg-accent text-accent-foreground hover:bg-accent/90 text-lg px-8 py-6 font-semibold"
                data-testid="hero-register"
              >
                Join Season 6
              </Button>
            </Link>
            <Link href="/login">
              <Button 
                size="lg" 
                variant="outline" 
                className="text-lg px-8 py-6 border-white/30 text-white bg-white/10 backdrop-blur-sm hover:bg-white/20"
                data-testid="hero-login"
              >
                Sign In
              </Button>
            </Link>
          </div>
        </div>
      </div>

      <div className="bg-background py-16 px-4">
        <div className="max-w-6xl mx-auto">
          <h2 className="text-3xl font-bold text-center mb-12 text-foreground">
            How It Works
          </h2>
          <div className="grid md:grid-cols-4 gap-8">
            <FeatureCard
              icon={Users}
              title="Form Your Team"
              description="Create or join a team with your colleagues. Teams of 3 are ideal for trophy eligibility!"
            />
            <FeatureCard
              icon={ClipboardList}
              title="Weekly Questions"
              description="Every week, 10 new trivia questions are posted. Work together to find the answers."
            />
            <FeatureCard
              icon={Award}
              title="Submit & Score"
              description="Submit your team's answers before the deadline. Earn points for each correct response."
            />
            <FeatureCard
              icon={Trophy}
              title="Climb the Ranks"
              description="Track your progress on the leaderboard and compete for Season 6 championship!"
            />
          </div>
        </div>
      </div>

      <footer className="bg-primary py-8 px-4">
        <div className="max-w-6xl mx-auto text-center">
          <p className="text-primary-foreground/70 text-sm">
            Tuesday Trivia: Season 6 - Exclusively for WWT employees
          </p>
        </div>
      </footer>
    </div>
  );
}

function FeatureCard({ 
  icon: Icon, 
  title, 
  description 
}: { 
  icon: typeof Trophy; 
  title: string; 
  description: string;
}) {
  return (
    <div className="text-center p-6">
      <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-accent/10 mb-4">
        <Icon className="h-8 w-8 text-accent" />
      </div>
      <h3 className="text-lg font-semibold mb-2 text-foreground">{title}</h3>
      <p className="text-muted-foreground">{description}</p>
    </div>
  );
}

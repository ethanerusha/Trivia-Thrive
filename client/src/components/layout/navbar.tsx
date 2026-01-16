import { Link, useLocation } from "wouter";
import { useAuth } from "@/lib/auth";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Menu, Trophy, Users, ClipboardList, Archive, Settings, LogOut, Home, Shield } from "lucide-react";
import { useState } from "react";
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/sheet";

export function Navbar() {
  const { user, logout } = useAuth();
  const [location] = useLocation();
  const [mobileOpen, setMobileOpen] = useState(false);

  const navItems = [
    { href: "/dashboard", label: "Dashboard", icon: Home },
    { href: "/teams", label: "Teams", icon: Users },
    { href: "/leaderboard", label: "Leaderboard", icon: Trophy },
    { href: "/archives", label: "Archives", icon: Archive },
  ];

  const getInitials = (name: string) => {
    return name
      .split(" ")
      .map((n) => n[0])
      .join("")
      .toUpperCase()
      .slice(0, 2);
  };

  return (
    <nav className="sticky top-0 z-50 bg-primary border-b-2 border-accent">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16 gap-4">
          <Link href={user ? "/dashboard" : "/"} className="flex items-center gap-2 flex-shrink-0">
            <Trophy className="h-6 w-6 text-accent" />
            <span className="font-bold text-lg text-primary-foreground">Tuesday Trivia</span>
            <span className="text-accent italic text-sm hidden sm:inline">Season 10</span>
          </Link>

          {user && (
            <>
              <div className="hidden md:flex items-center gap-1">
                {navItems.map((item) => (
                  <Link key={item.href} href={item.href}>
                    <Button
                      variant={location === item.href ? "secondary" : "ghost"}
                      size="sm"
                      className={location === item.href 
                        ? "bg-primary-foreground/10 text-primary-foreground" 
                        : "text-primary-foreground/80 hover:text-primary-foreground hover:bg-primary-foreground/10"
                      }
                      data-testid={`nav-${item.label.toLowerCase()}`}
                    >
                      <item.icon className="h-4 w-4 mr-1" />
                      {item.label}
                    </Button>
                  </Link>
                ))}
                {user.isAdmin && (
                  <Link href="/admin">
                    <Button
                      variant={location.startsWith("/admin") ? "secondary" : "ghost"}
                      size="sm"
                      className={location.startsWith("/admin")
                        ? "bg-accent text-accent-foreground"
                        : "text-accent hover:bg-accent/20"
                      }
                      data-testid="nav-admin"
                    >
                      <Shield className="h-4 w-4 mr-1" />
                      Admin
                    </Button>
                  </Link>
                )}
              </div>

              <div className="flex items-center gap-2">
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" className="h-9 w-9 rounded-full p-0" data-testid="user-menu-trigger">
                      <Avatar className="h-8 w-8 border-2 border-accent">
                        <AvatarFallback className="bg-accent text-accent-foreground text-sm font-semibold">
                          {getInitials(user.name)}
                        </AvatarFallback>
                      </Avatar>
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent align="end" className="w-48">
                    <div className="px-2 py-1.5">
                      <p className="text-sm font-medium">{user.name}</p>
                      <p className="text-xs text-muted-foreground">{user.email}</p>
                    </div>
                    <DropdownMenuSeparator />
                    <DropdownMenuItem asChild>
                      <Link href="/my-team" className="cursor-pointer" data-testid="menu-my-team">
                        <Users className="h-4 w-4 mr-2" />
                        My Team
                      </Link>
                    </DropdownMenuItem>
                    <DropdownMenuItem asChild>
                      <Link href="/submissions" className="cursor-pointer" data-testid="menu-submissions">
                        <ClipboardList className="h-4 w-4 mr-2" />
                        Submissions
                      </Link>
                    </DropdownMenuItem>
                    <DropdownMenuSeparator />
                    <DropdownMenuItem onClick={logout} className="text-destructive cursor-pointer" data-testid="menu-logout">
                      <LogOut className="h-4 w-4 mr-2" />
                      Log out
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>

                <Sheet open={mobileOpen} onOpenChange={setMobileOpen}>
                  <SheetTrigger asChild className="md:hidden">
                    <Button variant="ghost" size="icon" className="text-primary-foreground" data-testid="mobile-menu-trigger">
                      <Menu className="h-5 w-5" />
                    </Button>
                  </SheetTrigger>
                  <SheetContent side="right" className="bg-primary border-l-accent w-64">
                    <div className="flex flex-col gap-2 mt-8">
                      {navItems.map((item) => (
                        <Link key={item.href} href={item.href} onClick={() => setMobileOpen(false)}>
                          <Button
                            variant="ghost"
                            className={`w-full justify-start ${
                              location === item.href
                                ? "bg-primary-foreground/10 text-primary-foreground"
                                : "text-primary-foreground/80"
                            }`}
                          >
                            <item.icon className="h-4 w-4 mr-2" />
                            {item.label}
                          </Button>
                        </Link>
                      ))}
                      {user.isAdmin && (
                        <Link href="/admin" onClick={() => setMobileOpen(false)}>
                          <Button
                            variant="ghost"
                            className={`w-full justify-start ${
                              location.startsWith("/admin")
                                ? "bg-accent text-accent-foreground"
                                : "text-accent"
                            }`}
                          >
                            <Shield className="h-4 w-4 mr-2" />
                            Admin Portal
                          </Button>
                        </Link>
                      )}
                    </div>
                  </SheetContent>
                </Sheet>
              </div>
            </>
          )}

          {!user && (
            <div className="flex items-center gap-2">
              <Link href="/login">
                <Button variant="ghost" className="text-primary-foreground" data-testid="nav-login">
                  Login
                </Button>
              </Link>
              <Link href="/register">
                <Button className="bg-accent text-accent-foreground hover:bg-accent/90" data-testid="nav-register">
                  Register
                </Button>
              </Link>
            </div>
          )}
        </div>
      </div>
    </nav>
  );
}

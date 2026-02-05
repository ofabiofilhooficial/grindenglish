import { Link, useLocation } from 'react-router-dom';
import { cn } from '@/lib/utils';
import { 
  LayoutDashboard, 
  GraduationCap, 
  BookOpen, 
  Languages, 
  Mic, 
  Speech, 
  FolderOpen, 
  BarChart3,
  RefreshCw,
  Settings,
  LogOut,
  ChevronRight,
  Sparkles
} from 'lucide-react';
import { Button } from '@/components/ui/button';
import { ProgressRing } from '@/components/ui/progress-ring';
import { LevelBadge } from '@/components/ui/level-badge';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Separator } from '@/components/ui/separator';

interface NavItem {
  label: string;
  href: string;
  icon: React.ElementType;
  badge?: string | number;
}

const mainNavItems: NavItem[] = [
  { label: 'Dashboard', href: '/dashboard', icon: LayoutDashboard },
  { label: 'My Course', href: '/course', icon: GraduationCap },
  { label: 'Review Center', href: '/review', icon: RefreshCw, badge: 12 },
  { label: 'Portfolio', href: '/portfolio', icon: FolderOpen },
  { label: 'Progress', href: '/progress', icon: BarChart3 },
];

const referenceNavItems: NavItem[] = [
  { label: 'Vocabulary', href: '/lexicon', icon: BookOpen },
  { label: 'Grammar', href: '/grammar', icon: Languages },
  { label: 'Pronunciation', href: '/pronunciation', icon: Mic },
  { label: 'Pragmatics', href: '/pragmatics', icon: Speech },
];

interface AppSidebarProps {
  className?: string;
}

export function AppSidebar({ className }: AppSidebarProps) {
  const location = useLocation();

  const NavLink = ({ item }: { item: NavItem }) => {
    const isActive = location.pathname === item.href || location.pathname.startsWith(item.href + '/');
    
    return (
      <Link to={item.href}>
        <Button
          variant="ghost"
          className={cn(
            "w-full justify-start gap-3 px-3 py-2.5 h-auto font-medium",
            "text-sidebar-foreground/70 hover:text-sidebar-foreground hover:bg-sidebar-accent",
            isActive && "bg-sidebar-accent text-sidebar-primary font-semibold"
          )}
        >
          <item.icon size={20} className={cn(isActive && "text-sidebar-primary")} />
          <span className="flex-1 text-left">{item.label}</span>
          {item.badge && (
            <span className="flex h-5 min-w-5 items-center justify-center rounded-full bg-accent text-xs font-semibold text-accent-foreground px-1.5">
              {item.badge}
            </span>
          )}
          {isActive && <ChevronRight size={16} className="text-sidebar-primary" />}
        </Button>
      </Link>
    );
  };

  return (
    <aside className={cn(
      "flex h-screen w-64 flex-col bg-sidebar border-r border-sidebar-border",
      className
    )}>
      {/* Logo */}
      <div className="flex items-center gap-3 px-4 py-5 border-b border-sidebar-border">
        <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-gradient-primary shadow-lg">
          <Sparkles className="h-5 w-5 text-white" />
        </div>
        <div>
          <h1 className="font-display font-bold text-lg text-sidebar-foreground">English Mastery</h1>
          <p className="text-xs text-sidebar-foreground/60">Lab</p>
        </div>
      </div>

      {/* User Progress Card */}
      <div className="mx-3 mt-4 rounded-xl bg-sidebar-accent p-4">
        <div className="flex items-center gap-3">
          <ProgressRing progress={65} size={48} strokeWidth={4}>
            <LevelBadge level="B1" size="sm" />
          </ProgressRing>
          <div className="flex-1 min-w-0">
            <p className="text-sm font-semibold text-sidebar-foreground truncate">Unit 4 of 10</p>
            <p className="text-xs text-sidebar-foreground/60">B1 Intermediate</p>
          </div>
        </div>
        <div className="mt-3 flex items-center justify-between text-xs">
          <span className="text-sidebar-foreground/60">65% complete</span>
          <span className="font-semibold text-accent">🔥 7 day streak</span>
        </div>
      </div>

      <ScrollArea className="flex-1 px-3 py-4">
        {/* Main Navigation */}
        <nav className="space-y-1">
          {mainNavItems.map((item) => (
            <NavLink key={item.href} item={item} />
          ))}
        </nav>

        <Separator className="my-4 bg-sidebar-border" />

        {/* Reference Section */}
        <div className="mb-2">
          <p className="px-3 text-xs font-semibold text-sidebar-foreground/50 uppercase tracking-wider">
            Reference
          </p>
        </div>
        <nav className="space-y-1">
          {referenceNavItems.map((item) => (
            <NavLink key={item.href} item={item} />
          ))}
        </nav>
      </ScrollArea>

      {/* Bottom Section */}
      <div className="border-t border-sidebar-border p-3 space-y-1">
        <Link to="/settings">
          <Button
            variant="ghost"
            className="w-full justify-start gap-3 px-3 text-sidebar-foreground/70 hover:text-sidebar-foreground hover:bg-sidebar-accent"
          >
            <Settings size={20} />
            <span>Settings</span>
          </Button>
        </Link>
        <Button
          variant="ghost"
          className="w-full justify-start gap-3 px-3 text-sidebar-foreground/70 hover:text-destructive hover:bg-destructive/10"
        >
          <LogOut size={20} />
          <span>Sign Out</span>
        </Button>
      </div>
    </aside>
  );
}

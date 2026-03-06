import { Link, useLocation, useNavigate } from 'react-router-dom';
import { cn } from '@/lib/utils';
import { useAuth } from '@/hooks/useAuth';
import {
  LayoutDashboard, GraduationCap, BookOpen, Languages, Mic, Speech,
  FolderOpen, BarChart3, RefreshCw, Settings, LogOut, ChevronRight,
  Sparkles, Users, FileText, Headphones, MessageSquare, Upload,
  UsersRound, ClipboardList, LineChart, Tags
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

const learnerNavItems: NavItem[] = [
  { label: 'Dashboard', href: '/dashboard', icon: LayoutDashboard },
  { label: 'My Course', href: '/course', icon: GraduationCap },
  { label: 'Review Center', href: '/review', icon: RefreshCw },
  { label: 'Portfolio', href: '/portfolio', icon: FolderOpen },
  { label: 'Progress', href: '/progress', icon: BarChart3 },
];

const referenceNavItems: NavItem[] = [
  { label: 'Vocabulary', href: '/lexicon', icon: BookOpen },
  { label: 'Grammar', href: '/grammar', icon: Languages },
  { label: 'Pronunciation', href: '/pronunciation', icon: Mic },
  { label: 'Pragmatics', href: '/pragmatics', icon: Speech },
];

const authorNavItems: NavItem[] = [
  { label: 'Course Builder', href: '/author/courses', icon: GraduationCap },
  { label: 'Lexicon Manager', href: '/author/lexicon', icon: BookOpen },
  { label: 'Grammar Chapters', href: '/author/grammar', icon: Languages },
  { label: 'Pronunciation Lab', href: '/author/pronunciation', icon: Headphones },
  { label: 'Pragmatics Lab', href: '/author/pragmatics', icon: MessageSquare },
  { label: 'Asset Manager', href: '/author/assets', icon: Upload },
  { label: 'Tags', href: '/author/tags', icon: Tags },
];

const teacherNavItems: NavItem[] = [
  { label: 'Cohorts', href: '/teach/dashboard', icon: UsersRound },
  { label: 'Feedback Queue', href: '/teach/feedback', icon: ClipboardList },
  { label: 'Student Analytics', href: '/teach/analytics', icon: LineChart },
];

const adminNavItems: NavItem[] = [
  { label: 'User Management', href: '/admin/users', icon: Users },
  { label: 'Settings', href: '/admin/settings', icon: Settings },
];

interface AppSidebarProps {
  className?: string;
}

export function AppSidebar({ className }: AppSidebarProps) {
  const location = useLocation();
  const navigate = useNavigate();
  const { profile, isContentCreator, isTeacher, isAdmin, signOut } = useAuth();

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

  const SectionHeader = ({ label }: { label: string }) => (
    <div className="mb-2 mt-1">
      <p className="px-3 text-xs font-semibold text-sidebar-foreground/50 uppercase tracking-wider">
        {label}
      </p>
    </div>
  );

  const handleSignOut = async () => {
    await signOut();
    navigate('/');
  };

  return (
    <aside className={cn(
      "flex h-screen w-64 flex-col bg-sidebar border-r border-sidebar-border",
      className
    )}>
      {/* Logo */}
      <div className="flex items-center gap-3 px-4 py-5 border-b border-sidebar-border">
        <img 
          src="/icon.png" 
          alt="Grind English" 
          className="h-10 w-10"
        />
        <div>
          <h1 className="font-display font-bold text-lg text-sidebar-foreground uppercase tracking-wide">Grind English</h1>
        </div>
      </div>

      {/* User Info */}
      <div className="mx-3 mt-4 rounded-xl bg-sidebar-accent p-4">
        <div className="flex items-center gap-3">
          <div className="flex h-10 w-10 items-center justify-center rounded-full bg-primary text-primary-foreground font-semibold text-sm">
            {profile?.full_name?.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase() || '?'}
          </div>
          <div className="flex-1 min-w-0">
            <p className="text-sm font-semibold text-sidebar-foreground truncate">
              {profile?.full_name || 'User'}
            </p>
            <p className="text-xs text-sidebar-foreground/60 capitalize">
              {isAdmin ? 'Admin' : isContentCreator ? 'Author' : isTeacher ? 'Teacher' : 'Learner'}
            </p>
          </div>
        </div>
      </div>

      <ScrollArea className="flex-1 px-3 py-4">
        {/* Main Navigation */}
        <nav className="space-y-1">
          {learnerNavItems.map((item) => (
            <NavLink key={item.href} item={item} />
          ))}
        </nav>

        <Separator className="my-4 bg-sidebar-border" />

        {/* Reference Section */}
        <SectionHeader label="Reference" />
        <nav className="space-y-1">
          {referenceNavItems.map((item) => (
            <NavLink key={item.href} item={item} />
          ))}
        </nav>

        {/* Authoring Section - visible to admins and curriculum designers */}
        {isContentCreator && (
          <>
            <Separator className="my-4 bg-sidebar-border" />
            <SectionHeader label="Authoring" />
            <nav className="space-y-1">
              {authorNavItems.map((item) => (
                <NavLink key={item.href} item={item} />
              ))}
            </nav>
          </>
        )}

        {/* Teaching Section - visible to teachers, admins, curriculum designers */}
        {(isTeacher || isContentCreator) && (
          <>
            <Separator className="my-4 bg-sidebar-border" />
            <SectionHeader label="Teaching" />
            <nav className="space-y-1">
              {teacherNavItems.map((item) => (
                <NavLink key={item.href} item={item} />
              ))}
            </nav>
          </>
        )}

        {/* Admin Section */}
        {isAdmin && (
          <>
            <Separator className="my-4 bg-sidebar-border" />
            <SectionHeader label="Admin" />
            <nav className="space-y-1">
              {adminNavItems.map((item) => (
                <NavLink key={item.href} item={item} />
              ))}
            </nav>
          </>
        )}
      </ScrollArea>

      {/* Bottom Section */}
      <div className="border-t border-sidebar-border p-3 space-y-1">
        <Button
          variant="ghost"
          className="w-full justify-start gap-3 px-3 text-sidebar-foreground/70 hover:text-destructive hover:bg-destructive/10"
          onClick={handleSignOut}
        >
          <LogOut size={20} />
          <span>Sign Out</span>
        </Button>
      </div>
    </aside>
  );
}

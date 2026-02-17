import { useAuth } from '@/contexts/AuthContext'
import { Link, useLocation } from 'react-router-dom'
import { cn } from '@/lib/utils'
import {
  LayoutDashboard,
  Book,
  Users,
  BarChart3,
  Settings,
  LogOut,
  FileText,
  Briefcase,
  Mic,
  MessageSquare,
  Layers,
} from 'lucide-react'
import { Button } from '@/components/ui/button'

export const AppSidebar = () => {
  const { user, hasRole, signOut } = useAuth()
  const location = useLocation()

  if (!user) return null

  const navItems = [
    // All roles
    { href: '/dashboard', label: 'Dashboard', icon: LayoutDashboard, show: true },
    { href: '/course', label: 'My Course', icon: Book, show: true },
    { href: '/review', label: 'Review Center', icon: FileText, show: true },
    { href: '/portfolio', label: 'Portfolio', icon: Briefcase, show: true },
    { href: '/progress', label: 'Progress', icon: BarChart3, show: true },
    { href: '/reference', label: 'Reference', icon: Book, show: true },

    // Teachers
    { href: '/teach/dashboard', label: 'Cohort Dashboard', icon: Users, show: hasRole('teacher') || hasRole('admin') },
    { href: '/teach/feedback', label: 'Feedback Queue', icon: MessageSquare, show: hasRole('teacher') || hasRole('admin') },
    { href: '/teach/analytics', label: 'Student Analytics', icon: BarChart3, show: hasRole('teacher') || hasRole('admin') },

    // Authors/Curriculum Designers
    { href: '/author/courses', label: 'Course Builder', icon: Book, show: hasRole('curriculum_designer') || hasRole('admin') },
    { href: '/author/lexicon', label: 'Lexicon Manager', icon: FileText, show: hasRole('curriculum_designer') || hasRole('admin') },
    { href: '/author/grammar', label: 'Grammar Chapters', icon: Layers, show: hasRole('curriculum_designer') || hasRole('admin') },
    { href: '/author/pronunciation', label: 'Pronunciation Lab', icon: Mic, show: hasRole('curriculum_designer') || hasRole('admin') },
    { href: '/author/pragmatics', label: 'Pragmatics Lab', icon: MessageSquare, show: hasRole('curriculum_designer') || hasRole('admin') },
    { href: '/author/assets', label: 'Asset Manager', icon: Layers, show: hasRole('curriculum_designer') || hasRole('admin') },

    // Admins only
    { href: '/admin/users', label: 'User Management', icon: Users, show: hasRole('admin') },
    { href: '/admin/settings', label: 'Organization Settings', icon: Settings, show: hasRole('admin') },
  ]

  const visibleItems = navItems.filter(item => item.show)

  return (
    <aside className="w-64 bg-slate-900 text-white h-screen overflow-y-auto sticky top-0">
      <div className="p-6 border-b border-slate-700">
        <h1 className="text-2xl font-bold">English Compass</h1>
        <p className="text-sm text-slate-400 mt-1">Welcome, {user.profile.full_name}</p>
      </div>

      <nav className="p-4 space-y-2">
        {visibleItems.map((item) => (
          <Link
            key={item.href}
            to={item.href}
            className={cn(
              'flex items-center gap-3 px-4 py-2 rounded-md transition-colors',
              location.pathname === item.href
                ? 'bg-blue-600 text-white'
                : 'text-slate-300 hover:bg-slate-800'
            )}
          >
            <item.icon className="w-5 h-5" />
            <span>{item.label}</span>
          </Link>
        ))}
      </nav>

      <div className="absolute bottom-0 left-0 right-0 p-4 border-t border-slate-700">
        <Button
          variant="ghost"
          className="w-full justify-start text-slate-300 hover:bg-slate-800 hover:text-white"
          onClick={signOut}
        >
          <LogOut className="w-5 h-5 mr-3" />
          Sign Out
        </Button>
      </div>
    </aside>
  )
}

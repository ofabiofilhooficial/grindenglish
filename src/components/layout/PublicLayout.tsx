import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';

interface PublicLayoutProps {
  children: React.ReactNode;
  title?: string;
}

export function PublicLayout({ children, title }: PublicLayoutProps) {
  return (
    <div className="min-h-screen bg-background text-foreground flex flex-col">
      <header className="border-b border-border bg-card/80 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl items-center justify-between px-4 py-4 sm:px-6">
          <Link to="/" className="flex items-center gap-3">
            <img src="/icon.png" alt="Grind English" className="h-10 w-10 rounded-lg" />
            <div>
              <p className="text-lg font-semibold">Grind English</p>
              <p className="text-xs text-muted-foreground uppercase tracking-[0.2em]">Learn smarter</p>
            </div>
          </Link>
          <nav className="hidden items-center gap-3 md:flex">
            <Link to="/" className="text-sm font-medium text-muted-foreground hover:text-foreground">Home</Link>
            <Link to="/how-it-works" className="text-sm font-medium text-muted-foreground hover:text-foreground">How it Works</Link>
            <Link to="/pricing" className="text-sm font-medium text-muted-foreground hover:text-foreground">Pricing</Link>
            <Link to="/faq" className="text-sm font-medium text-muted-foreground hover:text-foreground">FAQ</Link>
            <Link to="/login">
              <Button size="sm">Login</Button>
            </Link>
          </nav>
        </div>
      </header>

      <main className="flex-1">
        {title && (
          <div className="border-b border-border bg-slate-50/60 px-4 py-6 sm:px-6">
            <div className="mx-auto max-w-7xl">
              <h1 className="text-3xl font-semibold tracking-tight text-foreground sm:text-4xl">{title}</h1>
            </div>
          </div>
        )}
        <div className="mx-auto max-w-7xl px-4 py-10 sm:px-6">{children}</div>
      </main>

      <footer className="border-t border-border bg-card px-4 py-6 sm:px-6">
        <div className="mx-auto flex max-w-7xl flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <p className="text-sm text-muted-foreground">© {new Date().getFullYear()} Grind English. All rights reserved.</p>
          <div className="flex flex-wrap gap-3 text-sm text-muted-foreground">
            <Link to="/privacy" className="hover:text-foreground">Privacy</Link>
            <Link to="/terms" className="hover:text-foreground">Terms</Link>
            <Link to="/contact" className="hover:text-foreground">Contact</Link>
          </div>
        </div>
      </footer>
    </div>
  );
}

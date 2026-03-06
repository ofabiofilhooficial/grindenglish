import { useState, useEffect } from 'react';
import { Link, Navigate, useNavigate } from 'react-router-dom';
import { useAuth } from '@/hooks/useAuth';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Separator } from '@/components/ui/separator';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from '@/components/ui/dialog';
import { supabase } from '@/integrations/supabase/client';
import { lovable } from '@/integrations/lovable/index';
import { useToast } from '@/hooks/use-toast';
import { 
  Headphones, 
  Target, 
  MessageCircle, 
  ArrowRight,
  Shield,
  Play,
  Globe,
  Sparkles
} from 'lucide-react';

export default function LandingPage() {
  const { user, loading } = useAuth();
  const navigate = useNavigate();
  const { toast } = useToast();
  const [lang, setLang] = useState<'en' | 'pt'>('en');
  const [authOpen, setAuthOpen] = useState(false);
  const [isSignup, setIsSignup] = useState(true);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [fullName, setFullName] = useState('');
  const [authLoading, setAuthLoading] = useState(false);

  useEffect(() => {
    if (!loading && !user) {
      const timer = setTimeout(() => setAuthOpen(true), 2000);
      return () => clearTimeout(timer);
    }
  }, [loading, user]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setAuthLoading(true);
    if (isSignup) {
      const { error } = await supabase.auth.signUp({ email, password, options: { data: { full_name: fullName }, emailRedirectTo: window.location.origin } });
      if (error) toast({ title: 'Signup failed', description: error.message, variant: 'destructive' });
      else { toast({ title: 'Check your email', description: 'We sent you a confirmation link.' }); setAuthOpen(false); }
    } else {
      const { error } = await supabase.auth.signInWithPassword({ email, password });
      if (error) toast({ title: 'Sign in failed', description: error.message, variant: 'destructive' });
      else navigate('/dashboard');
    }
    setAuthLoading(false);
  };

  const handleGoogle = async () => {
    const { error } = await lovable.auth.signInWithOAuth("google", { redirect_uri: window.location.origin });
    if (error) toast({ title: 'Google sign in failed', description: error.message, variant: 'destructive' });
  };

  if (!loading && user) {
    return <Navigate to="/dashboard" replace />;
  }

  const t = lang === 'pt' ? {
    hero: 'Pare de "estudar" inglês. Comece a usar.',
    sub: 'O caminho mais rápido para brasileiros saírem do zero até a primeira conversa real. Sem regras chatas de gramática—só resultados.',
    cta: 'Comece Sua Primeira Aula – Grátis',
    video: 'Veja como funciona (vídeo de 2 min)',
    step1title: 'Ouça & Leia',
    step1desc: 'Acompanhe histórias simples e interessantes feitas pro seu nível.',
    step2title: 'Pratique',
    step2desc: 'Complete "Missões" que imitam situações da vida real.',
    step3title: 'Fale',
    step3desc: 'Use o que aprendeu numa conversa de verdade.',
    fearTitle: 'Medo de errar?',
    fearText: 'Nosso sistema "Protocolo Alpha" foi feito pra construir sua confiança passo a passo, mesmo se você não souber uma palavra sequer.',
    hook: 'Sua primeira missão em inglês começa em 60 segundos. Você tá pronto?',
    hookCta: 'Aceitar a Missão',
    toggle: 'English',
  } : {
    hero: 'Stop "Studying" English. Start Using It.',
    sub: 'The fastest way for Brazilians to go from zero to your first real conversation. No boring grammar rules—just results.',
    cta: 'Start Your First Lesson – Free',
    video: 'See how it works (2-min video)',
    step1title: 'Listen & Read',
    step1desc: 'Follow simple, interesting stories designed for your level.',
    step2title: 'Practice',
    step2desc: 'Complete "Missions" that mimic real-life situations.',
    step3title: 'Speak',
    step3desc: 'Use what you learned in a real conversation.',
    fearTitle: 'Afraid of making mistakes?',
    fearText: 'Our "Protocol Alpha" system is designed to build your confidence step-by-step, even if you don\'t know a single word yet.',
    hook: 'Your first English mission starts in 60 seconds. Are you ready?',
    hookCta: 'Accept the Mission',
    toggle: 'Português',
  };

  return (
    <div className="min-h-screen bg-background">
      {/* Language Toggle */}
      <div className="fixed top-4 right-4 z-50">
        <button
          onClick={() => setLang(lang === 'en' ? 'pt' : 'en')}
          className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-card border border-border text-sm font-medium text-muted-foreground hover:text-foreground transition-colors"
        >
          <Globe className="h-4 w-4" />
          {t.toggle}
        </button>
      </div>

      {/* Hero */}
      <section className="relative flex min-h-[85vh] items-center justify-center overflow-hidden px-4">
        <div className="absolute inset-0 -z-10">
          <div className="absolute top-1/4 left-1/4 w-[30rem] h-[30rem] bg-primary/5 rounded-full blur-3xl" />
          <div className="absolute bottom-1/4 right-1/4 w-[25rem] h-[25rem] bg-accent/8 rounded-full blur-3xl" />
        </div>

        <div className="max-w-2xl text-center">
          <h1 className="font-display text-4xl sm:text-5xl md:text-6xl font-bold tracking-tight mb-6 text-foreground">
            {t.hero}
          </h1>
          <p className="text-lg sm:text-xl text-muted-foreground mb-10 leading-relaxed">
            {t.sub}
          </p>
          <div className="flex flex-col items-center gap-4">
            <Link to="/signup">
              <Button size="lg" className="bg-accent text-accent-foreground hover:bg-accent/90 shadow-accent-glow text-lg px-10 py-6 h-auto font-semibold">
                {t.cta}
                <ArrowRight className="ml-2 h-5 w-5" />
              </Button>
            </Link>
            <button className="flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors text-sm">
              <Play className="h-4 w-4" />
              {t.video}
            </button>
          </div>
        </div>
      </section>

      {/* 3-Step Path */}
      <section className="py-24 px-4">
        <div className="max-w-4xl mx-auto grid md:grid-cols-3 gap-12 md:gap-8">
          {[
            { icon: Headphones, num: '01', title: t.step1title, desc: t.step1desc },
            { icon: Target, num: '02', title: t.step2title, desc: t.step2desc },
            { icon: MessageCircle, num: '03', title: t.step3title, desc: t.step3desc },
          ].map((step) => (
            <div key={step.num} className="text-center">
              <div className="flex h-16 w-16 items-center justify-center rounded-2xl bg-primary/10 text-primary mx-auto mb-5">
                <step.icon className="h-7 w-7" />
              </div>
              <span className="text-xs font-semibold text-muted-foreground tracking-widest uppercase">{step.num}</span>
              <h3 className="font-display text-xl font-bold mt-1 mb-2 text-foreground">{step.title}</h3>
              <p className="text-muted-foreground leading-relaxed">{step.desc}</p>
            </div>
          ))}
        </div>
      </section>

      {/* No-Fear Section */}
      <section className="py-24 px-4">
        <div className="max-w-xl mx-auto text-center">
          <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-accent/15 text-accent mx-auto mb-6">
            <Shield className="h-7 w-7" />
          </div>
          <h2 className="font-display text-3xl font-bold mb-4 text-foreground">{t.fearTitle}</h2>
          <p className="text-lg text-muted-foreground leading-relaxed">{t.fearText}</p>
        </div>
      </section>

      {/* Hook CTA */}
      <section className="py-24 px-4">
        <div className="max-w-2xl mx-auto text-center bg-gradient-hero rounded-3xl p-12 md:p-16">
          <h2 className="font-display text-2xl sm:text-3xl font-bold mb-6 text-white">{t.hook}</h2>
          <Link to="/signup">
            <Button size="lg" className="bg-accent text-accent-foreground hover:bg-accent/90 shadow-accent-glow text-lg px-10 py-6 h-auto font-semibold">
              {t.hookCta}
              <ArrowRight className="ml-2 h-5 w-5" />
            </Button>
          </Link>
        </div>
      </section>

      {/* Auth Popup */}
      <Dialog open={authOpen} onOpenChange={setAuthOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader className="text-center items-center">
            <img 
              src="/icon.svg" 
              alt="Grind English" 
              className="h-12 w-12 mb-2"
              onError={(e) => {
                e.currentTarget.src = '/icon.png';
              }}
            />
            <DialogTitle className="font-display text-xl uppercase tracking-wide">{isSignup ? (lang === 'pt' ? 'Crie sua conta' : 'Create your account') : (lang === 'pt' ? 'Bem-vindo de volta' : 'Welcome back')}</DialogTitle>
            <DialogDescription>{isSignup ? (lang === 'pt' ? 'Comece sua jornada agora' : 'Start your journey now') : (lang === 'pt' ? 'Entre para continuar' : 'Sign in to continue')}</DialogDescription>
          </DialogHeader>
          <form onSubmit={handleSubmit} className="space-y-3">
            {isSignup && (
              <div className="space-y-1.5">
                <Label htmlFor="popup-name">{lang === 'pt' ? 'Nome' : 'Full Name'}</Label>
                <Input id="popup-name" value={fullName} onChange={e => setFullName(e.target.value)} placeholder={lang === 'pt' ? 'Seu nome' : 'Your name'} className="h-10" />
              </div>
            )}
            <div className="space-y-1.5">
              <Label htmlFor="popup-email">Email</Label>
              <Input id="popup-email" type="email" value={email} onChange={e => setEmail(e.target.value)} placeholder="you@example.com" className="h-10" required />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="popup-pass">{lang === 'pt' ? 'Senha' : 'Password'}</Label>
              <Input id="popup-pass" type="password" value={password} onChange={e => setPassword(e.target.value)} placeholder="••••••••" className="h-10" required />
            </div>
            <Button type="submit" className="w-full h-10 bg-gradient-primary hover:opacity-90" disabled={authLoading}>
              {authLoading ? '...' : isSignup ? (lang === 'pt' ? 'Criar Conta' : 'Sign Up') : (lang === 'pt' ? 'Entrar' : 'Sign In')}
            </Button>
          </form>
          <div className="relative my-1">
            <Separator />
            <span className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 bg-background px-3 text-xs text-muted-foreground">{lang === 'pt' ? 'ou' : 'or'}</span>
          </div>
          <Button variant="outline" className="w-full h-10 gap-2" onClick={handleGoogle}>
            <svg className="h-4 w-4" viewBox="0 0 24 24"><path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.06 5.06 0 0 1-2.2 3.32v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.1z" fill="#4285F4"/><path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/><path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/><path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/></svg>
            Google
          </Button>
          <p className="text-center text-xs text-muted-foreground">
            {isSignup ? (lang === 'pt' ? 'Já tem conta?' : 'Already have an account?') : (lang === 'pt' ? 'Não tem conta?' : "Don't have an account?")}
            {' '}<button onClick={() => setIsSignup(!isSignup)} className="text-primary font-medium hover:underline">{isSignup ? (lang === 'pt' ? 'Entrar' : 'Sign In') : (lang === 'pt' ? 'Criar conta' : 'Sign Up')}</button>
          </p>
        </DialogContent>
      </Dialog>
    </div>
  );
}

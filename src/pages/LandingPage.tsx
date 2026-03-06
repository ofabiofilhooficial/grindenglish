import { useState, useEffect } from 'react';
import { Link, Navigate } from 'react-router-dom';
import { useAuth } from '@/hooks/useAuth';
import { Button } from '@/components/ui/button';
import { UnifiedAuthDialog } from '@/components/auth/UnifiedAuthDialog';
import { 
  Headphones, 
  Target, 
  MessageCircle, 
  ArrowRight,
  Shield,
  Play,
  Globe
} from 'lucide-react';

export default function LandingPage() {
  const { user, loading } = useAuth();
  const [lang, setLang] = useState<'en' | 'pt'>('en');
  const [authOpen, setAuthOpen] = useState(false);

  useEffect(() => {
    if (!loading && !user) {
      const timer = setTimeout(() => setAuthOpen(true), 2000);
      return () => clearTimeout(timer);
    }
  }, [loading, user]);

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
            <Button 
              size="lg" 
              className="bg-accent text-accent-foreground hover:bg-accent/90 shadow-accent-glow text-lg px-10 py-6 h-auto font-semibold"
              onClick={() => setAuthOpen(true)}
            >
              {t.cta}
              <ArrowRight className="ml-2 h-5 w-5" />
            </Button>
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
          <Button 
            size="lg" 
            className="bg-accent text-accent-foreground hover:bg-accent/90 shadow-accent-glow text-lg px-10 py-6 h-auto font-semibold"
            onClick={() => setAuthOpen(true)}
          >
            {t.hookCta}
            <ArrowRight className="ml-2 h-5 w-5" />
          </Button>
        </div>
      </section>

      {/* Unified Auth Dialog */}
      <UnifiedAuthDialog 
        open={authOpen} 
        onOpenChange={setAuthOpen}
        language={lang}
      />
    </div>
  );
}

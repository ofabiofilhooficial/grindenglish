import { useState } from 'react';
import { Navigate, useNavigate } from 'react-router-dom';
import { useAuth } from '@/hooks/useAuth';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Separator } from '@/components/ui/separator';
import { Globe } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';
import { SocialAuthButtons } from '@/components/auth/SocialAuthButtons';

export default function LandingPage() {
  const { user, loading, signInWithGoogle, signInWithLinkedIn, signInWithGitHub } = useAuth();
  const navigate = useNavigate();
  const { toast } = useToast();
  const [lang, setLang] = useState<'en' | 'pt'>('en');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [authLoading, setAuthLoading] = useState(false);

  // Redirect authenticated users to dashboard
  if (!loading && user) {
    return <Navigate to="/dashboard" replace />;
  }

  const t = lang === 'pt' ? {
    title: 'Entrar ou Criar Conta',
    description: 'Use Google, LinkedIn, GitHub ou email para começar',
    emailLabel: 'Email',
    emailPlaceholder: 'seu@email.com',
    passwordLabel: 'Senha',
    passwordPlaceholder: '••••••••',
    submitButton: 'Continuar',
    orText: 'ou',
    submitting: 'Processando...',
    toggle: 'English',
    footer: 'Ao continuar, você concorda com nossos Termos de Serviço e Política de Privacidade.',
    googleError: 'Erro ao entrar com Google',
    linkedinError: 'Erro ao entrar com LinkedIn',
    githubError: 'Erro ao entrar com GitHub',
  } : {
    title: 'Sign In or Sign Up',
    description: 'Use Google, LinkedIn, GitHub or email to get started',
    emailLabel: 'Email',
    emailPlaceholder: 'you@example.com',
    passwordLabel: 'Password',
    passwordPlaceholder: '••••••••',
    submitButton: 'Continue',
    orText: 'or',
    submitting: 'Processing...',
    toggle: 'Português',
    footer: 'By continuing, you agree to our Terms of Service and Privacy Policy.',
    googleError: 'Google sign in failed',
    linkedinError: 'LinkedIn sign in failed',
    githubError: 'GitHub sign in failed',
  };

  const handleEmailAuth = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email || !password) return;

    setAuthLoading(true);

    try {
      // Try to sign in first
      const { data: signInData, error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (signInError) {
        // If sign in fails with "Invalid login credentials", try to sign up
        if (signInError.message.includes('Invalid login credentials') || 
            signInError.message.includes('Email not confirmed')) {
          
          // Attempt sign up
          const { data: signUpData, error: signUpError } = await supabase.auth.signUp({
            email,
            password,
            options: {
              emailRedirectTo: window.location.origin,
            },
          });

          if (signUpError) {
            // If sign up also fails, show the original sign in error
            toast({
              title: lang === 'pt' ? 'Erro ao entrar' : 'Sign in failed',
              description: signInError.message,
              variant: 'destructive',
            });
          } else {
            // Sign up successful
            toast({
              title: lang === 'pt' ? 'Conta criada!' : 'Account created!',
              description: lang === 'pt' 
                ? 'Verifique seu email para confirmar sua conta.' 
                : 'Check your email to verify your account.',
            });
            setEmail('');
            setPassword('');
          }
        } else {
          // Other sign in errors
          toast({
            title: lang === 'pt' ? 'Erro ao entrar' : 'Sign in failed',
            description: signInError.message,
            variant: 'destructive',
          });
        }
      } else {
        // Sign in successful
        toast({
          title: lang === 'pt' ? 'Bem-vindo de volta!' : 'Welcome back!',
        });
        navigate('/dashboard');
      }
    } catch (error: any) {
      toast({
        title: 'Error',
        description: error.message || 'An unexpected error occurred',
        variant: 'destructive',
      });
    } finally {
      setAuthLoading(false);
    }
  };

  const handleGoogleAuth = async () => {
    try {
      await signInWithGoogle();
    } catch (error: any) {
      toast({
        title: t.googleError,
        description: error.message,
        variant: 'destructive',
      });
    }
  };

  const handleLinkedInAuth = async () => {
    try {
      await signInWithLinkedIn();
    } catch (error: any) {
      toast({
        title: t.linkedinError,
        description: error.message,
        variant: 'destructive',
      });
    }
  };

  const handleGitHubAuth = async () => {
    try {
      await signInWithGitHub();
    } catch (error: any) {
      toast({
        title: t.githubError,
        description: error.message,
        variant: 'destructive',
      });
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-background via-background to-secondary/30 px-4 py-12">
      {/* Subtle background effects */}
      <div className="absolute inset-0 -z-10 overflow-hidden">
        <div className="absolute top-1/4 -left-20 w-80 h-80 bg-primary/5 rounded-full blur-3xl" />
        <div className="absolute bottom-1/4 -right-20 w-96 h-96 bg-accent/10 rounded-full blur-3xl" />
      </div>

      {/* Language Toggle */}
      <div className="fixed top-4 right-4 z-50">
        <button
          onClick={() => setLang(lang === 'en' ? 'pt' : 'en')}
          className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-card border border-border text-sm font-medium text-muted-foreground hover:text-foreground transition-colors shadow-sm"
        >
          <Globe className="h-4 w-4" />
          {t.toggle}
        </button>
      </div>

      {/* Auth Card */}
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <img 
            src="/logo-stacked.svg" 
            alt="Grind English" 
            className="h-24 mx-auto mb-4"
            onError={(e) => {
              e.currentTarget.src = '/logo-stacked.png';
            }}
          />
          <h1 className="font-display text-2xl font-bold uppercase tracking-wide text-foreground mb-2">
            {t.title}
          </h1>
          <p className="text-muted-foreground text-sm">
            {t.description}
          </p>
        </div>

        <div className="bg-card border border-border rounded-xl shadow-xl p-6 space-y-4">
          {/* Social Auth Buttons */}
          <SocialAuthButtons
            onGoogleClick={handleGoogleAuth}
            onLinkedInClick={handleLinkedInAuth}
            onGitHubClick={handleGitHubAuth}
            disabled={authLoading}
            lang={lang}
          />

          <div className="relative">
            <Separator />
            <span className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 bg-card px-3 text-xs text-muted-foreground">
              {t.orText}
            </span>
          </div>

          {/* Email/Password Form */}
          <form onSubmit={handleEmailAuth} className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="email">{t.emailLabel}</Label>
              <Input 
                id="email" 
                type="email" 
                value={email} 
                onChange={(e) => setEmail(e.target.value)} 
                placeholder={t.emailPlaceholder}
                className="h-10" 
                required 
                autoComplete="email"
              />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="password">{t.passwordLabel}</Label>
              <Input 
                id="password" 
                type="password" 
                value={password} 
                onChange={(e) => setPassword(e.target.value)} 
                placeholder={t.passwordPlaceholder}
                className="h-10" 
                required
                minLength={6}
                autoComplete="current-password"
              />
            </div>
            <Button 
              type="submit" 
              className="w-full h-10 bg-gradient-primary hover:opacity-90" 
              disabled={authLoading}
            >
              {authLoading ? t.submitting : t.submitButton}
            </Button>
          </form>

          <p className="text-xs text-center text-muted-foreground pt-2">
            {t.footer}
          </p>
        </div>
      </div>
    </div>
  );
}

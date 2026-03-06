import { useState } from 'react';
import { Navigate, useNavigate } from 'react-router-dom';
import { useAuth } from '@/hooks/useAuth';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Separator } from '@/components/ui/separator';
import { Globe } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { lovable } from '@/integrations/lovable/index';
import { useToast } from '@/hooks/use-toast';

export default function LandingPage() {
  const { user, loading } = useAuth();
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
    description: 'Use Google ou email para começar',
    emailLabel: 'Email',
    emailPlaceholder: 'seu@email.com',
    passwordLabel: 'Senha',
    passwordPlaceholder: '••••••••',
    submitButton: 'Continuar',
    orText: 'ou',
    googleButton: 'Continuar com Google',
    submitting: 'Processando...',
    toggle: 'English',
    footer: 'Ao continuar, você concorda com nossos Termos de Serviço e Política de Privacidade.',
  } : {
    title: 'Sign In or Sign Up',
    description: 'Use Google or email to get started',
    emailLabel: 'Email',
    emailPlaceholder: 'you@example.com',
    passwordLabel: 'Password',
    passwordPlaceholder: '••••••••',
    submitButton: 'Continue',
    orText: 'or',
    googleButton: 'Continue with Google',
    submitting: 'Processing...',
    toggle: 'Português',
    footer: 'By continuing, you agree to our Terms of Service and Privacy Policy.',
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
    const { error } = await lovable.auth.signInWithOAuth("google", {
      redirect_uri: window.location.origin,
    });
    
    if (error) {
      toast({
        title: lang === 'pt' ? 'Erro ao entrar com Google' : 'Google sign in failed',
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
          {/* Google Sign In - Primary Option */}
          <Button 
            variant="outline" 
            className="w-full h-11 gap-2 border-2 hover:bg-accent/5" 
            onClick={handleGoogleAuth}
          >
            <svg className="h-5 w-5" viewBox="0 0 24 24">
              <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.06 5.06 0 0 1-2.2 3.32v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.1z" fill="#4285F4"/>
              <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
              <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
              <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
            </svg>
            {t.googleButton}
          </Button>

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

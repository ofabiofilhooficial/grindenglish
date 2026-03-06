import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Separator } from '@/components/ui/separator';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from '@/components/ui/dialog';
import { supabase } from '@/integrations/supabase/client';
import { lovable } from '@/integrations/lovable/index';
import { useToast } from '@/hooks/use-toast';

interface UnifiedAuthDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  language?: 'en' | 'pt';
}

export function UnifiedAuthDialog({ open, onOpenChange, language = 'en' }: UnifiedAuthDialogProps) {
  const navigate = useNavigate();
  const { toast } = useToast();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);

  const t = language === 'pt' ? {
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
    signInSuccess: 'Bem-vindo de volta!',
    signUpSuccess: 'Conta criada! Verifique seu email.',
    signInError: 'Erro ao entrar',
    signUpError: 'Erro ao criar conta',
    googleError: 'Erro ao entrar com Google',
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
    signInSuccess: 'Welcome back!',
    signUpSuccess: 'Account created! Check your email.',
    signInError: 'Sign in failed',
    signUpError: 'Sign up failed',
    googleError: 'Google sign in failed',
  };

  const handleEmailAuth = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email || !password) return;

    setLoading(true);

    try {
      // First, try to sign in
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
              title: t.signInError,
              description: signInError.message,
              variant: 'destructive',
            });
          } else {
            // Sign up successful
            toast({
              title: t.signUpSuccess,
              description: 'We sent you a confirmation link to verify your account.',
            });
            onOpenChange(false);
            setEmail('');
            setPassword('');
          }
        } else {
          // Other sign in errors
          toast({
            title: t.signInError,
            description: signInError.message,
            variant: 'destructive',
          });
        }
      } else {
        // Sign in successful
        toast({
          title: t.signInSuccess,
        });
        onOpenChange(false);
        navigate('/dashboard');
      }
    } catch (error: any) {
      toast({
        title: 'Error',
        description: error.message || 'An unexpected error occurred',
        variant: 'destructive',
      });
    } finally {
      setLoading(false);
    }
  };

  const handleGoogleAuth = async () => {
    const { error } = await lovable.auth.signInWithOAuth("google", {
      redirect_uri: window.location.origin,
    });
    
    if (error) {
      toast({
        title: t.googleError,
        description: error.message,
        variant: 'destructive',
      });
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
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
          <DialogTitle className="font-display text-xl uppercase tracking-wide">
            {t.title}
          </DialogTitle>
          <DialogDescription className="text-center">
            {t.description}
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
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
            <span className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 bg-background px-3 text-xs text-muted-foreground">
              {t.orText}
            </span>
          </div>

          {/* Email/Password Form */}
          <form onSubmit={handleEmailAuth} className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="auth-email">{t.emailLabel}</Label>
              <Input 
                id="auth-email" 
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
              <Label htmlFor="auth-password">{t.passwordLabel}</Label>
              <Input 
                id="auth-password" 
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
              disabled={loading}
            >
              {loading ? t.submitting : t.submitButton}
            </Button>
          </form>

          <p className="text-xs text-center text-muted-foreground">
            {language === 'pt' 
              ? 'Ao continuar, você concorda com nossos Termos de Serviço e Política de Privacidade.' 
              : 'By continuing, you agree to our Terms of Service and Privacy Policy.'}
          </p>
        </div>
      </DialogContent>
    </Dialog>
  );
}

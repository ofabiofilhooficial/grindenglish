import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Separator } from '@/components/ui/separator';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from '@/components/ui/dialog';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';
import { useAuth } from '@/hooks/useAuth';
import { SocialAuthButtons } from '@/components/auth/SocialAuthButtons';

interface UnifiedAuthDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  language?: 'en' | 'pt';
}

export function UnifiedAuthDialog({ open, onOpenChange, language = 'en' }: UnifiedAuthDialogProps) {
  const navigate = useNavigate();
  const { toast } = useToast();
  const { signInWithGoogle, signInWithLinkedIn, signInWithGitHub } = useAuth();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);

  const t = language === 'pt' ? {
    title: 'Entrar ou Criar Conta',
    description: 'Use Google, LinkedIn, GitHub ou email para começar',
    emailLabel: 'Email',
    emailPlaceholder: 'seu@email.com',
    passwordLabel: 'Senha',
    passwordPlaceholder: '••••••••',
    submitButton: 'Continuar',
    orText: 'ou',
    submitting: 'Processando...',
    signInSuccess: 'Bem-vindo de volta!',
    signUpSuccess: 'Conta criada! Verifique seu email.',
    signInError: 'Erro ao entrar',
    signUpError: 'Erro ao criar conta',
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
    signInSuccess: 'Welcome back!',
    signUpSuccess: 'Account created! Check your email.',
    signInError: 'Sign in failed',
    signUpError: 'Sign up failed',
    googleError: 'Google sign in failed',
    linkedinError: 'LinkedIn sign in failed',
    githubError: 'GitHub sign in failed',
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
          {/* Social Auth Buttons */}
          <SocialAuthButtons
            onGoogleClick={handleGoogleAuth}
            onLinkedInClick={handleLinkedInAuth}
            onGitHubClick={handleGitHubAuth}
            disabled={loading}
            lang={language}
          />

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

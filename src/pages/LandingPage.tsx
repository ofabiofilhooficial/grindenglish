import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { LevelBadge } from '@/components/ui/level-badge';
import { 
  Sparkles, 
  GraduationCap, 
  Users, 
  Mic, 
  BookOpen, 
  RefreshCw, 
  BarChart3,
  ArrowRight,
  CheckCircle2,
  Globe,
  Star,
  Play,
  Zap
} from 'lucide-react';
import { CEFRLevel } from '@/types/course';
import { CEFR_LEVEL_CONFIG } from '@/data/seedData';

const features = [
  {
    icon: GraduationCap,
    title: 'Real-World Tasks',
    description: 'Learn through authentic situations you\'ll actually encounter—from workplace meetings to travel emergencies.',
  },
  {
    icon: RefreshCw,
    title: 'Spaced Repetition',
    description: 'Smart review system ensures vocabulary and grammar stick permanently, not just until the test.',
  },
  {
    icon: Mic,
    title: 'Speaking Practice',
    description: 'Record yourself, get feedback, and build confidence with structured pronunciation training.',
  },
  {
    icon: Users,
    title: 'Pragmatics Training',
    description: 'Master the art of appropriate communication—from casual chat to formal presentations.',
  },
  {
    icon: BookOpen,
    title: 'Comprehensive Lexicon',
    description: 'Build vocabulary systematically with collocations, usage notes, and register awareness.',
  },
  {
    icon: BarChart3,
    title: 'Progress Analytics',
    description: 'Track your journey with detailed insights into your strengths and areas for growth.',
  },
];

const levels: CEFRLevel[] = ['A0', 'A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-background">
      {/* Navigation */}
      <nav className="fixed top-0 left-0 right-0 z-50 border-b border-border/50 bg-background/80 backdrop-blur-lg">
        <div className="container mx-auto flex h-16 items-center justify-between px-4">
          <Link to="/" className="flex items-center gap-2">
            <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-gradient-primary shadow-md">
              <Sparkles className="h-5 w-5 text-white" />
            </div>
            <span className="font-display text-xl font-bold">English Mastery Lab</span>
          </Link>
          
          <div className="hidden md:flex items-center gap-6">
            <Link to="#features" className="text-sm font-medium text-muted-foreground hover:text-foreground transition-colors">Features</Link>
            <Link to="#levels" className="text-sm font-medium text-muted-foreground hover:text-foreground transition-colors">CEFR Levels</Link>
            <Link to="#pricing" className="text-sm font-medium text-muted-foreground hover:text-foreground transition-colors">Pricing</Link>
          </div>

          <div className="flex items-center gap-3">
            <Link to="/login">
              <Button variant="ghost" size="sm">Sign In</Button>
            </Link>
            <Link to="/signup">
              <Button size="sm" className="bg-gradient-primary hover:opacity-90 shadow-md">
                Get Started
              </Button>
            </Link>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="relative pt-32 pb-20 overflow-hidden">
        {/* Background decorations */}
        <div className="absolute inset-0 -z-10">
          <div className="absolute top-20 left-10 w-72 h-72 bg-primary/5 rounded-full blur-3xl" />
          <div className="absolute top-40 right-20 w-96 h-96 bg-accent/10 rounded-full blur-3xl" />
          <div className="absolute bottom-10 left-1/3 w-80 h-80 bg-primary/5 rounded-full blur-3xl" />
        </div>

        <div className="container mx-auto px-4">
          <div className="max-w-4xl mx-auto text-center">
            <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-primary/10 text-primary text-sm font-medium mb-6">
              <Zap className="h-4 w-4" />
              Task-based learning that actually works
            </div>
            
            <h1 className="font-display text-5xl md:text-6xl lg:text-7xl font-bold tracking-tight mb-6">
              Master English with{' '}
              <span className="text-gradient-primary">Real-World</span>{' '}
              Confidence
            </h1>
            
            <p className="text-xl text-muted-foreground max-w-2xl mx-auto mb-8">
              A comprehensive learning platform from A0 to C2, with Professional and Academic tracks. 
              Build genuine fluency through authentic tasks, systematic vocabulary, and expert feedback.
            </p>

            <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
              <Link to="/signup">
                <Button size="lg" className="bg-gradient-primary hover:opacity-90 shadow-lg shadow-primary/25 text-lg px-8">
                  Start Learning Free
                  <ArrowRight className="ml-2 h-5 w-5" />
                </Button>
              </Link>
              <Button size="lg" variant="outline" className="text-lg px-8">
                <Play className="mr-2 h-5 w-5" />
                Watch Demo
              </Button>
            </div>

            {/* Trust indicators */}
            <div className="mt-12 flex flex-col sm:flex-row items-center justify-center gap-6 text-sm text-muted-foreground">
              <div className="flex items-center gap-2">
                <CheckCircle2 className="h-5 w-5 text-success" />
                <span>CEFR-aligned curriculum</span>
              </div>
              <div className="flex items-center gap-2">
                <CheckCircle2 className="h-5 w-5 text-success" />
                <span>Speaking & writing feedback</span>
              </div>
              <div className="flex items-center gap-2">
                <CheckCircle2 className="h-5 w-5 text-success" />
                <span>Self-paced or cohort mode</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="py-20 bg-secondary/30">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="font-display text-3xl md:text-4xl font-bold mb-4">
              Everything you need to achieve fluency
            </h2>
            <p className="text-lg text-muted-foreground max-w-2xl mx-auto">
              A complete system integrating input, output, language focus, and systematic recycling.
            </p>
          </div>

          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {features.map((feature, index) => (
              <Card key={index} className="bg-card border-border/50 hover:border-primary/30 hover:shadow-lg transition-all duration-300">
                <CardContent className="p-6">
                  <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 text-primary mb-4">
                    <feature.icon className="h-6 w-6" />
                  </div>
                  <h3 className="font-display text-lg font-semibold mb-2">{feature.title}</h3>
                  <p className="text-muted-foreground">{feature.description}</p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* CEFR Levels Section */}
      <section id="levels" className="py-20">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="font-display text-3xl md:text-4xl font-bold mb-4">
              From first words to mastery
            </h2>
            <p className="text-lg text-muted-foreground max-w-2xl mx-auto">
              A clear path through all CEFR levels, with optional Professional and Academic tracks from B1+.
            </p>
          </div>

          <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-4 max-w-5xl mx-auto">
            {levels.map((level) => {
              const config = CEFR_LEVEL_CONFIG[level];
              return (
                <Card 
                  key={level}
                  className="relative overflow-hidden bg-card border-border/50 hover:border-primary/30 hover:shadow-lg transition-all duration-300 group"
                >
                  <div className={`absolute top-0 left-0 right-0 h-1 bg-gradient-to-r ${config.gradient}`} />
                  <CardContent className="p-5">
                    <div className="flex items-center justify-between mb-3">
                      <LevelBadge level={level} size="lg" />
                      <span className="text-sm text-muted-foreground">{config.unitCount} units</span>
                    </div>
                    <h3 className="font-display font-semibold mb-1">{config.name}</h3>
                    <p className="text-sm text-muted-foreground line-clamp-2">{config.description}</p>
                    <div className="mt-3 flex items-center text-sm text-muted-foreground">
                      <span>~{config.hoursEstimate} hours</span>
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        </div>
      </section>

      {/* Tracks Section */}
      <section className="py-20 bg-gradient-hero text-white">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="font-display text-3xl md:text-4xl font-bold mb-4">
              Specialized tracks for your goals
            </h2>
            <p className="text-lg text-white/70 max-w-2xl mx-auto">
              From B1 onwards, choose overlays that match your professional or academic needs.
            </p>
          </div>

          <div className="grid md:grid-cols-3 gap-6 max-w-4xl mx-auto">
            <Card className="bg-white/10 border-white/20 backdrop-blur-sm">
              <CardContent className="p-6 text-center">
                <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-white/20 mx-auto mb-4">
                  <Globe className="h-7 w-7 text-white" />
                </div>
                <h3 className="font-display text-xl font-semibold mb-2">Core Track</h3>
                <p className="text-white/70">
                  General English for everyday communication—work, travel, social interactions.
                </p>
              </CardContent>
            </Card>

            <Card className="bg-white/10 border-white/20 backdrop-blur-sm">
              <CardContent className="p-6 text-center">
                <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-accent/80 mx-auto mb-4">
                  <Users className="h-7 w-7 text-white" />
                </div>
                <h3 className="font-display text-xl font-semibold mb-2">Professional Track</h3>
                <p className="text-white/70">
                  Business English—meetings, negotiations, presentations, workplace communication.
                </p>
              </CardContent>
            </Card>

            <Card className="bg-white/10 border-white/20 backdrop-blur-sm">
              <CardContent className="p-6 text-center">
                <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-primary/80 mx-auto mb-4">
                  <GraduationCap className="h-7 w-7 text-white" />
                </div>
                <h3 className="font-display text-xl font-semibold mb-2">Academic Track</h3>
                <p className="text-white/70">
                  Academic English—essays, research, seminars, university-level discourse.
                </p>
              </CardContent>
            </Card>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20">
        <div className="container mx-auto px-4 text-center">
          <div className="inline-flex mb-4">
            {[1, 2, 3, 4, 5].map((star) => (
              <Star key={star} className="h-6 w-6 fill-accent text-accent" />
            ))}
          </div>
          <h2 className="font-display text-3xl md:text-4xl font-bold mb-4">
            Ready to transform your English?
          </h2>
          <p className="text-lg text-muted-foreground max-w-xl mx-auto mb-8">
            Join thousands of learners building real confidence through task-based learning.
          </p>
          <Link to="/signup">
            <Button size="lg" className="bg-gradient-primary hover:opacity-90 shadow-lg shadow-primary/25 text-lg px-10">
              Start Your Journey
              <ArrowRight className="ml-2 h-5 w-5" />
            </Button>
          </Link>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-border py-12">
        <div className="container mx-auto px-4">
          <div className="flex flex-col md:flex-row items-center justify-between gap-4">
            <div className="flex items-center gap-2">
              <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-gradient-primary">
                <Sparkles className="h-4 w-4 text-white" />
              </div>
              <span className="font-display font-semibold">English Mastery Lab</span>
            </div>
            <p className="text-sm text-muted-foreground">
              © 2024 English Mastery Lab. All rights reserved.
            </p>
            <div className="flex items-center gap-6 text-sm text-muted-foreground">
              <Link to="/privacy" className="hover:text-foreground transition-colors">Privacy</Link>
              <Link to="/terms" className="hover:text-foreground transition-colors">Terms</Link>
              <Link to="/contact" className="hover:text-foreground transition-colors">Contact</Link>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}

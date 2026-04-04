import { Link } from 'react-router-dom';
import { PublicLayout } from '@/components/layout/PublicLayout';
import { Button } from '@/components/ui/button';

const steps = [
  {
    title: '1. Take the placement check',
    description: 'Answer a few quick questions so the platform can place you at the right CEFR level.',
  },
  {
    title: '2. Start your learning path',
    description: 'Follow structured lessons, units, and review sessions designed for your level.',
  },
  {
    title: '3. Practice with purpose',
    description: 'Use vocabulary, grammar, pronunciation, and pragmatics practice tied to real use cases.',
  },
  {
    title: '4. Track your progress',
    description: 'See your streak, vocabulary growth, and course completion as you improve.',
  },
];

export default function HowItWorksPage() {
  return (
    <PublicLayout title="How it works">
      <div className="grid gap-12 lg:grid-cols-[1.3fr_0.7fr]">
        <div className="space-y-8">
          <div className="rounded-3xl border border-border bg-card p-8 shadow-sm">
            <p className="text-sm uppercase tracking-[0.3em] text-primary">Step-by-step learning</p>
            <h2 className="mt-3 text-3xl font-bold">A simple path from first lesson to confident English.</h2>
            <p className="mt-4 text-base text-muted-foreground">
              Grind English is built around placement, CEFR-aligned units, and practical practice that keeps learners moving.
            </p>
          </div>

          <div className="space-y-6">
            {steps.map((step) => (
              <div key={step.title} className="rounded-3xl border border-border bg-card p-6 shadow-sm">
                <p className="text-sm font-semibold text-primary">{step.title}</p>
                <p className="mt-2 text-sm text-muted-foreground">{step.description}</p>
              </div>
            ))}
          </div>
        </div>

        <div className="rounded-3xl bg-gradient-to-br from-secondary/10 to-primary/10 p-8 shadow-lg">
          <h3 className="text-2xl font-semibold">Ready to begin?</h3>
          <p className="mt-4 text-sm text-muted-foreground">
            Your placement result becomes the starting point for your learning path. You can refine pricing and details later, but this flow is what makes the experience feel tailored.
          </p>
          <Link to="/login">
            <Button className="mt-6 w-full bg-gradient-primary hover:opacity-90">Start placement</Button>
          </Link>
        </div>
      </div>
    </PublicLayout>
  );
}

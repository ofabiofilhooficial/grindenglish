import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { PublicLayout } from '@/components/layout/PublicLayout';

export default function HomePage() {
  return (
    <PublicLayout title="Learn English with confidence">
      <section className="grid gap-8 lg:grid-cols-[1.2fr_0.8fr] items-center">
        <div className="space-y-6">
          <p className="text-sm uppercase tracking-[0.3em] text-primary">From beginner to business English</p>
          <h2 className="text-4xl font-extrabold sm:text-5xl">Build real English skills with guided CEFR learning.</h2>
          <p className="max-w-2xl text-base text-muted-foreground sm:text-lg">
            Grind English helps professionals learn faster with personalized placement, structured units, real practice, and teacher-supported cohorts.
          </p>
          <div className="flex flex-wrap gap-3">
            <Link to="/login">
              <Button className="bg-gradient-primary hover:opacity-90">Get started</Button>
            </Link>
            <Link to="/how-it-works">
              <Button variant="outline">How it works</Button>
            </Link>
          </div>
        </div>

        <div className="rounded-3xl bg-gradient-to-br from-primary/10 to-secondary/10 p-8 shadow-lg">
          <div className="space-y-4">
            <p className="text-sm font-semibold uppercase tracking-[0.2em] text-primary">Placement first</p>
            <h3 className="text-2xl font-bold">Start with a placement check</h3>
            <p className="text-sm text-muted-foreground">
              Learners are matched to the right level instantly and guided through the next best course content.
            </p>
            <div className="grid gap-3 pt-4 sm:grid-cols-2">
              <div className="rounded-2xl bg-white/90 p-4 shadow-sm">
                <p className="text-4xl font-semibold text-primary">A0–C2</p>
                <p className="text-sm text-muted-foreground">CEFR-aligned pathway</p>
              </div>
              <div className="rounded-2xl bg-white/90 p-4 shadow-sm">
                <p className="text-4xl font-semibold text-primary">Live cohorts</p>
                <p className="text-sm text-muted-foreground">Teacher-led groups and progress tracking</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="mt-16 grid gap-8 lg:grid-cols-3">
        {[
          { title: 'Personalized onboarding', text: 'Placement-based pathway and learner goals captured from the first session.' },
          { title: 'Teacher-ready content', text: 'Authoring tools for grammar, vocabulary, pronunciation, and pragmatics.' },
          { title: 'Real progress', text: 'Track skills, study time, vocabulary, and lesson completion in one place.' },
        ].map((item) => (
          <div key={item.title} className="rounded-3xl border border-border bg-card p-6 shadow-sm">
            <p className="text-lg font-semibold">{item.title}</p>
            <p className="mt-3 text-sm text-muted-foreground">{item.text}</p>
          </div>
        ))}
      </section>
    </PublicLayout>
  );
}

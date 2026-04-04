import { PublicLayout } from '@/components/layout/PublicLayout';
import { Button } from '@/components/ui/button';

const tiers = [
  {
    name: 'Starter',
    price: 'Free',
    description: 'Basic access for self-study and placement review.',
    features: ['Placement check', 'A0-A1 practice', 'Learner dashboard'],
  },
  {
    name: 'Pro',
    price: '$29/mo',
    description: 'Teacher-supported pathway with advanced vocabulary and grammar practice.',
    features: ['Full CEFR path', 'Teacher feedback', 'Progress analytics'],
  },
  {
    name: 'Team',
    price: 'Custom',
    description: 'Enterprise onboarding for schools and corporate cohorts.',
    features: ['Cohort management', 'Admin dashboard', 'Custom learning paths'],
  },
];

export default function PricingPage() {
  return (
    <PublicLayout title="Pricing">
      <div className="grid gap-8 lg:grid-cols-3">
        {tiers.map((tier) => (
          <div key={tier.name} className="rounded-3xl border border-border bg-card p-8 shadow-sm">
            <p className="text-sm uppercase tracking-[0.3em] text-primary">{tier.name}</p>
            <h3 className="mt-4 text-4xl font-bold">{tier.price}</h3>
            <p className="mt-3 text-sm text-muted-foreground">{tier.description}</p>
            <ul className="mt-6 space-y-3 text-sm text-muted-foreground">
              {tier.features.map((feature) => (
                <li key={feature} className="before:content-['•'] before:mr-2 before:text-primary">{feature}</li>
              ))}
            </ul>
            <Button className="mt-8 w-full bg-gradient-primary hover:opacity-90">Choose {tier.name}</Button>
          </div>
        ))}
      </div>
    </PublicLayout>
  );
}

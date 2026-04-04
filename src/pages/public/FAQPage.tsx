import { PublicLayout } from '@/components/layout/PublicLayout';

const faqs = [
  {
    question: 'How does placement work?',
    answer: 'A short onboarding assessment places learners at the right CEFR level so they start with content that fits their current English ability.',
  },
  {
    question: 'Can I learn at my own pace?',
    answer: 'Yes. The platform supports self-paced learners and teacher-led cohorts depending on the plan you choose.',
  },
  {
    question: 'What content is included?',
    answer: 'Lessons include vocabulary, grammar, pronunciation, pragmatics, and real communicative tasks tailored for each level.',
  },
];

export default function FAQPage() {
  return (
    <PublicLayout title="FAQ">
      <div className="space-y-6">
        {faqs.map((item) => (
          <div key={item.question} className="rounded-3xl border border-border bg-card p-6 shadow-sm">
            <p className="text-lg font-semibold">{item.question}</p>
            <p className="mt-2 text-sm text-muted-foreground">{item.answer}</p>
          </div>
        ))}
      </div>
    </PublicLayout>
  );
}

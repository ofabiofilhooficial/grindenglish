import { useState } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';

const levelOptions = [
  { value: 'A1', label: 'A1 - Beginner' },
  { value: 'A2', label: 'A2 - Elementary' },
  { value: 'B1', label: 'B1 - Intermediate' },
  { value: 'B2', label: 'B2 - Upper intermediate' },
];

export default function PlacementPage() {
  const [selectedLevel, setSelectedLevel] = useState('A1');
  const [goals, setGoals] = useState('');
  const [confidence, setConfidence] = useState('moderate');

  return (
    <AppLayout title="Level placement" subtitle="Share a few details so we can recommend the best starting course.">
      <div className="space-y-6 p-6">
        <Card>
          <CardHeader>
            <CardTitle>Quick placement check</CardTitle>
            <CardDescription>Answer these questions to get a personalized course recommendation.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="space-y-3">
              <label className="block text-sm font-medium">How comfortable are you with English today?</label>
              <select
                value={selectedLevel}
                onChange={(event) => setSelectedLevel(event.target.value)}
                className="w-full rounded border px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary"
              >
                {levelOptions.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            </div>

            <div className="space-y-3">
              <label className="block text-sm font-medium">What is your main learning goal?</label>
              <textarea
                value={goals}
                onChange={(event) => setGoals(event.target.value)}
                placeholder="Example: speak confidently in meetings, read short stories, or improve listening for travel"
                className="w-full rounded border px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary"
                rows={4}
              />
            </div>

            <div className="space-y-3">
              <label className="block text-sm font-medium">How confident do you feel using English now?</label>
              <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
                {['low', 'moderate', 'high', 'native-like'].map((value) => (
                  <button
                    key={value}
                    type="button"
                    onClick={() => setConfidence(value)}
                    className={`rounded border px-3 py-2 text-sm text-left transition ${
                      confidence === value
                        ? 'border-primary bg-primary/10 font-semibold'
                        : 'border-slate-200 bg-white hover:border-slate-400'
                    }`}
                  >
                    {value.replace('-', ' ')}
                  </button>
                ))}
              </div>
            </div>

            <div className="space-y-1 text-sm text-muted-foreground">
              <p>Recommended starting level:</p>
              <p className="font-semibold">{selectedLevel}</p>
            </div>
          </CardContent>
        </Card>

        <div className="flex flex-col gap-3 sm:flex-row">
          <Button className="bg-gradient-primary hover:opacity-90">Save and continue</Button>
          <Button variant="outline">Return to dashboard</Button>
        </div>
      </div>
    </AppLayout>
  );
}

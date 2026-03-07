import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { CheckCircle2, XCircle, AlertCircle, ArrowRight } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';

interface VocabularyItem {
  id: string;
  prompt: string; // Portuguese word
  expected: string[]; // Accepted English translations
  headword: string; // Primary English word for SRS
}

interface VocabularyPracticeProps {
  items: VocabularyItem[];
  onComplete: () => void;
  lessonId: string;
}

export function VocabularyPractice({ items, onComplete, lessonId }: VocabularyPracticeProps) {
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [checked, setChecked] = useState<Record<string, boolean>>({});
  const [results, setResults] = useState<Record<string, 'correct' | 'incorrect' | null>>({});
  const [allCorrect, setAllCorrect] = useState(false);

  const handleAnswerChange = (itemId: string, value: string) => {
    setAnswers(prev => ({ ...prev, [itemId]: value }));
    // Clear result when user changes answer
    if (checked[itemId]) {
      setChecked(prev => ({ ...prev, [itemId]: false }));
      setResults(prev => ({ ...prev, [itemId]: null }));
    }
  };

  const checkAnswer = async (item: VocabularyItem) => {
    const userAnswer = answers[item.id]?.trim().toLowerCase() || '';
    const isCorrect = item.expected.some(exp => 
      exp.toLowerCase() === userAnswer
    );

    setResults(prev => ({ ...prev, [item.id]: isCorrect ? 'correct' : 'incorrect' }));
    setChecked(prev => ({ ...prev, [item.id]: true }));

    // Track in SRS system
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      // Find the lexicon entry
      const { data: lexiconEntry } = await supabase
        .from('lexicon_entries')
        .select('id')
        .eq('headword', item.headword)
        .single();

      if (lexiconEntry) {
        // Record the attempt in SRS
        const quality = isCorrect ? 5 : 2; // 5 = perfect recall, 2 = incorrect but remembered
        
        await supabase.rpc('record_srs_review', {
          _user_id: user.id,
          _item_id: lexiconEntry.id,
          _item_type: 'vocabulary',
          _quality: quality
        });
      }
    } catch (error) {
      console.error('Error tracking SRS:', error);
    }

    // Check if all are correct
    const newResults = { ...results, [item.id]: isCorrect ? 'correct' : 'incorrect' };
    const allChecked = items.every(i => newResults[i.id] !== null && newResults[i.id] !== undefined);
    const allRight = items.every(i => newResults[i.id] === 'correct');
    
    if (allChecked && allRight) {
      setAllCorrect(true);
    }
  };

  const handleComplete = () => {
    if (allCorrect) {
      onComplete();
    }
  };

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base flex items-center gap-2">
          <AlertCircle className="h-5 w-5 text-primary" />
          Vocabulary Practice
        </CardTitle>
        <p className="text-sm text-muted-foreground">
          Translate these Portuguese greetings to English
        </p>
      </CardHeader>
      <CardContent className="space-y-4">
        {items.map((item) => {
          const result = results[item.id];
          const isChecked = checked[item.id];

          return (
            <div key={item.id} className="space-y-2">
              <div className="flex items-center gap-3">
                <div className="flex-1">
                  <label className="text-sm font-medium mb-1 block">
                    {item.prompt} →
                  </label>
                  <div className="flex gap-2">
                    <Input
                      value={answers[item.id] || ''}
                      onChange={(e) => handleAnswerChange(item.id, e.target.value)}
                      placeholder="Type English translation..."
                      disabled={result === 'correct'}
                      className={result === 'correct' ? 'bg-success/10 border-success' : ''}
                      onKeyDown={(e) => {
                        if (e.key === 'Enter' && !isChecked) {
                          checkAnswer(item);
                        }
                      }}
                    />
                    {!isChecked && answers[item.id] && (
                      <Button 
                        onClick={() => checkAnswer(item)}
                        size="sm"
                      >
                        Check
                      </Button>
                    )}
                  </div>
                </div>
                {result === 'correct' && (
                  <CheckCircle2 className="h-5 w-5 text-success flex-shrink-0" />
                )}
                {result === 'incorrect' && (
                  <XCircle className="h-5 w-5 text-destructive flex-shrink-0" />
                )}
              </div>

              {result === 'incorrect' && (
                <Alert variant="destructive" className="py-2">
                  <AlertDescription className="text-xs">
                    Not quite. Try again! Hint: {item.expected[0].charAt(0)}...
                  </AlertDescription>
                </Alert>
              )}

              {result === 'correct' && (
                <Alert className="py-2 bg-success/10 border-success/20">
                  <AlertDescription className="text-xs text-success">
                    ✓ Correct! "{item.headword}" will be added to your review schedule.
                  </AlertDescription>
                </Alert>
              )}
            </div>
          );
        })}

        {allCorrect && (
          <Alert className="bg-primary/10 border-primary/20">
            <CheckCircle2 className="h-4 w-4 text-primary" />
            <AlertDescription className="text-sm">
              <span className="font-semibold">Excellent work!</span> You got all translations correct. 
              These words have been added to your spaced repetition schedule.
            </AlertDescription>
          </Alert>
        )}

        <div className="flex items-center justify-between pt-4 border-t">
          <div className="text-sm text-muted-foreground">
            {items.filter(i => results[i.id] === 'correct').length} / {items.length} correct
          </div>
          {allCorrect && (
            <Button 
              onClick={handleComplete}
              className="bg-gradient-primary hover:opacity-90"
            >
              Complete Stage
              <ArrowRight className="ml-2 h-4 w-4" />
            </Button>
          )}
        </div>
      </CardContent>
    </Card>
  );
}

import { useState, useEffect, useCallback } from 'react';
import { Link } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { useActiveLexiconPractice } from '@/hooks/useActiveLexiconPractice';
import { useActiveLexiconEntryDetail } from '@/hooks/useActiveLexiconLexicon';
import { Loader2, Eye, ThumbsDown, ThumbsUp, CheckCircle } from 'lucide-react';
import { usePageViewTracker } from '@/hooks/useActivityTracker';

export default function ActiveLexiconPracticePage() {
  const [revealed, setRevealed] = useState(false);
  const [feedback, setFeedback] = useState<string | null>(null);
  const [sessionStart] = useState(() => Date.now());

  const {
    nextWord,
    nextWordLoading,
    nextWordError,
    refetchNextWord,
    sessionStats,
    submitGrade,
    gradeLoading,
  } = useActiveLexiconPractice();

  const { data: revealedDetail } = useActiveLexiconEntryDetail(
    revealed && nextWord ? nextWord.lexicon_entry_id : null
  );

  usePageViewTracker('active_lexicon_practice_view');

  const handleGrade = useCallback(
    async (grade: 'Hard' | 'Good' | 'Easy') => {
      if (!nextWord || gradeLoading) return;
      setFeedback(null);
      try {
        const result = await submitGrade({
          entryId: nextWord.lexicon_entry_id,
          grade,
        });
        setFeedback(result.message);
        setRevealed(false);
        await refetchNextWord();
      } catch (e) {
        setFeedback('Failed to save. Try again.');
      }
    },
    [nextWord, gradeLoading, submitGrade, refetchNextWord]
  );

  useEffect(() => {
    setRevealed(false);
    setFeedback(null);
  }, [nextWord?.lexicon_entry_id]);

  useEffect(() => {
    const handleKey = (e: KeyboardEvent) => {
      if (!nextWord) return;
      if (e.key === 'r' || e.key === 'R') {
        e.preventDefault();
        setRevealed((v) => !v);
      }
      if (e.key === 'h' || e.key === 'H') {
        e.preventDefault();
        handleGrade('Hard');
      }
      if (e.key === 'g' || e.key === 'G') {
        e.preventDefault();
        handleGrade('Good');
      }
      if (e.key === 'e' || e.key === 'E') {
        e.preventDefault();
        handleGrade('Easy');
      }
    };
    window.addEventListener('keydown', handleKey);
    return () => window.removeEventListener('keydown', handleKey);
  }, [nextWord, handleGrade]);

  if (nextWordLoading && !nextWord) {
    return (
      <AppLayout title="Practice" subtitle="Loading…">
        <div className="flex items-center justify-center min-h-[50vh] gap-2 text-muted-foreground">
          <Loader2 className="h-6 w-6 animate-spin" />
          Loading next word…
        </div>
      </AppLayout>
    );
  }

  if (nextWordError) {
    return (
      <AppLayout title="Practice" subtitle="Error">
        <div className="p-6 text-center">
          <p className="text-destructive mb-4">Failed to load practice.</p>
          <Button onClick={() => refetchNextWord()}>Retry</Button>
        </div>
      </AppLayout>
    );
  }

  if (!nextWord) {
    const durationMinutes = Math.round((Date.now() - sessionStart) / 60_000);
    return (
      <AppLayout title="Practice" subtitle="Session complete">
        <div className="p-6 max-w-lg mx-auto space-y-6">
          <Card>
            <CardHeader>
              <CardTitle>Session complete</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4" role="status" aria-live="polite">
              <p>
                You reviewed {sessionStats?.total_words_reviewed ?? 0} words.
                {sessionStats?.words_mastered_today != null && sessionStats.words_mastered_today > 0 && (
                  <> {sessionStats.words_mastered_today} new word(s) mastered today.</>
                )}
              </p>
              <p className="text-sm text-muted-foreground">
                Duration: ~{durationMinutes} min
              </p>
            </CardContent>
          </Card>
          <div className="flex flex-col sm:flex-row gap-3">
            <Link to="/active-lexicon" className="flex-1">
              <Button className="w-full min-h-[44px]">Back to dashboard</Button>
            </Link>
            <Link to="/active-lexicon/lexicon" className="flex-1">
              <Button variant="outline" className="w-full min-h-[44px]">
                Lexicon Hub
              </Button>
            </Link>
          </div>
        </div>
      </AppLayout>
    );
  }

  return (
    <AppLayout title="Practice" subtitle={`Word ${nextWord.session_position} of ${nextWord.session_total}`}>
      <div className="p-4 sm:p-6 max-w-2xl mx-auto flex flex-col min-h-[70vh]">
        <section
          className="flex-1 flex flex-col justify-center"
          aria-label="Cloze Flashcard"
        >
          <p
            className="text-lg sm:text-2xl font-medium mb-4 min-h-[2.5rem]"
            aria-label={`Cloze question. Fill in the blank: ${nextWord.example_sentence}`}
          >
            {nextWord.example_sentence}
          </p>

          <div className="flex flex-wrap gap-2 mb-6">
            <Button
              variant="outline"
              className="min-h-[44px] min-w-[44px]"
              onClick={() => setRevealed((v) => !v)}
              aria-label="Reveal. Button. Activates to show the English word, definition, and L1 notes"
            >
              <Eye className="h-4 w-4 mr-2" />
              Reveal
            </Button>
            {revealed && nextWord.audio_url && (
              <audio
                controls
                src={nextWord.audio_url}
                className="min-h-[44px]"
                aria-label="Pronunciation"
              />
            )}
          </div>

          {revealed && (
            <div
              className="p-4 rounded-lg border bg-muted/30 mb-6 space-y-2"
              role="region"
              aria-live="polite"
              aria-label="Revealed content"
            >
              <p className="font-semibold text-lg" aria-label={`English word: ${nextWord.english_word}`}>
                {nextWord.english_word}
              </p>
              {revealedDetail?.definition && (
                <p className="text-sm text-muted-foreground" aria-label={`Definition: ${revealedDetail.definition}`}>
                  {revealedDetail.definition}
                </p>
              )}
              {revealedDetail?.l1_notes && (
                <div className="text-sm p-2 rounded bg-muted/50" aria-label={`L1 Notes: ${revealedDetail.l1_notes}`}>
                  {revealedDetail.l1_notes}
                </div>
              )}
              {revealedDetail?.audio_url && (
                <audio controls src={revealedDetail.audio_url} className="w-full min-h-[44px]" aria-label="Pronunciation" />
              )}
            </div>
          )}

          {feedback && (
            <p className="text-sm text-muted-foreground mb-4" role="status" aria-live="polite">
              {feedback}
            </p>
          )}
        </section>

        <div
          role="group"
          aria-label="Grading options"
          className="grid grid-cols-1 sm:grid-cols-3 gap-3 pt-4 border-t"
        >
          <Button
            variant="outline"
            className="min-h-[44px] w-full sm:max-w-[140px]"
            disabled={gradeLoading}
            onClick={() => handleGrade('Hard')}
            aria-label="Hard. Grades this word as difficult. It will appear again tomorrow."
          >
            <ThumbsDown className="h-4 w-4 mr-2" />
            Hard
          </Button>
          <Button
            className="min-h-[44px] w-full sm:max-w-[140px]"
            disabled={gradeLoading}
            onClick={() => handleGrade('Good')}
            aria-label="Good. Grades this word as correctly recalled. It will appear again in a few days."
          >
            <CheckCircle className="h-4 w-4 mr-2" />
            Good
          </Button>
          <Button
            variant="secondary"
            className="min-h-[44px] w-full sm:max-w-[140px]"
            disabled={gradeLoading}
            onClick={() => handleGrade('Easy')}
            aria-label="Easy. Grades this word as easy. It will appear again in several days."
          >
            <ThumbsUp className="h-4 w-4 mr-2" />
            Easy
          </Button>
        </div>

        <p className="text-xs text-muted-foreground mt-4 text-center">
          Shortcuts: R Reveal · H Hard · G Good · E Easy
        </p>
      </div>
    </AppLayout>
  );
}

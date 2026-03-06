import { useState, useEffect } from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { Badge } from '@/components/ui/badge';
import { Brain, ArrowRight, CheckCircle2 } from 'lucide-react';
import { useSRS } from '@/hooks/useSRS';
import { SRSCardWithWord } from '@/lib/srs';
import { SRSReviewModal } from './SRSReviewModal';

export function SRSReviewQueue() {
  const { dueCount, fetchDueCards, loading } = useSRS();
  const [reviewMode, setReviewMode] = useState(false);
  const [dueCards, setDueCards] = useState<SRSCardWithWord[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [showReviewModal, setShowReviewModal] = useState(false);
  const [completedCount, setCompletedCount] = useState(0);

  const currentCard = dueCards[currentIndex];

  const startReview = async () => {
    const cards = await fetchDueCards();
    setDueCards(cards);
    setCurrentIndex(0);
    setCompletedCount(0);
    setReviewMode(true);
  };

  const handleReviewComplete = () => {
    setCompletedCount((prev) => prev + 1);
    
    if (currentIndex < dueCards.length - 1) {
      // Move to next card
      setCurrentIndex((prev) => prev + 1);
    } else {
      // All done!
      setReviewMode(false);
      setDueCards([]);
      setCurrentIndex(0);
    }
  };

  if (dueCount === 0) {
    return null;
  }

  return (
    <>
      {/* Dashboard Call-to-Action Card */}
      {!reviewMode && (
        <Card className="border-2 border-primary/20 bg-gradient-to-br from-primary/5 to-primary/10">
          <CardContent className="p-6">
            <div className="flex items-center gap-4">
              <div className="flex h-14 w-14 items-center justify-center rounded-xl bg-primary/10">
                <Brain className="h-7 w-7 text-primary" />
              </div>
              <div className="flex-1">
                <h3 className="font-display font-bold text-lg mb-1">
                  Time to Review: {dueCount} {dueCount === 1 ? 'Word' : 'Words'}
                </h3>
                <p className="text-sm text-muted-foreground mb-1">
                  Hora da Revisão: {dueCount} {dueCount === 1 ? 'Palavra' : 'Palavras'}
                </p>
                <p className="text-xs text-muted-foreground">
                  Keep your vocabulary fresh with spaced repetition
                </p>
              </div>
              <Button
                onClick={startReview}
                disabled={loading}
                className="bg-gradient-primary hover:opacity-90 gap-2"
              >
                Start Review
                <ArrowRight className="h-4 w-4" />
              </Button>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Review Session Dialog */}
      <Dialog open={reviewMode} onOpenChange={setReviewMode}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle className="font-display flex items-center justify-between">
              <span>Vocabulary Review</span>
              <Badge variant="secondary">
                {completedCount} / {dueCards.length}
              </Badge>
            </DialogTitle>
          </DialogHeader>

          {currentCard ? (
            <div className="space-y-6 py-4">
              {/* Progress Bar */}
              <div className="w-full bg-muted rounded-full h-2">
                <div
                  className="bg-gradient-primary h-2 rounded-full transition-all duration-300"
                  style={{
                    width: `${(completedCount / dueCards.length) * 100}%`,
                  }}
                />
              </div>

              {/* Word Display */}
              <div className="text-center space-y-4 py-6">
                <h2 className="font-display text-4xl font-bold text-foreground">
                  {currentCard.word.headword}
                </h2>
                {currentCard.word.ipa && (
                  <p className="text-lg font-mono text-muted-foreground">
                    {currentCard.word.ipa}
                  </p>
                )}
                {currentCard.word.pos && (
                  <Badge variant="secondary">{currentCard.word.pos}</Badge>
                )}
              </div>

              {/* Definition */}
              <div className="space-y-4 bg-muted/50 p-6 rounded-lg">
                {currentCard.word.definition_simple && (
                  <div>
                    <p className="text-sm font-medium text-foreground mb-2">
                      Definition
                    </p>
                    <p className="text-base text-foreground">
                      {currentCard.word.definition_simple}
                    </p>
                  </div>
                )}

                {currentCard.word.examples &&
                  Array.isArray(currentCard.word.examples) &&
                  currentCard.word.examples.length > 0 && (
                    <div>
                      <p className="text-sm font-medium text-foreground mb-2">
                        Examples
                      </p>
                      <ul className="space-y-2">
                        {currentCard.word.examples.slice(0, 2).map((ex, i) => (
                          <li
                            key={i}
                            className="text-sm text-muted-foreground italic"
                          >
                            "{ex}"
                          </li>
                        ))}
                      </ul>
                    </div>
                  )}

                {currentCard.word.collocations &&
                  Array.isArray(currentCard.word.collocations) &&
                  currentCard.word.collocations.length > 0 && (
                    <div>
                      <p className="text-sm font-medium text-foreground mb-2">
                        Collocations
                      </p>
                      <div className="flex gap-2 flex-wrap">
                        {currentCard.word.collocations.slice(0, 4).map((c, i) => (
                          <Badge key={i} variant="outline" className="text-xs">
                            {c}
                          </Badge>
                        ))}
                      </div>
                    </div>
                  )}
              </div>

              {/* Review Button */}
              <div className="flex justify-center pt-4">
                <Button
                  onClick={() => setShowReviewModal(true)}
                  size="lg"
                  className="bg-gradient-primary hover:opacity-90"
                >
                  Rate Your Recall
                </Button>
              </div>
            </div>
          ) : (
            <div className="text-center py-12">
              <CheckCircle2 className="h-16 w-16 text-green-500 mx-auto mb-4" />
              <h3 className="font-display text-2xl font-bold mb-2">
                All Done!
              </h3>
              <p className="text-muted-foreground mb-6">
                You've reviewed all your due words. Great job!
              </p>
              <Button onClick={() => setReviewMode(false)}>Close</Button>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* SRS Review Modal */}
      {currentCard && (
        <SRSReviewModal
          open={showReviewModal}
          onOpenChange={setShowReviewModal}
          cardId={currentCard.id}
          wordHeadword={currentCard.word.headword}
          onReviewComplete={handleReviewComplete}
        />
      )}
    </>
  );
}

import { useState } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { RATING_OPTIONS, UserRating } from '@/lib/srs';
import { useSRS } from '@/hooks/useSRS';
import { useToast } from '@/hooks/use-toast';
import { Loader2 } from 'lucide-react';

interface SRSReviewModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  cardId: string;
  wordHeadword: string;
  onReviewComplete?: () => void;
}

export function SRSReviewModal({
  open,
  onOpenChange,
  cardId,
  wordHeadword,
  onReviewComplete,
}: SRSReviewModalProps) {
  const { reviewCard } = useSRS();
  const { toast } = useToast();
  const [submitting, setSubmitting] = useState(false);

  const handleRating = async (rating: UserRating) => {
    setSubmitting(true);
    try {
      const success = await reviewCard(cardId, rating);

      if (success) {
        toast({
          title: 'Review scheduled!',
          description: 'Your progress has been saved.',
        });
        onOpenChange(false);
        onReviewComplete?.();
      } else {
        toast({
          title: 'Error',
          description: 'Failed to save your review. Please try again.',
          variant: 'destructive',
        });
      }
    } catch (err) {
      console.error('Error submitting review:', err);
      toast({
        title: 'Error',
        description: 'An unexpected error occurred.',
        variant: 'destructive',
      });
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle className="font-display text-xl">
            How well did you remember this word?
          </DialogTitle>
          <DialogDescription className="text-base italic">
            O quão bem você lembrou desta palavra?
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-3 py-4">
          <p className="text-sm text-muted-foreground text-center mb-4">
            Word: <span className="font-semibold text-foreground">{wordHeadword}</span>
          </p>

          {RATING_OPTIONS.map((option) => (
            <Button
              key={option.value}
              onClick={() => handleRating(option.value)}
              disabled={submitting}
              className={`w-full justify-start text-left h-auto py-3 px-4 ${option.color} text-white`}
              variant="default"
            >
              <span className="mr-3 text-xl">{option.icon}</span>
              <div className="flex-1">
                <div className="font-semibold">{option.label}</div>
                <div className="text-sm opacity-90">{option.labelPt}</div>
              </div>
              {submitting && <Loader2 className="h-4 w-4 animate-spin ml-2" />}
            </Button>
          ))}
        </div>

        <div className="text-xs text-muted-foreground text-center">
          Your answer helps us schedule the next review at the optimal time.
        </div>
      </DialogContent>
    </Dialog>
  );
}

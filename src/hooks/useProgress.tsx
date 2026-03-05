import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';

export interface LearnerProgress {
  currentStreak: number;
  longestStreak: number;
  lastActivityDate: string | null;
  totalStudyTimeMinutes: number;
  wordsLearned: number;
  grammarChaptersViewed: number;
  lessonsCompleted: number;
}

export function useProgress() {
  const { user } = useAuth();
  const [progress, setProgress] = useState<LearnerProgress | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!user) {
      setProgress(null);
      setLoading(false);
      return;
    }

    const fetchProgress = async () => {
      try {
        const { data, error } = await supabase
          .from('learner_progress')
          .select('*')
          .eq('user_id', user.id)
          .single();

        if (error && error.code !== 'PGRST116') {
          // PGRST116 = no rows returned
          console.error('Error fetching progress:', error);
          setProgress(null);
        } else if (data) {
          setProgress({
            currentStreak: data.current_streak,
            longestStreak: data.longest_streak,
            lastActivityDate: data.last_activity_date,
            totalStudyTimeMinutes: data.total_study_time_minutes,
            wordsLearned: data.words_learned,
            grammarChaptersViewed: data.grammar_chapters_viewed,
            lessonsCompleted: data.lessons_completed,
          });
        } else {
          // No progress record yet - return defaults
          setProgress({
            currentStreak: 0,
            longestStreak: 0,
            lastActivityDate: null,
            totalStudyTimeMinutes: 0,
            wordsLearned: 0,
            grammarChaptersViewed: 0,
            lessonsCompleted: 0,
          });
        }
      } catch (err) {
        console.error('Error fetching progress:', err);
        setProgress(null);
      } finally {
        setLoading(false);
      }
    };

    fetchProgress();

    // Subscribe to changes
    const channel = supabase
      .channel('learner_progress_changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'learner_progress',
          filter: `user_id=eq.${user.id}`,
        },
        () => {
          fetchProgress();
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [user]);

  return { progress, loading };
}

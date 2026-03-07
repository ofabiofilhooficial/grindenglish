import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

export function useStageCompletion(lessonId: string | undefined) {
  const [completedStages, setCompletedStages] = useState<Set<string>>(new Set());
  const [loading, setLoading] = useState(true);
  const { toast } = useToast();

  useEffect(() => {
    if (!lessonId) return;
    fetchCompletedStages();
  }, [lessonId]);

  const fetchCompletedStages = async () => {
    if (!lessonId) return;
    
    setLoading(true);
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const { data, error } = await supabase
        .rpc('get_completed_stages', {
          _user_id: user.id,
          _lesson_id: lessonId
        });

      if (error) {
        console.error('Error fetching completed stages:', error);
      } else if (data) {
        const stageIds = new Set(data.map((item: any) => item.stage_id));
        setCompletedStages(stageIds);
      }
    } catch (error) {
      console.error('Error in fetchCompletedStages:', error);
    }
    setLoading(false);
  };

  const completeStage = async (stageId: string) => {
    try {
      const { data, error } = await supabase
        .rpc('complete_stage', { _stage_id: stageId });

      if (error) {
        console.error('Error completing stage:', error);
        toast({
          title: 'Error',
          description: 'Failed to mark stage as complete',
          variant: 'destructive',
        });
        return false;
      }

      // Update local state
      setCompletedStages((prev) => new Set(prev).add(stageId));
      
      return true;
    } catch (error) {
      console.error('Error in completeStage:', error);
      return false;
    }
  };

  const isStageComplete = (stageId: string) => {
    return completedStages.has(stageId);
  };

  const getCompletionCount = () => {
    return completedStages.size;
  };

  return {
    completedStages,
    loading,
    completeStage,
    isStageComplete,
    getCompletionCount,
    refreshCompletions: fetchCompletedStages,
  };
}

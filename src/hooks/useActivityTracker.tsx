import { useEffect, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';

export type ActivityEventType =
  | 'login'
  | 'dashboard_view'
  | 'lesson_start'
  | 'lesson_complete'
  | 'grammar_view'
  | 'vocab_view'
  | 'pronunciation_view'
  | 'pragmatics_view'
  | 'course_view'
  | 'level_view'
  | 'unit_view'
  | 'progress_view';

export function useActivityTracker() {
  const { user } = useAuth();

  const logActivity = useCallback(
    async (eventType: ActivityEventType, eventData: Record<string, any> = {}) => {
      if (!user) return;
      try {
        const { error } = await supabase.rpc('log_activity_event' as any, {
          _user_id: user.id,
          _event_type: eventType,
          _event_data: eventData,
        });
        if (error) {
          console.error('Failed to log activity:', error);
        }
      } catch (err) {
        console.error('Error logging activity:', err);
      }
    },
    [user]
  );

  return { logActivity };
}

export function usePageViewTracker(eventType: ActivityEventType, eventData?: Record<string, any>) {
  const { logActivity } = useActivityTracker();
  useEffect(() => {
    logActivity(eventType, eventData);
  }, [eventType, logActivity]);
}

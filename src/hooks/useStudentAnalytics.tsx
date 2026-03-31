import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';

export interface StudentAnalytics {
  user_id: string;
  full_name: string | null;
  avatar_url: string | null;
  email?: string;
  current_streak: number;
  longest_streak: number;
  last_activity_date: string | null;
  total_study_time_minutes: number;
  words_learned: number;
  grammar_chapters_viewed: number;
  lessons_completed: number;
  stages_completed: number;
  vocabulary_accuracy: number;
  cohort_name?: string;
  enrollment_date?: string;
}

export interface CohortAnalytics {
  cohort_id: string;
  cohort_name: string;
  student_count: number;
  avg_completion_rate: number;
  avg_study_time: number;
  avg_streak: number;
  students: StudentAnalytics[];
}

export function useStudentAnalytics(cohortId?: string) {
  const { user } = useAuth();
  const [students, setStudents] = useState<StudentAnalytics[]>([]);
  const [cohortAnalytics, setCohortAnalytics] = useState<CohortAnalytics | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchStudentAnalytics = useCallback(async () => {
    if (!user) return;

    setLoading(true);
    setError(null);

    try {
      // If cohortId is provided, fetch students from that cohort
      // Otherwise, fetch all students the teacher has access to
      let query = supabase
        .from('profiles')
        .select(`
          id,
          full_name,
          avatar_url,
          learner_progress (
            current_streak,
            longest_streak,
            last_activity_date,
            total_study_time_minutes,
            words_learned,
            grammar_chapters_viewed,
            lessons_completed
          ),
          user_stage_completions!inner(count),
          vocabulary_practice_answers (
            is_correct
          )
        `);

      if (cohortId) {
        // Join with cohort_members to filter by cohort
        query = query
          .select(`
            id,
            full_name,
            avatar_url,
            learner_progress (
              current_streak,
              longest_streak,
              last_activity_date,
              total_study_time_minutes,
              words_learned,
              grammar_chapters_viewed,
              lessons_completed
            ),
            user_stage_completions!inner(count),
            vocabulary_practice_answers (
              is_correct
            ),
            cohort_members!inner (
              cohort_id,
              cohorts (
                name
              )
            )
          `)
          .eq('cohort_members.cohort_id', cohortId);
      } else {
        // For teachers, get all students from their cohorts
        const { data: teacherCohorts } = await supabase
          .from('cohorts')
          .select('id')
          .eq('teacher_id', user.id);

        if (teacherCohorts && teacherCohorts.length > 0) {
          const cohortIds = teacherCohorts.map(c => c.id);
          query = query
            .select(`
              id,
              full_name,
              avatar_url,
              learner_progress (
                current_streak,
                longest_streak,
                last_activity_date,
                total_study_time_minutes,
                words_learned,
                grammar_chapters_viewed,
                lessons_completed
              ),
              user_stage_completions!inner(count),
              vocabulary_practice_answers (
                is_correct
              ),
              cohort_members (
                cohorts (
                  name
                )
              )
            `)
            .in('cohort_members.cohort_id', cohortIds);
        }
      }

      const { data, error } = await query;

      if (error) throw error;

      // Process and aggregate the data
      const processedStudents: StudentAnalytics[] = (data || []).map((student: any) => {
        const progress = student.learner_progress?.[0] || {};
        const vocabAnswers = student.vocabulary_practice_answers || [];
        const totalVocabAttempts = vocabAnswers.length;
        const correctVocabAnswers = vocabAnswers.filter((a: any) => a.is_correct).length;
        const vocabularyAccuracy = totalVocabAttempts > 0 ? (correctVocabAnswers / totalVocabAttempts) * 100 : 0;

        return {
          user_id: student.id,
          full_name: student.full_name,
          avatar_url: student.avatar_url,
          current_streak: progress.current_streak || 0,
          longest_streak: progress.longest_streak || 0,
          last_activity_date: progress.last_activity_date,
          total_study_time_minutes: progress.total_study_time_minutes || 0,
          words_learned: progress.words_learned || 0,
          grammar_chapters_viewed: progress.grammar_chapters_viewed || 0,
          lessons_completed: progress.lessons_completed || 0,
          stages_completed: student.user_stage_completions?.[0]?.count || 0,
          vocabulary_accuracy: Math.round(vocabularyAccuracy),
          cohort_name: student.cohort_members?.[0]?.cohorts?.name,
        };
      });

      setStudents(processedStudents);

      // Calculate cohort analytics if we have a specific cohort
      if (cohortId && processedStudents.length > 0) {
        const avgCompletionRate = processedStudents.reduce((sum, s) => sum + s.lessons_completed, 0) / processedStudents.length;
        const avgStudyTime = processedStudents.reduce((sum, s) => sum + s.total_study_time_minutes, 0) / processedStudents.length;
        const avgStreak = processedStudents.reduce((sum, s) => sum + s.current_streak, 0) / processedStudents.length;

        setCohortAnalytics({
          cohort_id: cohortId,
          cohort_name: processedStudents[0]?.cohort_name || 'Unknown Cohort',
          student_count: processedStudents.length,
          avg_completion_rate: Math.round(avgCompletionRate),
          avg_study_time: Math.round(avgStudyTime),
          avg_streak: Math.round(avgStreak),
          students: processedStudents,
        });
      }

    } catch (err: any) {
      console.error('Error fetching student analytics:', err);
      setError(err.message || 'Failed to load student analytics');
    } finally {
      setLoading(false);
    }
  }, [user, cohortId]);

  useEffect(() => {
    fetchStudentAnalytics();
  }, [fetchStudentAnalytics]);

  return {
    students,
    cohortAnalytics,
    loading,
    error,
    refetch: fetchStudentAnalytics,
  };
}
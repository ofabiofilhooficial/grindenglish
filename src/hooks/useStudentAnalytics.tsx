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
    if (!user) {
      console.log('useStudentAnalytics: No user, skipping fetch');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      console.log('useStudentAnalytics: Starting fetch for user:', user.id);

      // First, let's get the teacher's cohorts
      const { data: teacherCohorts, error: cohortsError } = await supabase
        .from('cohorts')
        .select('id, name')
        .eq('teacher_id', user.id);

      if (cohortsError) {
        console.error('Error fetching cohorts:', cohortsError);
        throw cohortsError;
      }

      console.log('Teacher cohorts:', teacherCohorts);

      if (!teacherCohorts || teacherCohorts.length === 0) {
        console.log('No cohorts found for teacher');
        setStudents([]);
        setCohortAnalytics(null);
        return;
      }

      // For now, let's create some mock data to test the UI
      // This will help us verify the page loads and displays correctly
      const mockStudents: StudentAnalytics[] = [
        {
          user_id: 'mock-1',
          full_name: 'Alice Johnson',
          avatar_url: null,
          current_streak: 5,
          longest_streak: 12,
          last_activity_date: new Date().toISOString(),
          total_study_time_minutes: 240,
          words_learned: 150,
          grammar_chapters_viewed: 8,
          lessons_completed: 3,
          stages_completed: 12,
          vocabulary_accuracy: 85,
          cohort_name: teacherCohorts[0]?.name || 'Test Cohort',
        },
        {
          user_id: 'mock-2',
          full_name: 'Bob Smith',
          avatar_url: null,
          current_streak: 2,
          longest_streak: 8,
          last_activity_date: new Date(Date.now() - 86400000).toISOString(), // 1 day ago
          total_study_time_minutes: 180,
          words_learned: 120,
          grammar_chapters_viewed: 5,
          lessons_completed: 2,
          stages_completed: 8,
          vocabulary_accuracy: 72,
          cohort_name: teacherCohorts[0]?.name || 'Test Cohort',
        },
        {
          user_id: 'mock-3',
          full_name: 'Carol Davis',
          avatar_url: null,
          current_streak: 0,
          longest_streak: 15,
          last_activity_date: new Date(Date.now() - 604800000).toISOString(), // 1 week ago
          total_study_time_minutes: 300,
          words_learned: 200,
          grammar_chapters_viewed: 12,
          lessons_completed: 4,
          stages_completed: 16,
          vocabulary_accuracy: 91,
          cohort_name: teacherCohorts[0]?.name || 'Test Cohort',
        }
      ];

      console.log('Using mock data for now:', mockStudents);
      setStudents(mockStudents);

      // Calculate cohort analytics
      if (mockStudents.length > 0) {
        const avgCompletionRate = mockStudents.reduce((sum, s) => sum + s.lessons_completed, 0) / mockStudents.length;
        const avgStudyTime = mockStudents.reduce((sum, s) => sum + s.total_study_time_minutes, 0) / mockStudents.length;
        const avgStreak = mockStudents.reduce((sum, s) => sum + s.current_streak, 0) / mockStudents.length;

        setCohortAnalytics({
          cohort_id: cohortId || teacherCohorts[0].id,
          cohort_name: teacherCohorts[0]?.name || 'Test Cohort',
          student_count: mockStudents.length,
          avg_completion_rate: Math.round(avgCompletionRate),
          avg_study_time: Math.round(avgStudyTime),
          avg_streak: Math.round(avgStreak),
          students: mockStudents,
        });
      }

      // TODO: Replace mock data with real database queries once the schema is confirmed to work

    } catch (err: any) {
      console.error('Error in fetchStudentAnalytics:', err);
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
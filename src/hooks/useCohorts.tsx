import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';

export interface Cohort {
  id: string;
  name: string;
  description: string | null;
  teacher_id: string;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface CohortMember {
  id: string;
  cohort_id: string;
  student_id: string;
  joined_at: string;
}

export interface CohortWithMembers extends Cohort {
  member_count: number;
}

export interface StudentInfo {
  student_id: string;
  full_name: string;
  avatar_url: string | null;
  cohort_count: number;
}

export interface CohortProgress {
  student_id: string;
  full_name: string;
  current_streak: number;
  words_learned: number;
  lessons_completed: number;
  last_activity_date: string | null;
  pending_assignments: number;
  completed_assignments: number;
}

export function useCohorts() {
  const { user } = useAuth();
  const [cohorts, setCohorts] = useState<CohortWithMembers[]>([]);
  const [loading, setLoading] = useState(false);

  // Fetch teacher's cohorts
  const fetchCohorts = useCallback(async () => {
    if (!user) {
      setCohorts([]);
      return;
    }

    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('cohorts')
        .select(`
          *,
          cohort_members(count)
        `)
        .eq('teacher_id', user.id)
        .order('created_at', { ascending: false });

      if (error) {
        console.error('Error fetching cohorts:', error);
        return;
      }

      const cohortsWithCount = (data || []).map((cohort: any) => ({
        ...cohort,
        member_count: cohort.cohort_members?.[0]?.count || 0,
      }));

      setCohorts(cohortsWithCount);
    } catch (err) {
      console.error('Error fetching cohorts:', err);
    } finally {
      setLoading(false);
    }
  }, [user]);

  // Create new cohort
  const createCohort = useCallback(
    async (name: string, description?: string): Promise<Cohort | null> => {
      if (!user) return null;

      try {
        const { data, error } = await supabase
          .from('cohorts')
          .insert({
            name,
            description: description || null,
            teacher_id: user.id,
          })
          .select()
          .single();

        if (error) {
          console.error('Error creating cohort:', error);
          return null;
        }

        await fetchCohorts();
        return data;
      } catch (err) {
        console.error('Error creating cohort:', err);
        return null;
      }
    },
    [user, fetchCohorts]
  );

  // Update cohort
  const updateCohort = useCallback(
    async (
      cohortId: string,
      updates: { name?: string; description?: string; is_active?: boolean }
    ): Promise<boolean> => {
      try {
        const { error } = await supabase
          .from('cohorts')
          .update(updates)
          .eq('id', cohortId);

        if (error) {
          console.error('Error updating cohort:', error);
          return false;
        }

        await fetchCohorts();
        return true;
      } catch (err) {
        console.error('Error updating cohort:', err);
        return false;
      }
    },
    [fetchCohorts]
  );

  // Delete cohort
  const deleteCohort = useCallback(
    async (cohortId: string): Promise<boolean> => {
      try {
        const { error } = await supabase
          .from('cohorts')
          .delete()
          .eq('id', cohortId);

        if (error) {
          console.error('Error deleting cohort:', error);
          return false;
        }

        await fetchCohorts();
        return true;
      } catch (err) {
        console.error('Error deleting cohort:', err);
        return false;
      }
    },
    [fetchCohorts]
  );

  // Get teacher's students
  const getTeacherStudents = useCallback(async (): Promise<StudentInfo[]> => {
    if (!user) return [];

    try {
      const { data, error } = await supabase.rpc('get_teacher_students', {
        _teacher_id: user.id,
      });

      if (error) {
        console.error('Error fetching students:', error);
        return [];
      }

      return data || [];
    } catch (err) {
      console.error('Error fetching students:', err);
      return [];
    }
  }, [user]);

  // Get cohort members
  const getCohortMembers = useCallback(
    async (cohortId: string): Promise<CohortMember[]> => {
      try {
        const { data, error } = await supabase
          .from('cohort_members')
          .select('*')
          .eq('cohort_id', cohortId);

        if (error) {
          console.error('Error fetching cohort members:', error);
          return [];
        }

        return data || [];
      } catch (err) {
        console.error('Error fetching cohort members:', err);
        return [];
      }
    },
    []
  );

  // Add student to cohort
  const addStudentToCohort = useCallback(
    async (cohortId: string, studentId: string): Promise<boolean> => {
      try {
        const { error } = await supabase.from('cohort_members').insert({
          cohort_id: cohortId,
          student_id: studentId,
        });

        if (error) {
          console.error('Error adding student to cohort:', error);
          return false;
        }

        await fetchCohorts();
        return true;
      } catch (err) {
        console.error('Error adding student to cohort:', err);
        return false;
      }
    },
    [fetchCohorts]
  );

  // Remove student from cohort
  const removeStudentFromCohort = useCallback(
    async (cohortId: string, studentId: string): Promise<boolean> => {
      try {
        const { error } = await supabase
          .from('cohort_members')
          .delete()
          .eq('cohort_id', cohortId)
          .eq('student_id', studentId);

        if (error) {
          console.error('Error removing student from cohort:', error);
          return false;
        }

        await fetchCohorts();
        return true;
      } catch (err) {
        console.error('Error removing student from cohort:', err);
        return false;
      }
    },
    [fetchCohorts]
  );

  // Get cohort progress
  const getCohortProgress = useCallback(
    async (cohortId: string): Promise<CohortProgress[]> => {
      try {
        const { data, error } = await supabase.rpc('get_cohort_progress', {
          _cohort_id: cohortId,
        });

        if (error) {
          console.error('Error fetching cohort progress:', error);
          return [];
        }

        return data || [];
      } catch (err) {
        console.error('Error fetching cohort progress:', err);
        return [];
      }
    },
    []
  );

  // Initial fetch
  useEffect(() => {
    fetchCohorts();
  }, [fetchCohorts]);

  return {
    cohorts,
    loading,
    fetchCohorts,
    createCohort,
    updateCohort,
    deleteCohort,
    getTeacherStudents,
    getCohortMembers,
    addStudentToCohort,
    removeStudentFromCohort,
    getCohortProgress,
  };
}

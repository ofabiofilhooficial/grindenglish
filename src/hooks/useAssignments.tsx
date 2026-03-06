import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';

export interface Assignment {
  id: string;
  cohort_id: string | null;
  student_id: string | null;
  teacher_id: string;
  content_type: 'grammar' | 'vocabulary' | 'lesson' | 'unit';
  content_id: string;
  status: 'pending' | 'in_progress' | 'completed';
  due_date: string | null;
  assigned_at: string;
  completed_at: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface AssignmentWithContent extends Assignment {
  content_title?: string;
}

export interface StudentAssignment {
  id: string;
  content_type: string;
  content_id: string;
  status: string;
  due_date: string | null;
  assigned_at: string;
  teacher_name: string;
  cohort_name: string | null;
  notes: string | null;
}

export function useAssignments() {
  const { user } = useAuth();
  const [assignments, setAssignments] = useState<Assignment[]>([]);
  const [loading, setLoading] = useState(false);

  // Fetch teacher's assignments
  const fetchAssignments = useCallback(async () => {
    if (!user) {
      setAssignments([]);
      return;
    }

    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('assignments')
        .select('*')
        .eq('teacher_id', user.id)
        .order('assigned_at', { ascending: false });

      if (error) {
        console.error('Error fetching assignments:', error);
        return;
      }

      setAssignments(data || []);
    } catch (err) {
      console.error('Error fetching assignments:', err);
    } finally {
      setLoading(false);
    }
  }, [user]);

  // Create assignment
  const createAssignment = useCallback(
    async (
      contentType: 'grammar' | 'vocabulary' | 'lesson' | 'unit',
      contentId: string,
      options: {
        cohortId?: string;
        studentId?: string;
        dueDate?: string;
        notes?: string;
      }
    ): Promise<Assignment | null> => {
      if (!user) return null;

      try {
        const { data, error } = await supabase
          .from('assignments')
          .insert({
            teacher_id: user.id,
            content_type: contentType,
            content_id: contentId,
            cohort_id: options.cohortId || null,
            student_id: options.studentId || null,
            due_date: options.dueDate || null,
            notes: options.notes || null,
          })
          .select()
          .single();

        if (error) {
          console.error('Error creating assignment:', error);
          return null;
        }

        await fetchAssignments();
        return data;
      } catch (err) {
        console.error('Error creating assignment:', err);
        return null;
      }
    },
    [user, fetchAssignments]
  );

  // Update assignment
  const updateAssignment = useCallback(
    async (
      assignmentId: string,
      updates: {
        status?: 'pending' | 'in_progress' | 'completed';
        due_date?: string | null;
        notes?: string | null;
      }
    ): Promise<boolean> => {
      try {
        const { error } = await supabase
          .from('assignments')
          .update(updates)
          .eq('id', assignmentId);

        if (error) {
          console.error('Error updating assignment:', error);
          return false;
        }

        await fetchAssignments();
        return true;
      } catch (err) {
        console.error('Error updating assignment:', err);
        return false;
      }
    },
    [fetchAssignments]
  );

  // Delete assignment
  const deleteAssignment = useCallback(
    async (assignmentId: string): Promise<boolean> => {
      try {
        const { error } = await supabase
          .from('assignments')
          .delete()
          .eq('id', assignmentId);

        if (error) {
          console.error('Error deleting assignment:', error);
          return false;
        }

        await fetchAssignments();
        return true;
      } catch (err) {
        console.error('Error deleting assignment:', err);
        return false;
      }
    },
    [fetchAssignments]
  );

  // Get cohort assignments
  const getCohortAssignments = useCallback(
    async (cohortId: string): Promise<Assignment[]> => {
      try {
        const { data, error } = await supabase
          .from('assignments')
          .select('*')
          .eq('cohort_id', cohortId)
          .order('assigned_at', { ascending: false });

        if (error) {
          console.error('Error fetching cohort assignments:', error);
          return [];
        }

        return data || [];
      } catch (err) {
        console.error('Error fetching cohort assignments:', err);
        return [];
      }
    },
    []
  );

  // Get student assignments (for student view)
  const getStudentAssignments = useCallback(
    async (studentId: string): Promise<StudentAssignment[]> => {
      try {
        const { data, error } = await supabase.rpc('get_student_assignments', {
          _student_id: studentId,
        });

        if (error) {
          console.error('Error fetching student assignments:', error);
          return [];
        }

        return data || [];
      } catch (err) {
        console.error('Error fetching student assignments:', err);
        return [];
      }
    },
    []
  );

  // Bulk add words to student SRS (for live class)
  const addWordsToStudentSRS = useCallback(
    async (studentIds: string[], wordIds: string[]): Promise<boolean> => {
      if (!user) return false;

      try {
        const { error } = await supabase.rpc('teacher_add_words_to_srs', {
          _student_ids: studentIds,
          _word_ids: wordIds,
          _teacher_id: user.id,
        });

        if (error) {
          console.error('Error adding words to SRS:', error);
          return false;
        }

        return true;
      } catch (err) {
        console.error('Error adding words to SRS:', err);
        return false;
      }
    },
    [user]
  );

  // Initial fetch
  useEffect(() => {
    fetchAssignments();
  }, [fetchAssignments]);

  return {
    assignments,
    loading,
    fetchAssignments,
    createAssignment,
    updateAssignment,
    deleteAssignment,
    getCohortAssignments,
    getStudentAssignments,
    addWordsToStudentSRS,
  };
}

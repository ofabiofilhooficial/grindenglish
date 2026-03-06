import { useState, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';
import { toast } from '@/hooks/use-toast';

export interface Assignment {
  id: string;
  content_type: string;
  content_id: string;
  status: string;
  due_date: string | null;
  assigned_at: string;
  student_id: string | null;
  cohort_id: string | null;
  notes: string | null;
  teacher_id: string;
}

export function useAssignments() {
  const { user } = useAuth();
  const [assignments, setAssignments] = useState<Assignment[]>([]);
  const [loading, setLoading] = useState(false);

  const fetchAssignments = useCallback(async (filters?: { cohort_id?: string; student_id?: string }) => {
    if (!user) return;
    setLoading(true);
    try {
      let query = supabase
        .from('assignments')
        .select('*')
        .eq('teacher_id', user.id)
        .order('assigned_at', { ascending: false });

      if (filters?.cohort_id) query = query.eq('cohort_id', filters.cohort_id);
      if (filters?.student_id) query = query.eq('student_id', filters.student_id);

      const { data, error } = await query;
      if (error) throw error;
      setAssignments((data || []) as Assignment[]);
    } catch (err: any) {
      console.error('Error fetching assignments:', err);
      toast({ title: 'Error', description: 'Failed to load assignments.', variant: 'destructive' });
    } finally {
      setLoading(false);
    }
  }, [user]);

  const createAssignment = useCallback(async (params: {
    content_type: string;
    content_id: string;
    cohort_id?: string;
    student_id?: string;
    due_date?: string;
    notes?: string;
  }) => {
    if (!user) return null;
    try {
      const { data, error } = await supabase
        .from('assignments')
        .insert({
          ...params,
          teacher_id: user.id,
          cohort_id: params.cohort_id || null,
          student_id: params.student_id || null,
          due_date: params.due_date || null,
          notes: params.notes || null,
        })
        .select()
        .single();
      if (error) throw error;
      toast({ title: 'Assignment created' });
      return data as Assignment;
    } catch (err: any) {
      console.error('Error creating assignment:', err);
      toast({ title: 'Error', description: err.message, variant: 'destructive' });
      return null;
    }
  }, [user]);

  const updateAssignmentStatus = useCallback(async (id: string, status: string) => {
    try {
      const { error } = await supabase
        .from('assignments')
        .update({ status })
        .eq('id', id);
      if (error) throw error;
      toast({ title: 'Assignment updated' });
      return true;
    } catch (err: any) {
      console.error('Error updating assignment:', err);
      toast({ title: 'Error', description: err.message, variant: 'destructive' });
      return false;
    }
  }, []);

  const deleteAssignment = useCallback(async (id: string) => {
    try {
      const { error } = await supabase.from('assignments').delete().eq('id', id);
      if (error) throw error;
      toast({ title: 'Assignment deleted' });
      return true;
    } catch (err: any) {
      console.error('Error deleting assignment:', err);
      toast({ title: 'Error', description: err.message, variant: 'destructive' });
      return false;
    }
  }, []);

  return { assignments, loading, fetchAssignments, createAssignment, updateAssignmentStatus, deleteAssignment };
}

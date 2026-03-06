import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';
import { toast } from '@/hooks/use-toast';

export interface Cohort {
  id: string;
  name: string;
  description: string | null;
  teacher_id: string;
  is_active: boolean;
  created_at: string;
  member_count?: number;
}

export interface CohortMember {
  student_id: string;
  full_name: string | null;
  avatar_url: string | null;
}

export function useCohorts() {
  const { user } = useAuth();
  const [cohorts, setCohorts] = useState<Cohort[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchCohorts = useCallback(async () => {
    if (!user) return;
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('cohorts')
        .select('*, cohort_members(count)')
        .eq('teacher_id', user.id)
        .order('created_at', { ascending: false });

      if (error) throw error;

      const mapped = (data || []).map((c: any) => ({
        ...c,
        member_count: c.cohort_members?.[0]?.count || 0,
      }));
      setCohorts(mapped);
    } catch (err: any) {
      console.error('Error fetching cohorts:', err);
      toast({ title: 'Error', description: 'Failed to load cohorts.', variant: 'destructive' });
    } finally {
      setLoading(false);
    }
  }, [user]);

  const createCohort = useCallback(async (name: string, description?: string) => {
    if (!user) return null;
    try {
      const { data, error } = await supabase
        .from('cohorts')
        .insert({ name, description: description || null, teacher_id: user.id })
        .select()
        .single();
      if (error) throw error;
      toast({ title: 'Cohort created', description: `"${name}" is ready.` });
      await fetchCohorts();
      return data;
    } catch (err: any) {
      console.error('Error creating cohort:', err);
      toast({ title: 'Error', description: err.message, variant: 'destructive' });
      return null;
    }
  }, [user, fetchCohorts]);

  const addMember = useCallback(async (cohortId: string, studentId: string) => {
    try {
      const { error } = await supabase
        .from('cohort_members')
        .insert({ cohort_id: cohortId, student_id: studentId });
      if (error) throw error;
      toast({ title: 'Student added' });
      await fetchCohorts();
      return true;
    } catch (err: any) {
      console.error('Error adding member:', err);
      toast({ title: 'Error', description: err.message, variant: 'destructive' });
      return false;
    }
  }, [fetchCohorts]);

  const removeMember = useCallback(async (cohortId: string, studentId: string) => {
    try {
      const { error } = await supabase
        .from('cohort_members')
        .delete()
        .eq('cohort_id', cohortId)
        .eq('student_id', studentId);
      if (error) throw error;
      toast({ title: 'Student removed' });
      return true;
    } catch (err: any) {
      console.error('Error removing member:', err);
      toast({ title: 'Error', description: err.message, variant: 'destructive' });
      return false;
    }
  }, []);

  const deleteCohort = useCallback(async (cohortId: string) => {
    try {
      const { error } = await supabase.from('cohorts').delete().eq('id', cohortId);
      if (error) throw error;
      toast({ title: 'Cohort deleted' });
      await fetchCohorts();
      return true;
    } catch (err: any) {
      console.error('Error deleting cohort:', err);
      toast({ title: 'Error', description: err.message, variant: 'destructive' });
      return false;
    }
  }, [fetchCohorts]);

  const fetchMembers = useCallback(async (cohortId: string): Promise<CohortMember[]> => {
    try {
      const { data, error } = await supabase
        .from('cohort_members')
        .select('student_id, profiles:student_id(full_name, avatar_url)' as any)
        .eq('cohort_id', cohortId);
      if (error) throw error;
      return (data || []).map((m: any) => ({
        student_id: m.student_id,
        full_name: m.profiles?.full_name || null,
        avatar_url: m.profiles?.avatar_url || null,
      }));
    } catch (err) {
      console.error('Error fetching members:', err);
      return [];
    }
  }, []);

  useEffect(() => {
    fetchCohorts();
  }, [fetchCohorts]);

  return { cohorts, loading, fetchCohorts, createCohort, addMember, removeMember, deleteCohort, fetchMembers };
}

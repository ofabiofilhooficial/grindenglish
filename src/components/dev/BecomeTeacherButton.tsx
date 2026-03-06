import { useState } from 'react';
import { Button } from '@/components/ui/button';
import { useToast } from '@/hooks/use-toast';
import { supabase } from '@/integrations/supabase/client';
import { GraduationCap } from 'lucide-react';

/**
 * DEVELOPMENT ONLY COMPONENT
 * Allows users to self-assign teacher role for testing
 * Remove this component in production!
 */
export function BecomeTeacherButton() {
  const { toast } = useToast();
  const [loading, setLoading] = useState(false);

  const handleBecomeTeacher = async () => {
    setLoading(true);
    try {
      const { data, error } = await supabase.rpc('become_teacher');

      if (error) {
        console.error('Error becoming teacher:', error);
        toast({
          title: 'Error',
          description: 'Failed to assign teacher role',
          variant: 'destructive',
        });
        return;
      }

      toast({
        title: 'Success',
        description: 'Teacher role assigned! Please refresh the page.',
      });

      // Refresh the page after a short delay
      setTimeout(() => {
        window.location.reload();
      }, 1500);
    } catch (err) {
      console.error('Error:', err);
      toast({
        title: 'Error',
        description: 'An unexpected error occurred',
        variant: 'destructive',
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <Button
      onClick={handleBecomeTeacher}
      disabled={loading}
      variant="outline"
      size="sm"
      className="gap-2"
    >
      <GraduationCap className="h-4 w-4" />
      {loading ? 'Assigning Role...' : 'Become Teacher (Dev)'}
    </Button>
  );
}

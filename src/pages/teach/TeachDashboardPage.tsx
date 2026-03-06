import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { UsersRound, Plus, Users, ArrowRight, Trash2 } from 'lucide-react';
import { useCohorts } from '@/hooks/useCohorts';

export default function TeachDashboardPage() {
  const navigate = useNavigate();
  const { cohorts, loading, createCohort, deleteCohort } = useCohorts();
  const [newName, setNewName] = useState('');
  const [newDesc, setNewDesc] = useState('');
  const [dialogOpen, setDialogOpen] = useState(false);
  const [creating, setCreating] = useState(false);

  const handleCreate = async () => {
    if (!newName.trim()) return;
    setCreating(true);
    const result = await createCohort(newName.trim(), newDesc.trim());
    if (result) {
      setNewName('');
      setNewDesc('');
      setDialogOpen(false);
    }
    setCreating(false);
  };

  return (
    <AppLayout title="Teach Dashboard" subtitle="Manage your cohorts and students">
      <div className="p-6 space-y-6">
        {/* Header */}
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-2xl font-display font-bold text-foreground">Your Cohorts</h2>
            <p className="text-sm text-muted-foreground">Create groups for your 1-on-1 or small-group students.</p>
          </div>
          <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
            <DialogTrigger asChild>
              <Button><Plus className="h-4 w-4 mr-2" /> New Cohort</Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>Create Cohort</DialogTitle>
              </DialogHeader>
              <div className="space-y-4 pt-2">
                <Input placeholder='e.g. "João Private" or "Maria & Ana B1"' value={newName} onChange={e => setNewName(e.target.value)} />
                <Input placeholder="Description (optional)" value={newDesc} onChange={e => setNewDesc(e.target.value)} />
                <Button onClick={handleCreate} disabled={creating || !newName.trim()} className="w-full">
                  {creating ? 'Creating…' : 'Create Cohort'}
                </Button>
              </div>
            </DialogContent>
          </Dialog>
        </div>

        {/* Cohort List */}
        {loading ? (
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {[1, 2, 3].map(i => (
              <Card key={i}><CardContent className="p-6"><Skeleton className="h-20 w-full" /></CardContent></Card>
            ))}
          </div>
        ) : cohorts.length === 0 ? (
          <Card>
            <CardContent className="p-12 text-center">
              <UsersRound className="h-12 w-12 mx-auto text-muted-foreground mb-4" />
              <p className="text-muted-foreground">No cohorts yet. Create one to start managing students.</p>
            </CardContent>
          </Card>
        ) : (
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {cohorts.map(cohort => (
              <Card key={cohort.id} className="group hover:shadow-md transition-shadow cursor-pointer" onClick={() => navigate(`/teach/cohort/${cohort.id}`)}>
                <CardHeader className="pb-2">
                  <div className="flex items-start justify-between">
                    <CardTitle className="text-lg font-display">{cohort.name}</CardTitle>
                    <Badge variant={cohort.is_active ? 'default' : 'secondary'}>
                      {cohort.is_active ? 'Active' : 'Inactive'}
                    </Badge>
                  </div>
                  {cohort.description && <CardDescription>{cohort.description}</CardDescription>}
                </CardHeader>
                <CardContent>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2 text-sm text-muted-foreground">
                      <Users className="h-4 w-4" />
                      <span>{cohort.member_count || 0} student{(cohort.member_count || 0) !== 1 ? 's' : ''}</span>
                    </div>
                    <div className="flex items-center gap-1">
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={e => { e.stopPropagation(); deleteCohort(cohort.id); }}>
                        <Trash2 className="h-4 w-4 text-muted-foreground" />
                      </Button>
                      <ArrowRight className="h-4 w-4 text-muted-foreground group-hover:text-foreground transition-colors" />
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        )}
      </div>
    </AppLayout>
  );
}

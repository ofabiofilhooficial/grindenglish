import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { useToast } from '@/hooks/use-toast';
import { useCohorts } from '@/hooks/useCohorts';
import { BecomeTeacherButton } from '@/components/dev/BecomeTeacherButton';
import { UsersRound, Plus, Users, Calendar } from 'lucide-react';

export default function TeachDashboardPage() {
  const navigate = useNavigate();
  const { toast } = useToast();
  const { cohorts, loading, createCohort } = useCohorts();
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [newCohortName, setNewCohortName] = useState('');
  const [newCohortDescription, setNewCohortDescription] = useState('');
  const [isCreating, setIsCreating] = useState(false);

  const handleCreateCohort = async () => {
    if (!newCohortName.trim()) {
      toast({
        title: 'Name required',
        description: 'Please enter a cohort name',
        variant: 'destructive',
      });
      return;
    }

    setIsCreating(true);
    const cohort = await createCohort(newCohortName, newCohortDescription);
    setIsCreating(false);

    if (cohort) {
      toast({
        title: 'Cohort created',
        description: `${cohort.name} has been created successfully`,
      });
      setIsCreateDialogOpen(false);
      setNewCohortName('');
      setNewCohortDescription('');
    } else {
      toast({
        title: 'Error',
        description: 'Failed to create cohort',
        variant: 'destructive',
      });
    }
  };

  return (
    <AppLayout title="Cohort Dashboard" subtitle="Manage your teaching groups">
      <div className="p-6 space-y-6">
        {/* Header with Create Button */}
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-2xl font-display font-semibold">Your Cohorts</h2>
            <p className="text-sm text-muted-foreground mt-1">
              Create and manage student groups for personalized instruction
            </p>
          </div>
          <div className="flex items-center gap-2">
            <BecomeTeacherButton />
            <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
            <DialogTrigger asChild>
              <Button>
                <Plus className="h-4 w-4 mr-2" />
                New Cohort
              </Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>Create New Cohort</DialogTitle>
                <DialogDescription>
                  Group students together for tracking and assignments
                </DialogDescription>
              </DialogHeader>
              <div className="space-y-4 py-4">
                <div className="space-y-2">
                  <Label htmlFor="name">Cohort Name</Label>
                  <Input
                    id="name"
                    placeholder="e.g., João Private, Maria & Ana B1"
                    value={newCohortName}
                    onChange={(e) => setNewCohortName(e.target.value)}
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="description">Description (Optional)</Label>
                  <Textarea
                    id="description"
                    placeholder="Add notes about this cohort..."
                    value={newCohortDescription}
                    onChange={(e) => setNewCohortDescription(e.target.value)}
                    rows={3}
                  />
                </div>
              </div>
              <DialogFooter>
                <Button
                  variant="outline"
                  onClick={() => setIsCreateDialogOpen(false)}
                  disabled={isCreating}
                >
                  Cancel
                </Button>
                <Button onClick={handleCreateCohort} disabled={isCreating}>
                  {isCreating ? 'Creating...' : 'Create Cohort'}
                </Button>
              </DialogFooter>
            </DialogContent>
          </div>
        </div>

        {/* Cohorts List */}
        <Card>
          <CardHeader>
            <CardTitle className="font-display flex items-center gap-2">
              <UsersRound className="h-5 w-5" />
              Active Cohorts
            </CardTitle>
          </CardHeader>
          <CardContent>
            {loading ? (
              <div className="space-y-3">
                {[1, 2, 3].map((i) => (
                  <Skeleton key={i} className="h-16 w-full" />
                ))}
              </div>
            ) : cohorts.length === 0 ? (
              <div className="text-center py-12">
                <UsersRound className="h-12 w-12 mx-auto text-muted-foreground mb-4" />
                <p className="text-muted-foreground mb-4">
                  No cohorts yet. Create your first cohort to get started.
                </p>
                <Button onClick={() => setIsCreateDialogOpen(true)}>
                  <Plus className="h-4 w-4 mr-2" />
                  Create First Cohort
                </Button>
              </div>
            ) : (
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Name</TableHead>
                    <TableHead>Description</TableHead>
                    <TableHead>Students</TableHead>
                    <TableHead>Status</TableHead>
                    <TableHead>Created</TableHead>
                    <TableHead className="text-right">Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {cohorts.map((cohort) => (
                    <TableRow
                      key={cohort.id}
                      className="cursor-pointer hover:bg-muted/50"
                      onClick={() => navigate(`/teach/cohorts/${cohort.id}`)}
                    >
                      <TableCell className="font-medium">{cohort.name}</TableCell>
                      <TableCell className="text-muted-foreground">
                        {cohort.description || '—'}
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <Users className="h-4 w-4 text-muted-foreground" />
                          <span>{cohort.member_count}</span>
                        </div>
                      </TableCell>
                      <TableCell>
                        <Badge variant={cohort.is_active ? 'default' : 'secondary'}>
                          {cohort.is_active ? 'Active' : 'Inactive'}
                        </Badge>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2 text-sm text-muted-foreground">
                          <Calendar className="h-4 w-4" />
                          {new Date(cohort.created_at).toLocaleDateString()}
                        </div>
                      </TableCell>
                      <TableCell className="text-right">
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={(e) => {
                            e.stopPropagation();
                            navigate(`/teach/cohorts/${cohort.id}`);
                          }}
                        >
                          View Details
                        </Button>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            )}
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  );
}

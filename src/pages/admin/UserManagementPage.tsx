import { useState, useEffect } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Search, Shield, Users, UserCheck, GraduationCap, BookOpen } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';
import { cn } from '@/lib/utils';
import type { Database } from '@/integrations/supabase/types';

type AppRole = Database['public']['Enums']['app_role'];

interface UserWithRoles {
  id: string;
  full_name: string | null;
  created_at: string;
  roles: AppRole[];
}

const ROLE_META: Record<AppRole, { label: string; icon: React.ElementType; color: string }> = {
  admin: { label: 'Admin', icon: Shield, color: 'bg-destructive/10 text-destructive border-destructive/30' },
  curriculum_designer: { label: 'Curriculum Designer', icon: BookOpen, color: 'bg-primary/10 text-primary border-primary/30' },
  teacher: { label: 'Teacher', icon: GraduationCap, color: 'bg-accent/10 text-accent-foreground border-accent/30' },
  learner: { label: 'Learner', icon: UserCheck, color: 'bg-secondary text-secondary-foreground border-border' },
};

export default function UserManagementPage() {
  const { toast } = useToast();
  const [users, setUsers] = useState<UserWithRoles[]>([]);
  const [search, setSearch] = useState('');
  const [loading, setLoading] = useState(true);
  const [roleFilter, setRoleFilter] = useState<string>('all');
  const [confirmDialog, setConfirmDialog] = useState<{ open: boolean; userId: string; role: AppRole; action: 'add' | 'remove' }>({ open: false, userId: '', role: 'learner', action: 'add' });

  const fetchUsers = async () => {
    setLoading(true);
    const { data: profiles } = await supabase.from('profiles').select('id, full_name, created_at');
    const { data: allRoles } = await supabase.from('user_roles').select('user_id, role');

    if (profiles && allRoles) {
      const usersWithRoles: UserWithRoles[] = profiles.map((p) => ({
        id: p.id,
        full_name: p.full_name,
        created_at: p.created_at,
        roles: allRoles.filter((r) => r.user_id === p.id).map((r) => r.role),
      }));
      setUsers(usersWithRoles);
    }
    setLoading(false);
  };

  useEffect(() => { fetchUsers(); }, []);

  const executeRoleChange = async () => {
    const { userId, role, action } = confirmDialog;
    setConfirmDialog((prev) => ({ ...prev, open: false }));

    if (action === 'add') {
      const { error } = await supabase.from('user_roles').insert({ user_id: userId, role });
      if (error) {
        toast({ title: 'Error', description: error.message, variant: 'destructive' });
      } else {
        toast({ title: 'Role added', description: `Added ${ROLE_META[role].label} role.` });
        fetchUsers();
      }
    } else {
      const { error } = await supabase.from('user_roles').delete().eq('user_id', userId).eq('role', role);
      if (error) {
        toast({ title: 'Error', description: error.message, variant: 'destructive' });
      } else {
        toast({ title: 'Role removed', description: `Removed ${ROLE_META[role].label} role.` });
        fetchUsers();
      }
    }
  };

  const filteredUsers = users.filter((u) => {
    const matchesSearch = (u.full_name || '').toLowerCase().includes(search.toLowerCase());
    const matchesFilter = roleFilter === 'all' || u.roles.includes(roleFilter as AppRole);
    return matchesSearch && matchesFilter;
  });

  const roleCounts = {
    total: users.length,
    admin: users.filter((u) => u.roles.includes('admin')).length,
    curriculum_designer: users.filter((u) => u.roles.includes('curriculum_designer')).length,
    teacher: users.filter((u) => u.roles.includes('teacher')).length,
    learner: users.filter((u) => u.roles.includes('learner')).length,
  };

  const userName = (userId: string) => users.find((u) => u.id === userId)?.full_name || 'Unnamed';

  return (
    <AppLayout title="User Management" subtitle="Manage user roles and permissions">
      <div className="p-6 space-y-6">
        {/* Stats */}
        <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
          <Card className="cursor-pointer hover:shadow-md transition-shadow" onClick={() => setRoleFilter('all')}>
            <CardContent className="p-4 flex items-center gap-3">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-muted">
                <Users className="h-5 w-5 text-muted-foreground" />
              </div>
              <div>
                <p className="text-2xl font-bold">{roleCounts.total}</p>
                <p className="text-xs text-muted-foreground">Total Users</p>
              </div>
            </CardContent>
          </Card>
          {(Object.entries(ROLE_META) as [AppRole, typeof ROLE_META[AppRole]][]).map(([role, meta]) => (
            <Card key={role} className="cursor-pointer hover:shadow-md transition-shadow" onClick={() => setRoleFilter(role)}>
              <CardContent className="p-4 flex items-center gap-3">
                <div className={cn("flex h-10 w-10 items-center justify-center rounded-lg", meta.color)}>
                  <meta.icon className="h-5 w-5" />
                </div>
                <div>
                  <p className="text-2xl font-bold">{roleCounts[role]}</p>
                  <p className="text-xs text-muted-foreground">{meta.label}s</p>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>

        {/* User Table */}
        <Card>
          <CardHeader>
            <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
              <CardTitle className="font-display flex items-center gap-2">
                <Shield className="h-5 w-5" />
                All Users
                {roleFilter !== 'all' && (
                  <Badge variant="outline" className="ml-2 capitalize">
                    {ROLE_META[roleFilter as AppRole]?.label}
                    <button className="ml-1" onClick={() => setRoleFilter('all')}>×</button>
                  </Badge>
                )}
              </CardTitle>
              <div className="relative w-full sm:w-64">
                <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                <Input placeholder="Search users..." value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
              </div>
            </div>
          </CardHeader>
          <CardContent>
            {loading ? (
              <div className="flex justify-center py-12">
                <div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" />
              </div>
            ) : filteredUsers.length === 0 ? (
              <div className="text-center py-12 text-muted-foreground">
                <Users className="h-10 w-10 mx-auto mb-3 opacity-40" />
                <p className="font-medium">No users found</p>
                <p className="text-sm">Try adjusting your search or filter.</p>
              </div>
            ) : (
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>User</TableHead>
                    <TableHead>Roles</TableHead>
                    <TableHead>Joined</TableHead>
                    <TableHead>Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredUsers.map((user) => (
                    <TableRow key={user.id}>
                      <TableCell>
                        <div className="flex items-center gap-3">
                          <div className="flex h-9 w-9 items-center justify-center rounded-full bg-primary text-primary-foreground text-xs font-semibold">
                            {user.full_name?.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase() || '?'}
                          </div>
                          <div>
                            <p className="font-medium">{user.full_name || 'Unnamed'}</p>
                            <p className="text-xs text-muted-foreground font-mono">{user.id.slice(0, 8)}…</p>
                          </div>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex flex-wrap gap-1.5">
                          {user.roles.map((role) => {
                            const meta = ROLE_META[role];
                            return (
                              <Badge
                                key={role}
                                variant="outline"
                                className={cn(meta.color, 'cursor-pointer gap-1')}
                                onClick={() => setConfirmDialog({ open: true, userId: user.id, role, action: 'remove' })}
                              >
                                <meta.icon className="h-3 w-3" />
                                {meta.label} ×
                              </Badge>
                            );
                          })}
                          {user.roles.length === 0 && (
                            <span className="text-xs text-muted-foreground italic">No roles</span>
                          )}
                        </div>
                      </TableCell>
                      <TableCell className="text-muted-foreground text-sm">
                        {new Date(user.created_at).toLocaleDateString()}
                      </TableCell>
                      <TableCell>
                        <Select onValueChange={(value) => setConfirmDialog({ open: true, userId: user.id, role: value as AppRole, action: 'add' })}>
                          <SelectTrigger className="w-[170px]">
                            <SelectValue placeholder="Add role..." />
                          </SelectTrigger>
                          <SelectContent>
                            {(Object.keys(ROLE_META) as AppRole[])
                              .filter((r) => !user.roles.includes(r))
                              .map((r) => (
                                <SelectItem key={r} value={r}>
                                  <span className="flex items-center gap-2">
                                    {ROLE_META[r].label}
                                  </span>
                                </SelectItem>
                              ))}
                          </SelectContent>
                        </Select>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            )}
          </CardContent>
        </Card>

        {/* Confirmation Dialog */}
        <Dialog open={confirmDialog.open} onOpenChange={(open) => setConfirmDialog((prev) => ({ ...prev, open }))}>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>
                {confirmDialog.action === 'add' ? 'Add Role' : 'Remove Role'}
              </DialogTitle>
              <DialogDescription>
                {confirmDialog.action === 'add'
                  ? `Add the "${ROLE_META[confirmDialog.role].label}" role to ${userName(confirmDialog.userId)}?`
                  : `Remove the "${ROLE_META[confirmDialog.role].label}" role from ${userName(confirmDialog.userId)}? They will lose access to associated features.`}
              </DialogDescription>
            </DialogHeader>
            <DialogFooter>
              <Button variant="outline" onClick={() => setConfirmDialog((prev) => ({ ...prev, open: false }))}>
                Cancel
              </Button>
              <Button
                variant={confirmDialog.action === 'remove' ? 'destructive' : 'default'}
                onClick={executeRoleChange}
              >
                {confirmDialog.action === 'add' ? 'Add Role' : 'Remove Role'}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </AppLayout>
  );
}

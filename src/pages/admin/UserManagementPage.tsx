import { useEffect, useState } from 'react'
import { supabase } from '@/lib/supabase'
import { AppRole } from '@/types/auth.types'
import { ProtectedRoute } from '@/components/ProtectedRoute'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'

interface UserWithRoles {
  id: string
  email: string
  full_name: string
  created_at: string
  roles: AppRole[]
}

export const UserManagementPage = () => {
  const [users, setUsers] = useState<UserWithRoles[]>([])
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedRole, setSelectedRole] = useState<AppRole | 'all'>('all')

  useEffect(() => {
    fetchUsers()
  }, [])

  const fetchUsers = async () => {
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select(`
          id,
          full_name,
          created_at,
          user_roles (app_role)
        `)

      if (error) throw error

      // Get emails from auth
      const { data: { users: authUsers } } = await supabase.auth.admin.listUsers()

      const mappedUsers: UserWithRoles[] = (data || []).map((profile: any) => ({
        id: profile.id,
        email: authUsers?.find(u => u.id === profile.id)?.email || '',
        full_name: profile.full_name,
        created_at: profile.created_at,
        roles: profile.user_roles.map((ur: any) => ur.app_role),
      }))

      setUsers(mappedUsers)
    } catch (error) {
      console.error('Error fetching users:', error)
    } finally {
      setLoading(false)
    }
  }

  const updateUserRole = async (userId: string, newRole: AppRole) => {
    try {
      // Remove old roles
      await supabase
        .from('user_roles')
        .delete()
        .eq('user_id', userId)

      // Add new role
      await supabase
        .from('user_roles')
        .insert({ user_id: userId, app_role: newRole })

      fetchUsers()
    } catch (error) {
      console.error('Error updating role:', error)
    }
  }

  const filteredUsers = users.filter(user => {
    const matchesSearch = user.full_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                          user.email.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesRole = selectedRole === 'all' || user.roles.includes(selectedRole)
    return matchesSearch && matchesRole
  })

  return (
    <ProtectedRoute requiredRoles={['admin']}>
      <div className="p-8">
        <Card>
          <CardHeader>
            <CardTitle>User Management</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex gap-4 mb-6">
              <Input
                placeholder="Search by name or email..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="max-w-sm"
              />
              <Select value={selectedRole} onValueChange={(val) => setSelectedRole(val as AppRole | 'all')}>
                <SelectTrigger className="max-w-xs">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Roles</SelectItem>
                  <SelectItem value="learner">Learner</SelectItem>
                  <SelectItem value="teacher">Teacher</SelectItem>
                  <SelectItem value="curriculum_designer">Curriculum Designer</SelectItem>
                  <SelectItem value="admin">Admin</SelectItem>
                </SelectContent>
              </Select>
            </div>

            {loading ? (
              <div className="text-center py-8">Loading...</div>
            ) : (
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Name</TableHead>
                    <TableHead>Email</TableHead>
                    <TableHead>Role</TableHead>
                    <TableHead>Joined</TableHead>
                    <TableHead>Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredUsers.map((user) => (
                    <TableRow key={user.id}>
                      <TableCell>{user.full_name}</TableCell>
                      <TableCell>{user.email}</TableCell>
                      <TableCell>
                        <Select
                          value={user.roles[0] || 'learner'}
                          onValueChange={(val) => updateUserRole(user.id, val as AppRole)}
                        >
                          <SelectTrigger className="w-[180px]">
                            <SelectValue />
                          </SelectTrigger>
                          <SelectContent>
                            <SelectItem value="learner">Learner</SelectItem>
                            <SelectItem value="teacher">Teacher</SelectItem>
                            <SelectItem value="curriculum_designer">Curriculum Designer</SelectItem>
                            <SelectItem value="admin">Admin</SelectItem>
                          </SelectContent>
                        </Select>
                      </TableCell>
                      <TableCell>
                        {new Date(user.created_at).toLocaleDateString()}
                      </TableCell>
                      <TableCell>
                        <Button variant="outline" size="sm">
                          Edit
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
    </ProtectedRoute>
  )
}

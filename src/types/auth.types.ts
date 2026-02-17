export type AppRole = 'admin' | 'curriculum_designer' | 'teacher' | 'learner'

export interface UserProfile {
  id: string
  full_name: string
  avatar_url: string | null
  created_at: string
}

export interface UserRole {
  id: string
  user_id: string
  app_role: AppRole
  created_at: string
}

export interface User {
  id: string
  email: string
  profile: UserProfile
  roles: UserRole[]
}

export interface AuthContextType {
  user: User | null
  loading: boolean
  error: Error | null
  signUp: (email: string, password: string, fullName: string) => Promise<void>
  signIn: (email: string, password: string) => Promise<void>
  signOut: () => Promise<void>
  hasRole: (role: AppRole) => boolean
  isAuthenticated: boolean
}

import React, { createContext, useContext, useEffect, useState } from 'react'
import { supabase } from '@/lib/supabase'
import { User, AuthContextType, AppRole } from '@/types/auth.types'

const AuthContext = createContext<AuthContextType | undefined>(undefined)

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  // Initialize auth state on mount
  useEffect(() => {
    const initializeAuth = async () => {
      try {
        const { data: { session } } = await supabase.auth.getSession()
        
        if (session?.user) {
          await fetchUserData(session.user.id)
        }
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to initialize auth'))
      } finally {
        setLoading(false)
      }
    }

    initializeAuth()

    // Listen for auth changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
      if (event === 'SIGNED_IN' && session?.user) {
        await fetchUserData(session.user.id)
      } else if (event === 'SIGNED_OUT') {
        setUser(null)
      }
    })

    return () => subscription?.unsubscribe()
  }, [])

  const fetchUserData = async (userId: string) => {
    try {
      const { data: authUser } = await supabase.auth.getUser()
      
      if (!authUser.user?.email) return

      // Fetch profile
      const { data: profileData, error: profileError } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single()

      if (profileError) throw profileError

      // Fetch roles
      const { data: rolesData, error: rolesError } = await supabase
        .from('user_roles')
        .select('*')
        .eq('user_id', userId)

      if (rolesError) throw rolesError

      setUser({
        id: userId,
        email: authUser.user.email,
        profile: profileData,
        roles: rolesData || [],
      })
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to fetch user data'))
    }
  }

  const signUp = async (email: string, password: string, fullName: string) => {
    try {
      setError(null)
      
      const { data: { user: authUser }, error: signUpError } = await supabase.auth.signUp({
        email,
        password,
      })

      if (signUpError) throw signUpError
      if (!authUser) throw new Error('Sign up failed')

      // Create profile
      const { error: profileError } = await supabase.from('profiles').insert({
        id: authUser.id,
        full_name: fullName,
        avatar_url: null,
      })

      if (profileError) throw profileError

      // Assign learner role by default
      const { error: roleError } = await supabase.from('user_roles').insert({
        user_id: authUser.id,
        app_role: 'learner',
      })

      if (roleError) throw roleError

      await fetchUserData(authUser.id)
    } catch (err) {
      const error = err instanceof Error ? err : new Error('Sign up failed')
      setError(error)
      throw error
    }
  }

  const signIn = async (email: string, password: string) => {
    try {
      setError(null)
      
      const { data: { user: authUser }, error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password,
      })

      if (signInError) throw signInError
      if (!authUser) throw new Error('Sign in failed')

      await fetchUserData(authUser.id)
    } catch (err) {
      const error = err instanceof Error ? err : new Error('Sign in failed')
      setError(error)
      throw error
    }
  }

  const signOut = async () => {
    try {
      setError(null)
      const { error } = await supabase.auth.signOut()
      if (error) throw error
      setUser(null)
    } catch (err) {
      const error = err instanceof Error ? err : new Error('Sign out failed')
      setError(error)
      throw error
    }
  }

  const hasRole = (role: AppRole): boolean => {
    if (!user) return false
    return user.roles.some(ur => ur.app_role === role)
  }

  const value: AuthContextType = {
    user,
    loading,
    error,
    signUp,
    signIn,
    signOut,
    hasRole,
    isAuthenticated: !!user,
  }

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
}

export const useAuth = () => {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider')
  }
  return context
}

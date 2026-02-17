import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom'
import { AuthProvider } from '@/contexts/AuthContext'
import { AppSidebar } from '@/components/AppSidebar'
import { ProtectedRoute } from '@/components/ProtectedRoute'

// Auth Pages
import { LoginPage } from '@/pages/LoginPage'
import { SignupPage } from '@/pages/SignupPage'

// Learner Pages
import { DashboardPage } from '@/pages/DashboardPage'
import { CoursePage } from '@/pages/CoursePage'
import { ReviewCenterPage } from '@/pages/ReviewCenterPage'
import { PortfolioPage } from '@/pages/PortfolioPage'
import { ProgressPage } from '@/pages/ProgressPage'
import { ReferencePage } from '@/pages/ReferencePage'

// Admin Pages
import { UserManagementPage } from '@/pages/admin/UserManagementPage'
import { OrganizationSettingsPage } from '@/pages/admin/OrganizationSettingsPage'

// Author Pages (coming next)
// import { CourseBuilderPage } from '@/pages/author/CourseBuilderPage'
// import { LexiconManagerPage } from '@/pages/author/LexiconManagerPage'
// ... etc

// Teacher Pages (coming later)
// import { TeacherDashboardPage } from '@/pages/teach/TeacherDashboardPage'
// ... etc

function AppLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex h-screen">
      <AppSidebar />
      <main className="flex-1 overflow-y-auto">{children}</main>
    </div>
  )
}

export function App() {
  return (
    <Router>
      <AuthProvider>
        <Routes>
          {/* Public routes */}
          <Route path="/login" element={<LoginPage />} />
          <Route path="/signup" element={<SignupPage />} />

          {/* Protected routes - Learner section */}
          <Route
            path="/dashboard"
            element={
              <ProtectedRoute>
                <AppLayout>
                  <DashboardPage />
                </AppLayout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/course"
            element={
              <ProtectedRoute>
                <AppLayout>
                  <CoursePage />
                </AppLayout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/review"
            element={
              <ProtectedRoute>
                <AppLayout>
                  <ReviewCenterPage />
                </AppLayout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/portfolio"
            element={
              <ProtectedRoute>
                <AppLayout>
                  <PortfolioPage />
                </AppLayout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/progress"
            element={
              <ProtectedRoute>
                <AppLayout>
                  <ProgressPage />
                </AppLayout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/reference"
            element={
              <ProtectedRoute>
                <AppLayout>
                  <ReferencePage />
                </AppLayout>
              </ProtectedRoute>
            }
          />

          {/* Admin routes */}
          <Route
            path="/admin/users"
            element={
              <ProtectedRoute requiredRoles={['admin']}>
                <AppLayout>
                  <UserManagementPage />
                </AppLayout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/admin/settings"
            element={
              <ProtectedRoute requiredRoles={['admin']}>
                <AppLayout>
                  <OrganizationSettingsPage />
                </AppLayout>
              </ProtectedRoute>
            }
          />

          {/* Redirects */}
          <Route path="/" element={<Navigate to="/dashboard" replace />} />
          <Route path="*" element={<Navigate to="/dashboard" replace />} />
        </Routes>
      </AuthProvider>
    </Router>
  )
}

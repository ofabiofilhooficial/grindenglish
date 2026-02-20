import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AuthProvider } from "@/hooks/useAuth";
import { ProtectedRoute } from "@/components/auth/ProtectedRoute";
import LandingPage from "./pages/LandingPage";
import LoginPage from "./pages/LoginPage";
import SignupPage from "./pages/SignupPage";
import DashboardPage from "./pages/DashboardPage";
import CoursePage from "./pages/CoursePage";
import UnitPage from "./pages/UnitPage";
import LessonPlayerPage from "./pages/LessonPlayerPage";
import NotFound from "./pages/NotFound";

// Admin
import UserManagementPage from "./pages/admin/UserManagementPage";
import AdminSettingsPage from "./pages/admin/AdminSettingsPage";

// Author
import CourseBuilderPage from "./pages/author/CourseBuilderPage";
import LevelDetailPage from "./pages/author/LevelDetailPage";
import UnitEditorPage from "./pages/author/UnitEditorPage";
import LessonEditorPage from "./pages/author/LessonEditorPage";
import LexiconManagerPage from "./pages/author/LexiconManagerPage";
import GrammarManagerPage from "./pages/author/GrammarManagerPage";
import PronunciationManagerPage from "./pages/author/PronunciationManagerPage";
import PragmaticsManagerPage from "./pages/author/PragmaticsManagerPage";
import AssetManagerPage from "./pages/author/AssetManagerPage";
import TagManagerPage from "./pages/author/TagManagerPage";

// Reference (Student)
import VocabularyReferencePage from "./pages/reference/VocabularyReferencePage";
import GrammarReferencePage from "./pages/reference/GrammarReferencePage";
import PronunciationReferencePage from "./pages/reference/PronunciationReferencePage";
import PragmaticsReferencePage from "./pages/reference/PragmaticsReferencePage";

// Teach
import TeachDashboardPage from "./pages/teach/TeachDashboardPage";
import FeedbackQueuePage from "./pages/teach/FeedbackQueuePage";
import StudentAnalyticsPage from "./pages/teach/StudentAnalyticsPage";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      <Toaster />
      <Sonner />
      <BrowserRouter>
        <AuthProvider>
          <Routes>
            {/* Public */}
            <Route path="/" element={<LandingPage />} />
            <Route path="/login" element={<LoginPage />} />
            <Route path="/signup" element={<SignupPage />} />

            {/* Learner (authenticated) */}
            <Route path="/dashboard" element={<ProtectedRoute><DashboardPage /></ProtectedRoute>} />
            <Route path="/course" element={<ProtectedRoute><CoursePage /></ProtectedRoute>} />
            <Route path="/course/:level/:unitId" element={<ProtectedRoute><UnitPage /></ProtectedRoute>} />
            <Route path="/course/:level/:unitId/:lessonId" element={<ProtectedRoute><LessonPlayerPage /></ProtectedRoute>} />

            {/* Reference */}
            <Route path="/lexicon" element={<ProtectedRoute><VocabularyReferencePage /></ProtectedRoute>} />
            <Route path="/grammar" element={<ProtectedRoute><GrammarReferencePage /></ProtectedRoute>} />
            <Route path="/pronunciation" element={<ProtectedRoute><PronunciationReferencePage /></ProtectedRoute>} />
            <Route path="/pragmatics" element={<ProtectedRoute><PragmaticsReferencePage /></ProtectedRoute>} />

            {/* Admin */}
            <Route path="/admin/users" element={<ProtectedRoute requiredRoles={['admin']}><UserManagementPage /></ProtectedRoute>} />
            <Route path="/admin/settings" element={<ProtectedRoute requiredRoles={['admin']}><AdminSettingsPage /></ProtectedRoute>} />

            {/* Author */}
            <Route path="/author/courses" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer']}><CourseBuilderPage /></ProtectedRoute>} />
            <Route path="/author/levels/:levelId" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer']}><LevelDetailPage /></ProtectedRoute>} />
            <Route path="/author/units/:unitId" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer']}><UnitEditorPage /></ProtectedRoute>} />
            <Route path="/author/lessons/:lessonId" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer']}><LessonEditorPage /></ProtectedRoute>} />
            <Route path="/author/lexicon" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer']}><LexiconManagerPage /></ProtectedRoute>} />
            <Route path="/author/grammar" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer']}><GrammarManagerPage /></ProtectedRoute>} />
            <Route path="/author/pronunciation" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer']}><PronunciationManagerPage /></ProtectedRoute>} />
            <Route path="/author/pragmatics" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer']}><PragmaticsManagerPage /></ProtectedRoute>} />
            <Route path="/author/assets" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer']}><AssetManagerPage /></ProtectedRoute>} />
            <Route path="/author/tags" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer']}><TagManagerPage /></ProtectedRoute>} />

            {/* Teach */}
            <Route path="/teach/dashboard" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer', 'teacher']}><TeachDashboardPage /></ProtectedRoute>} />
            <Route path="/teach/feedback" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer', 'teacher']}><FeedbackQueuePage /></ProtectedRoute>} />
            <Route path="/teach/analytics" element={<ProtectedRoute requiredRoles={['admin', 'curriculum_designer', 'teacher']}><StudentAnalyticsPage /></ProtectedRoute>} />

            <Route path="*" element={<NotFound />} />
          </Routes>
        </AuthProvider>
      </BrowserRouter>
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;

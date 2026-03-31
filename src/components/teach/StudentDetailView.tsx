import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Progress } from '@/components/ui/progress';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { supabase } from '@/integrations/supabase/client';
import {
  User,
  Calendar,
  Clock,
  BookOpen,
  Target,
  TrendingUp,
  Award,
  BarChart3,
  Activity
} from 'lucide-react';
import { formatDistanceToNow, format } from 'date-fns';

interface StudentDetailViewProps {
  studentId: string;
  onClose: () => void;
}

interface DetailedStudentData extends StudentAnalytics {
  recentActivity: Array<{
    event_type: string;
    created_at: string;
    metadata?: any;
  }>;
  vocabularyStats: {
    totalAttempts: number;
    correctAnswers: number;
    accuracyByDifficulty: Record<string, number>;
  };
  lessonProgress: Array<{
    lesson_id: string;
    lesson_title: string;
    completed_stages: number;
    total_stages: number;
    completion_percentage: number;
  }>;
}

export function StudentDetailView({ studentId, onClose }: StudentDetailViewProps) {
  const [student, setStudent] = useState<DetailedStudentData | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchStudentDetails = async () => {
      setLoading(true);
      try {
        // Fetch basic student info and progress
        const { data: profileData, error: profileError } = await supabase
          .from('profiles')
          .select(`
            id,
            full_name,
            avatar_url,
            learner_progress (
              current_streak,
              longest_streak,
              last_activity_date,
              total_study_time_minutes,
              words_learned,
              grammar_chapters_viewed,
              lessons_completed
            )
          `)
          .eq('id', studentId)
          .single();

        if (profileError) throw profileError;

        // Fetch recent activity (last 30 days)
        const thirtyDaysAgo = new Date();
        thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

        const { data: activityData } = await supabase
          .from('progress_events')
          .select('event_type, created_at, metadata')
          .eq('user_id', studentId)
          .gte('created_at', thirtyDaysAgo.toISOString())
          .order('created_at', { ascending: false })
          .limit(50);

        // Fetch vocabulary practice stats
        const { data: vocabData } = await supabase
          .from('vocabulary_practice_answers')
          .select('is_correct, vocabulary_practice_items!inner(difficulty_level)')
          .eq('user_id', studentId);

        // Fetch lesson progress
        const { data: lessonData } = await supabase
          .from('lessons')
          .select(`
            id,
            title,
            lesson_stages (
              id,
              user_stage_completions!inner(user_id)
            )
          `)
          .eq('user_stage_completions.user_id', studentId);

        // Process vocabulary stats
        const vocabStats = {
          totalAttempts: vocabData?.length || 0,
          correctAnswers: vocabData?.filter(v => v.is_correct).length || 0,
          accuracyByDifficulty: {} as Record<string, number>
        };

        // Calculate accuracy by difficulty
        const difficultyGroups = vocabData?.reduce((acc, item) => {
          const difficulty = item.vocabulary_practice_items?.difficulty_level || 'unknown';
          if (!acc[difficulty]) acc[difficulty] = { total: 0, correct: 0 };
          acc[difficulty].total++;
          if (item.is_correct) acc[difficulty].correct++;
          return acc;
        }, {} as Record<string, { total: number; correct: number }>);

        Object.entries(difficultyGroups || {}).forEach(([difficulty, stats]) => {
          vocabStats.accuracyByDifficulty[difficulty] = Math.round((stats.correct / stats.total) * 100);
        });

        // Process lesson progress
        const lessonProgress = lessonData?.map(lesson => {
          const totalStages = lesson.lesson_stages?.length || 0;
          const completedStages = lesson.lesson_stages?.filter((stage: any) =>
            stage.user_stage_completions?.length > 0
          ).length || 0;

          return {
            lesson_id: lesson.id,
            lesson_title: lesson.title,
            completed_stages: completedStages,
            total_stages: totalStages,
            completion_percentage: totalStages > 0 ? Math.round((completedStages / totalStages) * 100) : 0
          };
        }) || [];

        const progress = profileData.learner_progress?.[0] || {};

        setStudent({
          user_id: profileData.id,
          full_name: profileData.full_name,
          avatar_url: profileData.avatar_url,
          current_streak: progress.current_streak || 0,
          longest_streak: progress.longest_streak || 0,
          last_activity_date: progress.last_activity_date,
          total_study_time_minutes: progress.total_study_time_minutes || 0,
          words_learned: progress.words_learned || 0,
          grammar_chapters_viewed: progress.grammar_chapters_viewed || 0,
          lessons_completed: progress.lessons_completed || 0,
          stages_completed: lessonProgress.reduce((sum, l) => sum + l.completed_stages, 0),
          vocabulary_accuracy: vocabStats.totalAttempts > 0 ?
            Math.round((vocabStats.correctAnswers / vocabStats.totalAttempts) * 100) : 0,
          recentActivity: activityData || [],
          vocabularyStats: vocabStats,
          lessonProgress
        });

      } catch (error) {
        console.error('Error fetching student details:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchStudentDetails();
  }, [studentId]);

  const formatStudyTime = (minutes: number) => {
    if (minutes < 60) return `${minutes}m`;
    const hours = Math.floor(minutes / 60);
    const remainingMinutes = minutes % 60;
    return remainingMinutes > 0 ? `${hours}h ${remainingMinutes}m` : `${hours}h`;
  };

  const getActivityStatus = (lastActivity: string | null) => {
    if (!lastActivity) return { status: 'Never', color: 'secondary' };

    const daysSince = Math.floor((Date.now() - new Date(lastActivity).getTime()) / (1000 * 60 * 60 * 24));

    if (daysSince === 0) return { status: 'Today', color: 'default' };
    if (daysSince === 1) return { status: 'Yesterday', color: 'default' };
    if (daysSince <= 7) return { status: `${daysSince} days ago`, color: 'secondary' };
    if (daysSince <= 30) return { status: `${Math.floor(daysSince / 7)} weeks ago`, color: 'outline' };

    return { status: 'Inactive', color: 'destructive' };
  };

  if (loading) {
    return (
      <Card>
        <CardContent className="p-6">
          <div className="flex justify-center py-8">
            <div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" />
          </div>
        </CardContent>
      </Card>
    );
  }

  if (!student) {
    return (
      <Card>
        <CardContent className="p-6">
          <p className="text-center text-muted-foreground">Student not found.</p>
        </CardContent>
      </Card>
    );
  }

  const activityStatus = getActivityStatus(student.last_activity_date);

  return (
    <div className="space-y-6">
      {/* Student Header */}
      <Card>
        <CardContent className="p-6">
          <div className="flex items-center gap-4">
            <Avatar className="h-16 w-16">
              <AvatarImage src={student.avatar_url || ''} />
              <AvatarFallback className="text-lg">
                {student.full_name?.split(' ').map(n => n[0]).join('') || 'U'}
              </AvatarFallback>
            </Avatar>
            <div className="flex-1">
              <h2 className="text-2xl font-bold">{student.full_name || 'Unknown Student'}</h2>
              <div className="flex items-center gap-4 mt-2">
                <Badge variant={activityStatus.color as any}>
                  Last active: {activityStatus.status}
                </Badge>
                <div className="flex items-center gap-1 text-sm text-muted-foreground">
                  <Award className="h-4 w-4" />
                  Current streak: {student.current_streak} days
                </div>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Key Metrics */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center gap-2">
              <BookOpen className="h-4 w-4 text-muted-foreground" />
              <span className="text-sm font-medium">Lessons Completed</span>
            </div>
            <p className="text-2xl font-bold">{student.lessons_completed}</p>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center gap-2">
              <Target className="h-4 w-4 text-muted-foreground" />
              <span className="text-sm font-medium">Stages Completed</span>
            </div>
            <p className="text-2xl font-bold">{student.stages_completed}</p>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center gap-2">
              <Clock className="h-4 w-4 text-muted-foreground" />
              <span className="text-sm font-medium">Study Time</span>
            </div>
            <p className="text-2xl font-bold">{formatStudyTime(student.total_study_time_minutes)}</p>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center gap-2">
              <BarChart3 className="h-4 w-4 text-muted-foreground" />
              <span className="text-sm font-medium">Vocabulary Accuracy</span>
            </div>
            <p className="text-2xl font-bold">{student.vocabulary_accuracy}%</p>
          </CardContent>
        </Card>
      </div>

      {/* Detailed Analytics Tabs */}
      <Tabs defaultValue="progress" className="w-full">
        <TabsList className="grid w-full grid-cols-4">
          <TabsTrigger value="progress">Lesson Progress</TabsTrigger>
          <TabsTrigger value="vocabulary">Vocabulary</TabsTrigger>
          <TabsTrigger value="activity">Recent Activity</TabsTrigger>
          <TabsTrigger value="insights">Insights</TabsTrigger>
        </TabsList>

        <TabsContent value="progress" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Lesson-by-Lesson Progress</CardTitle>
            </CardHeader>
            <CardContent>
              {student.lessonProgress.length === 0 ? (
                <p className="text-muted-foreground">No lesson progress data available.</p>
              ) : (
                <div className="space-y-4">
                  {student.lessonProgress.map((lesson) => (
                    <div key={lesson.lesson_id} className="space-y-2">
                      <div className="flex items-center justify-between">
                        <span className="font-medium">{lesson.lesson_title}</span>
                        <span className="text-sm text-muted-foreground">
                          {lesson.completed_stages}/{lesson.total_stages} stages
                        </span>
                      </div>
                      <Progress value={lesson.completion_percentage} className="h-2" />
                      <p className="text-xs text-muted-foreground">
                        {lesson.completion_percentage}% complete
                      </p>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="vocabulary" className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Card>
              <CardHeader>
                <CardTitle>Vocabulary Performance</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div>
                  <div className="flex justify-between text-sm mb-1">
                    <span>Total Attempts</span>
                    <span>{student.vocabularyStats.totalAttempts}</span>
                  </div>
                  <div className="flex justify-between text-sm mb-1">
                    <span>Correct Answers</span>
                    <span>{student.vocabularyStats.correctAnswers}</span>
                  </div>
                  <div className="flex justify-between text-sm font-medium">
                    <span>Overall Accuracy</span>
                    <span>{student.vocabulary_accuracy}%</span>
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle>Accuracy by Difficulty</CardTitle>
              </CardHeader>
              <CardContent>
                {Object.keys(student.vocabularyStats.accuracyByDifficulty).length === 0 ? (
                  <p className="text-muted-foreground">No difficulty data available.</p>
                ) : (
                  <div className="space-y-3">
                    {Object.entries(student.vocabularyStats.accuracyByDifficulty).map(([difficulty, accuracy]) => (
                      <div key={difficulty} className="space-y-1">
                        <div className="flex justify-between text-sm">
                          <span className="capitalize">{difficulty}</span>
                          <span>{accuracy}%</span>
                        </div>
                        <Progress value={accuracy} className="h-2" />
                      </div>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="activity" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Recent Activity (Last 30 Days)</CardTitle>
            </CardHeader>
            <CardContent>
              {student.recentActivity.length === 0 ? (
                <p className="text-muted-foreground">No recent activity.</p>
              ) : (
                <div className="space-y-3">
                  {student.recentActivity.slice(0, 20).map((activity, index) => (
                    <div key={index} className="flex items-center gap-3 p-3 rounded-lg bg-secondary/50">
                      <Activity className="h-4 w-4 text-muted-foreground" />
                      <div className="flex-1">
                        <p className="text-sm font-medium capitalize">
                          {activity.event_type.replace(/_/g, ' ')}
                        </p>
                        <p className="text-xs text-muted-foreground">
                          {formatDistanceToNow(new Date(activity.created_at), { addSuffix: true })}
                        </p>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="insights" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Learning Insights</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="p-4 rounded-lg bg-blue-50 dark:bg-blue-950/20 border border-blue-200 dark:border-blue-800">
                  <h4 className="font-medium text-blue-900 dark:text-blue-100 mb-2">Study Habits</h4>
                  <p className="text-sm text-blue-800 dark:text-blue-200">
                    {student.current_streak >= 7
                      ? "Excellent consistency! This student has maintained a strong study streak."
                      : student.current_streak >= 3
                      ? "Good momentum with recent consistent study sessions."
                      : "Consider encouraging more regular study sessions to build momentum."
                    }
                  </p>
                </div>

                <div className="p-4 rounded-lg bg-green-50 dark:bg-green-950/20 border border-green-200 dark:border-green-800">
                  <h4 className="font-medium text-green-900 dark:text-green-100 mb-2">Vocabulary Performance</h4>
                  <p className="text-sm text-green-800 dark:text-green-200">
                    {student.vocabulary_accuracy >= 80
                      ? "Strong vocabulary skills with high accuracy rates."
                      : student.vocabulary_accuracy >= 60
                      ? "Good progress in vocabulary acquisition."
                      : "May benefit from additional vocabulary practice and review."
                    }
                  </p>
                </div>

                <div className="p-4 rounded-lg bg-purple-50 dark:bg-purple-950/20 border border-purple-200 dark:border-purple-800">
                  <h4 className="font-medium text-purple-900 dark:text-purple-100 mb-2">Content Engagement</h4>
                  <p className="text-sm text-purple-800 dark:text-purple-200">
                    {student.grammar_chapters_viewed > student.lessons_completed
                      ? "Actively exploring grammar content beyond lesson requirements."
                      : "Focusing primarily on core lesson content."
                    }
                  </p>
                </div>

                <div className="p-4 rounded-lg bg-orange-50 dark:bg-orange-950/20 border border-orange-200 dark:border-orange-800">
                  <h4 className="font-medium text-orange-900 dark:text-orange-100 mb-2">Recommendations</h4>
                  <p className="text-sm text-orange-800 dark:text-orange-200">
                    {student.lessons_completed === 0
                      ? "Consider reaching out to encourage starting their first lesson."
                      : student.current_streak === 0 && student.last_activity_date
                      ? "Student may need motivation to return to studying."
                      : "Continue monitoring progress and provide encouragement."
                    }
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
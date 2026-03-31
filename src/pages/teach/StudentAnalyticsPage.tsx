import { useState } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { useStudentAnalytics, StudentAnalytics } from '@/hooks/useStudentAnalytics';
import { useCohorts } from '@/hooks/useCohorts';
import { StudentDetailView } from '@/components/teach/StudentDetailView';
import {
  BarChart3,
  Users,
  TrendingUp,
  Clock,
  BookOpen,
  Target,
  Calendar,
  Award,
  Eye,
  X
} from 'lucide-react';

export default function StudentAnalyticsPage() {
  const [selectedCohort, setSelectedCohort] = useState<string>('');
  const [selectedStudent, setSelectedStudent] = useState<StudentAnalytics | null>(null);

  const { cohorts, loading: cohortsLoading } = useCohorts();
  const { students, cohortAnalytics, loading: analyticsLoading, error } = useStudentAnalytics(selectedCohort || undefined);

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

  if (error) {
    return (
      <AppLayout title="Student Analytics">
        <div className="p-6">
          <Card>
            <CardContent className="p-6">
              <p className="text-destructive">Error loading analytics: {error}</p>
            </CardContent>
          </Card>
        </div>
      </AppLayout>
    );
  }

  return (
    <AppLayout title="Student Analytics" subtitle="Track learner progress and engagement">
      <div className="p-6 space-y-6">
        {/* Cohort Selection */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Users className="h-5 w-5" />
              Select Cohort
            </CardTitle>
          </CardHeader>
          <CardContent>
            <Select value={selectedCohort} onValueChange={setSelectedCohort}>
              <SelectTrigger className="w-full max-w-md">
                <SelectValue placeholder="All cohorts" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="">All cohorts</SelectItem>
                {cohorts.map((cohort) => (
                  <SelectItem key={cohort.id} value={cohort.id}>
                    {cohort.name} ({cohort.member_count} students)
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </CardContent>
        </Card>

        {/* Cohort Summary */}
        {cohortAnalytics && (
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            <Card>
              <CardContent className="p-4">
                <div className="flex items-center gap-2">
                  <Users className="h-4 w-4 text-muted-foreground" />
                  <span className="text-sm font-medium">Students</span>
                </div>
                <p className="text-2xl font-bold">{cohortAnalytics.student_count}</p>
              </CardContent>
            </Card>
            <Card>
              <CardContent className="p-4">
                <div className="flex items-center gap-2">
                  <Target className="h-4 w-4 text-muted-foreground" />
                  <span className="text-sm font-medium">Avg Completion</span>
                </div>
                <p className="text-2xl font-bold">{cohortAnalytics.avg_completion_rate}</p>
                <p className="text-xs text-muted-foreground">lessons completed</p>
              </CardContent>
            </Card>
            <Card>
              <CardContent className="p-4">
                <div className="flex items-center gap-2">
                  <Clock className="h-4 w-4 text-muted-foreground" />
                  <span className="text-sm font-medium">Avg Study Time</span>
                </div>
                <p className="text-2xl font-bold">{formatStudyTime(cohortAnalytics.avg_study_time)}</p>
              </CardContent>
            </Card>
            <Card>
              <CardContent className="p-4">
                <div className="flex items-center gap-2">
                  <TrendingUp className="h-4 w-4 text-muted-foreground" />
                  <span className="text-sm font-medium">Avg Streak</span>
                </div>
                <p className="text-2xl font-bold">{cohortAnalytics.avg_streak}</p>
                <p className="text-xs text-muted-foreground">days</p>
              </CardContent>
            </Card>
          </div>
        )}

        {/* Student List */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <BarChart3 className="h-5 w-5" />
              Student Progress Overview
            </CardTitle>
          </CardHeader>
          <CardContent>
            {analyticsLoading ? (
              <div className="flex justify-center py-8">
                <div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" />
              </div>
            ) : students.length === 0 ? (
              <p className="text-center py-8 text-muted-foreground">
                No students found in {selectedCohort ? 'this cohort' : 'your cohorts'}.
              </p>
            ) : (
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Student</TableHead>
                    <TableHead>Progress</TableHead>
                    <TableHead>Study Time</TableHead>
                    <TableHead>Current Streak</TableHead>
                    <TableHead>Last Activity</TableHead>
                    <TableHead>Vocabulary</TableHead>
                    <TableHead>Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {students.map((student) => {
                    const activityStatus = getActivityStatus(student.last_activity_date);
                    return (
                      <TableRow key={student.user_id}>
                        <TableCell>
                          <div className="flex items-center gap-3">
                            <Avatar className="h-8 w-8">
                              <AvatarImage src={student.avatar_url || ''} />
                              <AvatarFallback>
                                {student.full_name?.split(' ').map(n => n[0]).join('') || 'U'}
                              </AvatarFallback>
                            </Avatar>
                            <div>
                              <p className="font-medium">{student.full_name || 'Unknown Student'}</p>
                              {student.cohort_name && (
                                <p className="text-xs text-muted-foreground">{student.cohort_name}</p>
                              )}
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="space-y-1">
                            <div className="flex items-center gap-2">
                              <BookOpen className="h-3 w-3 text-muted-foreground" />
                              <span className="text-sm">{student.lessons_completed} lessons</span>
                            </div>
                            <div className="flex items-center gap-2">
                              <Target className="h-3 w-3 text-muted-foreground" />
                              <span className="text-sm">{student.stages_completed} stages</span>
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <Clock className="h-4 w-4 text-muted-foreground" />
                            <span>{formatStudyTime(student.total_study_time_minutes)}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <Award className="h-4 w-4 text-muted-foreground" />
                            <span>{student.current_streak} days</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant={activityStatus.color as any}>
                            {activityStatus.status}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <div className="space-y-1">
                            <div className="flex items-center gap-2">
                              <span className="text-sm">{student.words_learned} words</span>
                            </div>
                            <div className="flex items-center gap-2">
                              <span className="text-sm text-muted-foreground">{student.vocabulary_accuracy}% accuracy</span>
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => setSelectedStudent(student)}
                          >
                            <Eye className="h-4 w-4 mr-2" />
                            View Details
                          </Button>
                        </TableCell>
                      </TableRow>
                    );
                  })}
                </TableBody>
              </Table>
            )}
          </CardContent>
        </Card>

        {/* Student Detail Modal/Dialog would go here */}
        <Dialog open={!!selectedStudent} onOpenChange={() => setSelectedStudent(null)}>
          <DialogContent className="max-w-6xl max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle className="flex items-center justify-between">
                Student Details
                <Button
                  variant="ghost"
                  size="icon"
                  onClick={() => setSelectedStudent(null)}
                >
                  <X className="h-4 w-4" />
                </Button>
              </DialogTitle>
            </DialogHeader>
            {selectedStudent && (
              <StudentDetailView
                studentId={selectedStudent.user_id}
                onClose={() => setSelectedStudent(null)}
              />
            )}
          </DialogContent>
        </Dialog>
      </div>
    </AppLayout>
  );
}

import { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
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
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
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
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { useToast } from '@/hooks/use-toast';
import { useCohorts, CohortProgress } from '@/hooks/useCohorts';
import { useAssignments } from '@/hooks/useAssignments';
import { supabase } from '@/integrations/supabase/client';
import {
  Users,
  TrendingUp,
  BookOpen,
  Calendar,
  Plus,
  UserPlus,
  Trash2,
  ArrowLeft,
  Flame,
  Brain,
  GraduationCap,
  Search,
  CheckCircle2,
  Clock,
} from 'lucide-react';

interface GrammarChapter {
  id: string;
  title: string;
  cefr_level: string;
  chapter_code: string;
}

interface LexiconEntry {
  id: string;
  headword: string;
  pos: string;
  cefr_receptive: string;
}

export default function CohortDetailPage() {
  const { cohortId } = useParams<{ cohortId: string }>();
  const navigate = useNavigate();
  const { toast } = useToast();
  
  const {
    cohorts,
    loading: cohortsLoading,
    getCohortProgress,
    getCohortMembers,
    getTeacherStudents,
    addStudentToCohort,
    removeStudentFromCohort,
    updateCohort,
    deleteCohort,
  } = useCohorts();

  const {
    createAssignment,
    getCohortAssignments,
    deleteAssignment,
    addWordsToStudentSRS,
  } = useAssignments();

  const [cohort, setCohort] = useState<any>(null);
  const [progress, setProgress] = useState<CohortProgress[]>([]);
  const [assignments, setAssignments] = useState<any[]>([]);
  const [availableStudents, setAvailableStudents] = useState<any[]>([]);
  const [grammarChapters, setGrammarChapters] = useState<GrammarChapter[]>([]);
  const [loading, setLoading] = useState(true);

  // Dialogs
  const [isAddStudentOpen, setIsAddStudentOpen] = useState(false);
  const [isAssignGrammarOpen, setIsAssignGrammarOpen] = useState(false);
  const [isLiveClassOpen, setIsLiveClassOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);

  // Form states
  const [selectedStudent, setSelectedStudent] = useState('');
  const [selectedChapter, setSelectedChapter] = useState('');
  const [assignmentDueDate, setAssignmentDueDate] = useState('');
  const [assignmentNotes, setAssignmentNotes] = useState('');
  const [wordSearch, setWordSearch] = useState('');
  const [searchResults, setSearchResults] = useState<LexiconEntry[]>([]);
  const [selectedWords, setSelectedWords] = useState<string[]>([]);
  const [editName, setEditName] = useState('');
  const [editDescription, setEditDescription] = useState('');

  // Load cohort data
  useEffect(() => {
    if (!cohortId) return;

    const loadData = async () => {
      setLoading(true);
      try {
        // Find cohort
        const foundCohort = cohorts.find((c) => c.id === cohortId);
        if (foundCohort) {
          setCohort(foundCohort);
          setEditName(foundCohort.name);
          setEditDescription(foundCohort.description || '');
        }

        // Load progress
        const progressData = await getCohortProgress(cohortId);
        setProgress(progressData);

        // Load assignments
        const assignmentsData = await getCohortAssignments(cohortId);
        setAssignments(assignmentsData);

        // Load available students
        const students = await getTeacherStudents();
        const members = await getCohortMembers(cohortId);
        const memberIds = members.map((m) => m.student_id);
        const available = students.filter((s) => !memberIds.includes(s.student_id));
        setAvailableStudents(available);

        // Load grammar chapters
        const { data: chapters } = await supabase
          .from('grammar_chapters')
          .select('id, title, cefr_level, chapter_code')
          .eq('is_published', true)
          .order('cefr_level')
          .order('sort_order');
        setGrammarChapters(chapters || []);
      } catch (err) {
        console.error('Error loading cohort data:', err);
      } finally {
        setLoading(false);
      }
    };

    loadData();
  }, [cohortId, cohorts, getCohortProgress, getCohortAssignments, getTeacherStudents, getCohortMembers]);

  // Search words
  const handleWordSearch = async () => {
    if (!wordSearch.trim()) return;

    const { data } = await supabase
      .from('lexicon_entries')
      .select('id, headword, pos, cefr_receptive')
      .ilike('headword', `%${wordSearch}%`)
      .limit(20);

    setSearchResults(data || []);
  };

  // Add student
  const handleAddStudent = async () => {
    if (!selectedStudent || !cohortId) return;

    const success = await addStudentToCohort(cohortId, selectedStudent);
    if (success) {
      toast({ title: 'Student added', description: 'Student added to cohort successfully' });
      setIsAddStudentOpen(false);
      setSelectedStudent('');
      // Reload data
      window.location.reload();
    } else {
      toast({ title: 'Error', description: 'Failed to add student', variant: 'destructive' });
    }
  };

  // Remove student
  const handleRemoveStudent = async (studentId: string) => {
    if (!cohortId) return;

    const success = await removeStudentFromCohort(cohortId, studentId);
    if (success) {
      toast({ title: 'Student removed', description: 'Student removed from cohort' });
      window.location.reload();
    } else {
      toast({ title: 'Error', description: 'Failed to remove student', variant: 'destructive' });
    }
  };

  // Assign grammar
  const handleAssignGrammar = async () => {
    if (!selectedChapter || !cohortId) return;

    const assignment = await createAssignment('grammar', selectedChapter, {
      cohortId,
      dueDate: assignmentDueDate || undefined,
      notes: assignmentNotes || undefined,
    });

    if (assignment) {
      toast({ title: 'Assignment created', description: 'Grammar chapter assigned to cohort' });
      setIsAssignGrammarOpen(false);
      setSelectedChapter('');
      setAssignmentDueDate('');
      setAssignmentNotes('');
      window.location.reload();
    } else {
      toast({ title: 'Error', description: 'Failed to create assignment', variant: 'destructive' });
    }
  };

  // Add words to SRS
  const handleAddWordsToSRS = async () => {
    if (selectedWords.length === 0 || progress.length === 0) return;

    const studentIds = progress.map((p) => p.student_id);
    const success = await addWordsToStudentSRS(studentIds, selectedWords);

    if (success) {
      toast({
        title: 'Words added to SRS',
        description: `${selectedWords.length} words added to ${studentIds.length} students' review queue`,
      });
      setIsLiveClassOpen(false);
      setSelectedWords([]);
      setWordSearch('');
      setSearchResults([]);
    } else {
      toast({ title: 'Error', description: 'Failed to add words to SRS', variant: 'destructive' });
    }
  };

  // Update cohort
  const handleUpdateCohort = async () => {
    if (!cohortId) return;

    const success = await updateCohort(cohortId, {
      name: editName,
      description: editDescription,
    });

    if (success) {
      toast({ title: 'Cohort updated', description: 'Cohort details updated successfully' });
      setIsEditOpen(false);
      window.location.reload();
    } else {
      toast({ title: 'Error', description: 'Failed to update cohort', variant: 'destructive' });
    }
  };

  // Delete cohort
  const handleDeleteCohort = async () => {
    if (!cohortId) return;
    if (!confirm('Are you sure you want to delete this cohort? This cannot be undone.')) return;

    const success = await deleteCohort(cohortId);
    if (success) {
      toast({ title: 'Cohort deleted', description: 'Cohort has been deleted' });
      navigate('/teach/dashboard');
    } else {
      toast({ title: 'Error', description: 'Failed to delete cohort', variant: 'destructive' });
    }
  };

  if (loading || cohortsLoading) {
    return (
      <AppLayout title="Loading..." subtitle="">
        <div className="p-6 space-y-4">
          <Skeleton className="h-12 w-full" />
          <Skeleton className="h-64 w-full" />
        </div>
      </AppLayout>
    );
  }

  if (!cohort) {
    return (
      <AppLayout title="Not Found" subtitle="">
        <div className="p-6">
          <Card>
            <CardContent className="pt-6">
              <p>Cohort not found</p>
              <Button onClick={() => navigate('/teach/dashboard')} className="mt-4">
                Back to Dashboard
              </Button>
            </CardContent>
          </Card>
        </div>
      </AppLayout>
    );
  }

  return (
    <AppLayout title={cohort.name} subtitle={cohort.description || 'Cohort Management'}>
      <div className="p-6 space-y-6">
        {/* Header Actions */}
        <div className="flex items-center justify-between">
          <Button variant="ghost" onClick={() => navigate('/teach/dashboard')}>
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Dashboard
          </Button>
          <div className="flex gap-2">
            <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
              <DialogTrigger asChild>
                <Button variant="outline">Edit Cohort</Button>
              </DialogTrigger>
              <DialogContent>
                <DialogHeader>
                  <DialogTitle>Edit Cohort</DialogTitle>
                </DialogHeader>
                <div className="space-y-4 py-4">
                  <div className="space-y-2">
                    <Label>Name</Label>
                    <Input value={editName} onChange={(e) => setEditName(e.target.value)} />
                  </div>
                  <div className="space-y-2">
                    <Label>Description</Label>
                    <Textarea
                      value={editDescription}
                      onChange={(e) => setEditDescription(e.target.value)}
                      rows={3}
                    />
                  </div>
                </div>
                <DialogFooter>
                  <Button variant="outline" onClick={() => setIsEditOpen(false)}>
                    Cancel
                  </Button>
                  <Button onClick={handleUpdateCohort}>Save Changes</Button>
                </DialogFooter>
              </DialogContent>
            </Dialog>
            <Button variant="destructive" onClick={handleDeleteCohort}>
              <Trash2 className="h-4 w-4 mr-2" />
              Delete Cohort
            </Button>
          </div>
        </div>

        <Tabs defaultValue="progress" className="space-y-6">
          <TabsList>
            <TabsTrigger value="progress">
              <TrendingUp className="h-4 w-4 mr-2" />
              Progress
            </TabsTrigger>
            <TabsTrigger value="assignments">
              <BookOpen className="h-4 w-4 mr-2" />
              Assignments
            </TabsTrigger>
            <TabsTrigger value="live-class">
              <Brain className="h-4 w-4 mr-2" />
              Live Class
            </TabsTrigger>
          </TabsList>

          {/* Progress Tab */}
          <TabsContent value="progress" className="space-y-4">
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="flex items-center gap-2">
                    <Users className="h-5 w-5" />
                    Student Progress
                  </CardTitle>
                  <Dialog open={isAddStudentOpen} onOpenChange={setIsAddStudentOpen}>
                    <DialogTrigger asChild>
                      <Button size="sm">
                        <UserPlus className="h-4 w-4 mr-2" />
                        Add Student
                      </Button>
                    </DialogTrigger>
                    <DialogContent>
                      <DialogHeader>
                        <DialogTitle>Add Student to Cohort</DialogTitle>
                      </DialogHeader>
                      <div className="space-y-4 py-4">
                        <div className="space-y-2">
                          <Label>Select Student</Label>
                          <Select value={selectedStudent} onValueChange={setSelectedStudent}>
                            <SelectTrigger>
                              <SelectValue placeholder="Choose a student" />
                            </SelectTrigger>
                            <SelectContent>
                              {availableStudents.map((student) => (
                                <SelectItem key={student.student_id} value={student.student_id}>
                                  {student.full_name}
                                </SelectItem>
                              ))}
                            </SelectContent>
                          </Select>
                        </div>
                      </div>
                      <DialogFooter>
                        <Button variant="outline" onClick={() => setIsAddStudentOpen(false)}>
                          Cancel
                        </Button>
                        <Button onClick={handleAddStudent}>Add Student</Button>
                      </DialogFooter>
                    </DialogContent>
                  </Dialog>
                </div>
              </CardHeader>
              <CardContent>
                {progress.length === 0 ? (
                  <div className="text-center py-12">
                    <Users className="h-12 w-12 mx-auto text-muted-foreground mb-4" />
                    <p className="text-muted-foreground mb-4">No students in this cohort yet</p>
                    <Button onClick={() => setIsAddStudentOpen(true)}>
                      <UserPlus className="h-4 w-4 mr-2" />
                      Add First Student
                    </Button>
                  </div>
                ) : (
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>Student</TableHead>
                        <TableHead>Streak</TableHead>
                        <TableHead>Words</TableHead>
                        <TableHead>Lessons</TableHead>
                        <TableHead>Last Active</TableHead>
                        <TableHead>Assignments</TableHead>
                        <TableHead className="text-right">Actions</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {progress.map((student) => (
                        <TableRow key={student.student_id}>
                          <TableCell className="font-medium">{student.full_name}</TableCell>
                          <TableCell>
                            <div className="flex items-center gap-2">
                              <Flame className="h-4 w-4 text-orange-500" />
                              {student.current_streak}
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="flex items-center gap-2">
                              <Brain className="h-4 w-4 text-blue-500" />
                              {student.words_learned}
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="flex items-center gap-2">
                              <GraduationCap className="h-4 w-4 text-green-500" />
                              {student.lessons_completed}
                            </div>
                          </TableCell>
                          <TableCell className="text-sm text-muted-foreground">
                            {student.last_activity_date
                              ? new Date(student.last_activity_date).toLocaleDateString()
                              : 'Never'}
                          </TableCell>
                          <TableCell>
                            <div className="flex gap-2">
                              <Badge variant="outline">
                                <Clock className="h-3 w-3 mr-1" />
                                {student.pending_assignments}
                              </Badge>
                              <Badge variant="default">
                                <CheckCircle2 className="h-3 w-3 mr-1" />
                                {student.completed_assignments}
                              </Badge>
                            </div>
                          </TableCell>
                          <TableCell className="text-right">
                            <Button
                              variant="ghost"
                              size="sm"
                              onClick={() => handleRemoveStudent(student.student_id)}
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          {/* Assignments Tab */}
          <TabsContent value="assignments" className="space-y-4">
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="flex items-center gap-2">
                    <BookOpen className="h-5 w-5" />
                    Grammar Assignments
                  </CardTitle>
                  <Dialog open={isAssignGrammarOpen} onOpenChange={setIsAssignGrammarOpen}>
                    <DialogTrigger asChild>
                      <Button size="sm">
                        <Plus className="h-4 w-4 mr-2" />
                        Assign Grammar
                      </Button>
                    </DialogTrigger>
                    <DialogContent>
                      <DialogHeader>
                        <DialogTitle>Assign Grammar Chapter</DialogTitle>
                        <DialogDescription>
                          Select a grammar chapter to assign to this cohort
                        </DialogDescription>
                      </DialogHeader>
                      <div className="space-y-4 py-4">
                        <div className="space-y-2">
                          <Label>Grammar Chapter</Label>
                          <Select value={selectedChapter} onValueChange={setSelectedChapter}>
                            <SelectTrigger>
                              <SelectValue placeholder="Choose a chapter" />
                            </SelectTrigger>
                            <SelectContent>
                              {grammarChapters.map((chapter) => (
                                <SelectItem key={chapter.id} value={chapter.id}>
                                  [{chapter.cefr_level}] {chapter.title}
                                </SelectItem>
                              ))}
                            </SelectContent>
                          </Select>
                        </div>
                        <div className="space-y-2">
                          <Label>Due Date (Optional)</Label>
                          <Input
                            type="date"
                            value={assignmentDueDate}
                            onChange={(e) => setAssignmentDueDate(e.target.value)}
                          />
                        </div>
                        <div className="space-y-2">
                          <Label>Notes (Optional)</Label>
                          <Textarea
                            value={assignmentNotes}
                            onChange={(e) => setAssignmentNotes(e.target.value)}
                            rows={3}
                            placeholder="Add any notes for students..."
                          />
                        </div>
                      </div>
                      <DialogFooter>
                        <Button variant="outline" onClick={() => setIsAssignGrammarOpen(false)}>
                          Cancel
                        </Button>
                        <Button onClick={handleAssignGrammar}>Assign</Button>
                      </DialogFooter>
                    </DialogContent>
                  </Dialog>
                </div>
              </CardHeader>
              <CardContent>
                {assignments.length === 0 ? (
                  <div className="text-center py-12">
                    <BookOpen className="h-12 w-12 mx-auto text-muted-foreground mb-4" />
                    <p className="text-muted-foreground mb-4">No assignments yet</p>
                    <Button onClick={() => setIsAssignGrammarOpen(true)}>
                      <Plus className="h-4 w-4 mr-2" />
                      Create First Assignment
                    </Button>
                  </div>
                ) : (
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>Type</TableHead>
                        <TableHead>Content ID</TableHead>
                        <TableHead>Status</TableHead>
                        <TableHead>Due Date</TableHead>
                        <TableHead>Assigned</TableHead>
                        <TableHead className="text-right">Actions</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {assignments.map((assignment) => (
                        <TableRow key={assignment.id}>
                          <TableCell>
                            <Badge>{assignment.content_type}</Badge>
                          </TableCell>
                          <TableCell className="font-mono text-xs">
                            {assignment.content_id.slice(0, 8)}...
                          </TableCell>
                          <TableCell>
                            <Badge
                              variant={
                                assignment.status === 'completed'
                                  ? 'default'
                                  : assignment.status === 'in_progress'
                                  ? 'secondary'
                                  : 'outline'
                              }
                            >
                              {assignment.status}
                            </Badge>
                          </TableCell>
                          <TableCell className="text-sm">
                            {assignment.due_date
                              ? new Date(assignment.due_date).toLocaleDateString()
                              : '—'}
                          </TableCell>
                          <TableCell className="text-sm text-muted-foreground">
                            {new Date(assignment.assigned_at).toLocaleDateString()}
                          </TableCell>
                          <TableCell className="text-right">
                            <Button
                              variant="ghost"
                              size="sm"
                              onClick={() => deleteAssignment(assignment.id)}
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          {/* Live Class Tab */}
          <TabsContent value="live-class" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Brain className="h-5 w-5" />
                  Live Class SRS Trigger
                </CardTitle>
                <CardDescription>
                  Search for words covered in today's class and add them to students' SRS queue
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex gap-2">
                  <Input
                    placeholder="Search vocabulary..."
                    value={wordSearch}
                    onChange={(e) => setWordSearch(e.target.value)}
                    onKeyDown={(e) => e.key === 'Enter' && handleWordSearch()}
                  />
                  <Button onClick={handleWordSearch}>
                    <Search className="h-4 w-4 mr-2" />
                    Search
                  </Button>
                </div>

                {searchResults.length > 0 && (
                  <div className="border rounded-lg p-4 space-y-2">
                    <p className="text-sm font-medium">Search Results:</p>
                    <div className="space-y-2">
                      {searchResults.map((word) => (
                        <div
                          key={word.id}
                          className="flex items-center justify-between p-2 border rounded hover:bg-muted/50"
                        >
                          <div>
                            <span className="font-medium">{word.headword}</span>
                            <span className="text-sm text-muted-foreground ml-2">
                              ({word.pos}) [{word.cefr_receptive}]
                            </span>
                          </div>
                          <Button
                            size="sm"
                            variant={selectedWords.includes(word.id) ? 'default' : 'outline'}
                            onClick={() => {
                              if (selectedWords.includes(word.id)) {
                                setSelectedWords(selectedWords.filter((id) => id !== word.id));
                              } else {
                                setSelectedWords([...selectedWords, word.id]);
                              }
                            }}
                          >
                            {selectedWords.includes(word.id) ? 'Selected' : 'Select'}
                          </Button>
                        </div>
                      ))}
                    </div>
                  </div>
                )}

                {selectedWords.length > 0 && (
                  <div className="flex items-center justify-between p-4 bg-muted rounded-lg">
                    <p className="text-sm">
                      {selectedWords.length} word(s) selected for {progress.length} student(s)
                    </p>
                    <Button onClick={handleAddWordsToSRS}>
                      <Plus className="h-4 w-4 mr-2" />
                      Add to SRS
                    </Button>
                  </div>
                )}
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </AppLayout>
  );
}

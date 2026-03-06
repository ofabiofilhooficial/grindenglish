import { useState, useEffect, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { ArrowLeft, Users, BookOpen, Brain, Plus, Search, UserPlus, Trash2, CheckCircle, Clock } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';
import { useCohorts, CohortMember } from '@/hooks/useCohorts';
import { useAssignments } from '@/hooks/useAssignments';
import { toast } from '@/hooks/use-toast';

interface GrammarChapter {
  id: string;
  title: string;
  chapter_code: string;
  cefr_level: string;
}

interface LexiconEntry {
  id: string;
  headword: string;
  pos: string | null;
  cefr_receptive: string | null;
  definition_simple: string | null;
}

export default function CohortDetailPage() {
  const { cohortId } = useParams<{ cohortId: string }>();
  const navigate = useNavigate();
  const { user } = useAuth();
  const { fetchMembers, addMember, removeMember } = useCohorts();
  const { assignments, loading: assignLoading, fetchAssignments, createAssignment, deleteAssignment } = useAssignments();

  const [cohort, setCohort] = useState<any>(null);
  const [members, setMembers] = useState<CohortMember[]>([]);
  const [loading, setLoading] = useState(true);

  // Add member
  const [addStudentOpen, setAddStudentOpen] = useState(false);
  const [allLearners, setAllLearners] = useState<{ id: string; full_name: string | null }[]>([]);
  const [learnerSearch, setLearnerSearch] = useState('');

  // Assign grammar
  const [grammarChapters, setGrammarChapters] = useState<GrammarChapter[]>([]);
  const [selectedChapter, setSelectedChapter] = useState('');
  const [assignOpen, setAssignOpen] = useState(false);

  // SRS trigger
  const [srsOpen, setSrsOpen] = useState(false);
  const [lexSearch, setLexSearch] = useState('');
  const [lexResults, setLexResults] = useState<LexiconEntry[]>([]);
  const [selectedWords, setSelectedWords] = useState<string[]>([]);
  const [injecting, setInjecting] = useState(false);

  // Progress data
  const [progressData, setProgressData] = useState<any[]>([]);

  const loadCohort = useCallback(async () => {
    if (!cohortId) return;
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('cohorts')
        .select('*')
        .eq('id', cohortId)
        .single();
      if (error) throw error;
      setCohort(data);

      const mems = await fetchMembers(cohortId);
      setMembers(mems);

      await fetchAssignments({ cohort_id: cohortId });

      // Fetch progress via RPC
      const { data: prog } = await supabase.rpc('get_cohort_progress' as any, { _cohort_id: cohortId });
      setProgressData((prog as any[]) || []);
    } catch (err) {
      console.error('Error loading cohort:', err);
      toast({ title: 'Error', description: 'Failed to load cohort.', variant: 'destructive' });
    } finally {
      setLoading(false);
    }
  }, [cohortId, fetchMembers, fetchAssignments]);

  useEffect(() => { loadCohort(); }, [loadCohort]);

  // Fetch all learners for add-member dialog
  const loadLearners = useCallback(async () => {
    const { data } = await supabase.rpc('get_teacher_students' as any, { _teacher_id: user?.id });
    // Also get all profiles for adding new students
    const { data: profiles } = await supabase.from('profiles').select('id, full_name');
    setAllLearners((profiles || []) as any[]);
  }, [user]);

  useEffect(() => { if (addStudentOpen) loadLearners(); }, [addStudentOpen, loadLearners]);

  // Fetch grammar chapters for assignment
  const loadGrammarChapters = useCallback(async () => {
    const { data } = await supabase
      .from('grammar_chapters')
      .select('id, title, chapter_code, cefr_level')
      .eq('is_published', true)
      .order('sort_order');
    setGrammarChapters((data || []) as GrammarChapter[]);
  }, []);

  useEffect(() => { if (assignOpen) loadGrammarChapters(); }, [assignOpen, loadGrammarChapters]);

  // Search lexicon
  useEffect(() => {
    if (!srsOpen || lexSearch.length < 2) { setLexResults([]); return; }
    const timer = setTimeout(async () => {
      const { data } = await supabase
        .from('lexicon_entries')
        .select('id, headword, pos, cefr_receptive, definition_simple')
        .ilike('headword', `%${lexSearch}%`)
        .eq('is_published', true)
        .limit(20);
      setLexResults((data || []) as LexiconEntry[]);
    }, 300);
    return () => clearTimeout(timer);
  }, [lexSearch, srsOpen]);

  const handleAddMember = async (studentId: string) => {
    if (!cohortId) return;
    const ok = await addMember(cohortId, studentId);
    if (ok) {
      setAddStudentOpen(false);
      loadCohort();
    }
  };

  const handleRemoveMember = async (studentId: string) => {
    if (!cohortId) return;
    const ok = await removeMember(cohortId, studentId);
    if (ok) loadCohort();
  };

  const handleAssignGrammar = async () => {
    if (!selectedChapter || !cohortId) return;
    const result = await createAssignment({
      content_type: 'grammar',
      content_id: selectedChapter,
      cohort_id: cohortId,
    });
    if (result) {
      setAssignOpen(false);
      setSelectedChapter('');
      fetchAssignments({ cohort_id: cohortId });
    }
  };

  const toggleWord = (id: string) => {
    setSelectedWords(prev => prev.includes(id) ? prev.filter(w => w !== id) : [...prev, id]);
  };

  const handleInjectSRS = async () => {
    if (selectedWords.length === 0 || members.length === 0 || !user) return;
    setInjecting(true);
    try {
      const studentIds = members.map(m => m.student_id);
      const { data, error } = await supabase.rpc('teacher_add_words_to_srs' as any, {
        _student_ids: studentIds,
        _word_ids: selectedWords,
        _teacher_id: user.id,
      });
      if (error) throw error;
      toast({ title: 'Words injected', description: `${selectedWords.length} word(s) added to ${members.length} student(s)' SRS queue.` });
      setSelectedWords([]);
      setSrsOpen(false);
    } catch (err: any) {
      console.error('Error injecting SRS:', err);
      toast({ title: 'Error', description: err.message, variant: 'destructive' });
    } finally {
      setInjecting(false);
    }
  };

  const filteredLearners = allLearners.filter(l =>
    !members.some(m => m.student_id === l.id) &&
    (l.full_name || '').toLowerCase().includes(learnerSearch.toLowerCase())
  );

  if (loading) {
    return (
      <AppLayout title="Loading…" subtitle="">
        <div className="p-6 space-y-4">
          <Skeleton className="h-8 w-48" />
          <Skeleton className="h-64 w-full" />
        </div>
      </AppLayout>
    );
  }

  if (!cohort) {
    return (
      <AppLayout title="Not Found" subtitle="">
        <div className="p-6">
          <p className="text-muted-foreground">Cohort not found.</p>
          <Button variant="outline" onClick={() => navigate('/teach/dashboard')} className="mt-4">
            <ArrowLeft className="h-4 w-4 mr-2" /> Back
          </Button>
        </div>
      </AppLayout>
    );
  }

  return (
    <AppLayout title={cohort.name} subtitle={cohort.description || 'Cohort management'}>
      <div className="p-6 space-y-6">
        <Button variant="ghost" onClick={() => navigate('/teach/dashboard')} className="mb-2">
          <ArrowLeft className="h-4 w-4 mr-2" /> All Cohorts
        </Button>

        <Tabs defaultValue="members">
          <TabsList>
            <TabsTrigger value="members"><Users className="h-4 w-4 mr-1" /> Students</TabsTrigger>
            <TabsTrigger value="assignments"><BookOpen className="h-4 w-4 mr-1" /> Assignments</TabsTrigger>
            <TabsTrigger value="srs"><Brain className="h-4 w-4 mr-1" /> SRS Trigger</TabsTrigger>
          </TabsList>

          {/* MEMBERS TAB */}
          <TabsContent value="members" className="space-y-4 mt-4">
            <div className="flex items-center justify-between">
              <h3 className="font-display font-semibold text-lg">Students ({members.length})</h3>
              <Dialog open={addStudentOpen} onOpenChange={setAddStudentOpen}>
                <DialogTrigger asChild>
                  <Button size="sm"><UserPlus className="h-4 w-4 mr-2" /> Add Student</Button>
                </DialogTrigger>
                <DialogContent>
                  <DialogHeader><DialogTitle>Add Student to Cohort</DialogTitle></DialogHeader>
                  <Input placeholder="Search by name…" value={learnerSearch} onChange={e => setLearnerSearch(e.target.value)} />
                  <div className="max-h-60 overflow-y-auto space-y-1 mt-2">
                    {filteredLearners.length === 0 ? (
                      <p className="text-sm text-muted-foreground py-4 text-center">No students found.</p>
                    ) : filteredLearners.map(l => (
                      <Button key={l.id} variant="ghost" className="w-full justify-start" onClick={() => handleAddMember(l.id)}>
                        <UserPlus className="h-4 w-4 mr-2" /> {l.full_name || 'Unnamed'}
                      </Button>
                    ))}
                  </div>
                </DialogContent>
              </Dialog>
            </div>

            {members.length === 0 ? (
              <Card><CardContent className="p-8 text-center text-muted-foreground">No students in this cohort yet.</CardContent></Card>
            ) : (
              <div className="space-y-2">
                {members.map(m => (
                  <Card key={m.student_id}>
                    <CardContent className="flex items-center justify-between p-4">
                      <div>
                        <p className="font-medium">{m.full_name || 'Unnamed Student'}</p>
                        {progressData.find(p => p.student_id === m.student_id) && (
                          <p className="text-xs text-muted-foreground">
                            Streak: {progressData.find(p => p.student_id === m.student_id)?.current_streak || 0} days
                            · Words: {progressData.find(p => p.student_id === m.student_id)?.words_learned || 0}
                            · Lessons: {progressData.find(p => p.student_id === m.student_id)?.lessons_completed || 0}
                          </p>
                        )}
                      </div>
                      <Button variant="ghost" size="icon" onClick={() => handleRemoveMember(m.student_id)}>
                        <Trash2 className="h-4 w-4 text-muted-foreground" />
                      </Button>
                    </CardContent>
                  </Card>
                ))}
              </div>
            )}
          </TabsContent>

          {/* ASSIGNMENTS TAB */}
          <TabsContent value="assignments" className="space-y-4 mt-4">
            <div className="flex items-center justify-between">
              <h3 className="font-display font-semibold text-lg">Assignments</h3>
              <Dialog open={assignOpen} onOpenChange={setAssignOpen}>
                <DialogTrigger asChild>
                  <Button size="sm"><Plus className="h-4 w-4 mr-2" /> Assign Grammar</Button>
                </DialogTrigger>
                <DialogContent>
                  <DialogHeader><DialogTitle>Assign Grammar Chapter</DialogTitle></DialogHeader>
                  <Select value={selectedChapter} onValueChange={setSelectedChapter}>
                    <SelectTrigger><SelectValue placeholder="Select a chapter…" /></SelectTrigger>
                    <SelectContent>
                      {grammarChapters.map(ch => (
                        <SelectItem key={ch.id} value={ch.id}>
                          [{ch.cefr_level}] {ch.title}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  <Button onClick={handleAssignGrammar} disabled={!selectedChapter} className="w-full mt-2">
                    Assign to Cohort
                  </Button>
                </DialogContent>
              </Dialog>
            </div>

            {assignLoading ? (
              <Skeleton className="h-32 w-full" />
            ) : assignments.length === 0 ? (
              <Card><CardContent className="p-8 text-center text-muted-foreground">No assignments yet.</CardContent></Card>
            ) : (
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Type</TableHead>
                    <TableHead>Status</TableHead>
                    <TableHead>Assigned</TableHead>
                    <TableHead></TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {assignments.map(a => (
                    <TableRow key={a.id}>
                      <TableCell>
                        <Badge variant="outline" className="capitalize">{a.content_type}</Badge>
                      </TableCell>
                      <TableCell>
                        {a.status === 'completed' ? (
                          <Badge className="bg-green-100 text-green-800"><CheckCircle className="h-3 w-3 mr-1" /> Completed</Badge>
                        ) : (
                          <Badge variant="secondary"><Clock className="h-3 w-3 mr-1" /> {a.status}</Badge>
                        )}
                      </TableCell>
                      <TableCell className="text-sm text-muted-foreground">
                        {new Date(a.assigned_at).toLocaleDateString()}
                      </TableCell>
                      <TableCell>
                        <Button variant="ghost" size="icon" onClick={() => { deleteAssignment(a.id); fetchAssignments({ cohort_id: cohortId }); }}>
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            )}
          </TabsContent>

          {/* SRS TRIGGER TAB */}
          <TabsContent value="srs" className="space-y-4 mt-4">
            <Card>
              <CardHeader>
                <CardTitle className="text-lg font-display flex items-center gap-2">
                  <Brain className="h-5 w-5" /> Live Class SRS Trigger
                </CardTitle>
                <CardDescription>
                  Search the lexicon for words covered in today's class. Selected words will be injected into all cohort students' SRS queues.
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="relative">
                  <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                  <Input
                    className="pl-10"
                    placeholder="Search A1 vocabulary…"
                    value={lexSearch}
                    onChange={e => setLexSearch(e.target.value)}
                  />
                </div>

                {lexResults.length > 0 && (
                  <div className="border rounded-md max-h-60 overflow-y-auto">
                    {lexResults.map(entry => (
                      <div
                        key={entry.id}
                        className={`flex items-center justify-between p-3 cursor-pointer hover:bg-muted/50 border-b last:border-b-0 ${selectedWords.includes(entry.id) ? 'bg-primary/5' : ''}`}
                        onClick={() => toggleWord(entry.id)}
                      >
                        <div>
                          <span className="font-medium">{entry.headword}</span>
                          {entry.pos && <Badge variant="outline" className="ml-2 text-xs">{entry.pos}</Badge>}
                          {entry.cefr_receptive && <Badge variant="secondary" className="ml-1 text-xs">{entry.cefr_receptive}</Badge>}
                          {entry.definition_simple && <p className="text-xs text-muted-foreground mt-0.5">{entry.definition_simple}</p>}
                        </div>
                        {selectedWords.includes(entry.id) && <CheckCircle className="h-5 w-5 text-primary shrink-0" />}
                      </div>
                    ))}
                  </div>
                )}

                {selectedWords.length > 0 && (
                  <div className="flex items-center justify-between p-3 bg-muted rounded-md">
                    <p className="text-sm">
                      <strong>{selectedWords.length}</strong> word(s) selected → <strong>{members.length}</strong> student(s)
                    </p>
                    <Button onClick={handleInjectSRS} disabled={injecting}>
                      {injecting ? 'Injecting…' : 'Inject into SRS'}
                    </Button>
                  </div>
                )}

                {members.length === 0 && (
                  <p className="text-sm text-muted-foreground text-center py-4">
                    Add students to this cohort first before triggering SRS.
                  </p>
                )}
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </AppLayout>
  );
}

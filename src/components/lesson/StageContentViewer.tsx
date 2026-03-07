import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { VocabularyPractice } from './VocabularyPractice';
import { 
  Target, 
  Lightbulb, 
  CheckCircle2, 
  AlertCircle,
  MessageSquare,
  BookOpen,
  Volume2,
  Users,
  Clock
} from 'lucide-react';

interface StageContentViewerProps {
  stage: any; // The lesson_stage object with content JSONB
  lessonId?: string;
  onStageComplete?: () => void;
}

export function StageContentViewer({ stage, lessonId, onStageComplete }: StageContentViewerProps) {
  const content = stage.content || {};

  // Special handling for Stage 0 (Retrieval) - Interactive vocabulary practice
  if (stage.stage_type === 'warm_up' && content.prompts && lessonId) {
    const vocabularyItems = [
      { id: '1', prompt: 'Oi', expected: ['hi', 'hello'], headword: 'hi' },
      { id: '2', prompt: 'Bom dia', expected: ['good morning'], headword: 'good morning' },
      { id: '3', prompt: 'Boa tarde', expected: ['good afternoon'], headword: 'good afternoon' },
    ];

    return (
      <div className="space-y-4">
        {content.objective && (
          <Alert className="border-primary/20 bg-primary/5">
            <Target className="h-4 w-4 text-primary" />
            <AlertDescription className="text-sm">
              <span className="font-semibold">Objective: </span>
              {content.objective}
            </AlertDescription>
          </Alert>
        )}

        <VocabularyPractice 
          items={vocabularyItems}
          onComplete={onStageComplete || (() => {})}
          lessonId={lessonId}
        />

        {content.student_action && (
          <Alert>
            <Lightbulb className="h-4 w-4" />
            <AlertDescription className="text-sm">
              {content.student_action}
            </AlertDescription>
          </Alert>
        )}
      </div>
    );
  }

  // If no structured content, show instructions only
  if (!content || Object.keys(content).length === 0) {
    return (
      <Card>
        <CardContent className="p-6">
          {stage.instructions ? (
            <div className="prose prose-sm max-w-none">
              <p className="text-foreground whitespace-pre-wrap">{stage.instructions}</p>
            </div>
          ) : (
            <p className="text-muted-foreground text-center py-8">
              No content defined for this stage yet.
            </p>
          )}
        </CardContent>
      </Card>
    );
  }

  return (
    <div className="space-y-4">
      {/* Objective */}
      {content.objective && (
        <Alert className="border-primary/20 bg-primary/5">
          <Target className="h-4 w-4 text-primary" />
          <AlertDescription className="text-sm">
            <span className="font-semibold">Objective: </span>
            {content.objective}
          </AlertDescription>
        </Alert>
      )}

      {/* Main Content Card */}
      <Card>
        <CardContent className="p-6 space-y-6">
          {/* Task */}
          {content.task && (
            <div>
              <h3 className="font-semibold text-sm mb-2 flex items-center gap-2">
                <CheckCircle2 className="h-4 w-4 text-primary" />
                Your Task
              </h3>
              <p className="text-sm text-muted-foreground">{content.task}</p>
            </div>
          )}

          {/* Prompts */}
          {content.prompts && content.prompts.length > 0 && (
            <div>
              <h3 className="font-semibold text-sm mb-2">Try These:</h3>
              <div className="space-y-2">
                {content.prompts.map((prompt: string, idx: number) => (
                  <div key={idx} className="flex items-center gap-2 p-2 rounded bg-secondary/50">
                    <span className="text-sm font-mono">{prompt}</span>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Scenario */}
          {content.scenario && (
            <div className="border-l-4 border-primary pl-4 py-2 bg-primary/5 rounded-r">
              <h3 className="font-semibold text-sm mb-2 flex items-center gap-2">
                <MessageSquare className="h-4 w-4" />
                Scenario
              </h3>
              {typeof content.scenario === 'string' ? (
                <p className="text-sm text-muted-foreground">{content.scenario}</p>
              ) : (
                <div className="space-y-2 text-sm">
                  {content.scenario.context && <p><span className="font-medium">Context:</span> {content.scenario.context}</p>}
                  {content.scenario.situation && <p><span className="font-medium">Situation:</span> {content.scenario.situation}</p>}
                  {content.scenario.your_task && <p><span className="font-medium">Your Task:</span> {content.scenario.your_task}</p>}
                </div>
              )}
            </div>
          )}

          {/* Diagnostic Task */}
          {content.diagnostic_task && (
            <Alert>
              <AlertCircle className="h-4 w-4" />
              <AlertDescription className="text-sm">
                <span className="font-semibold">Try it now: </span>
                {content.diagnostic_task}
              </AlertDescription>
            </Alert>
          )}

          {/* Key Teaching Point */}
          {content.key_teaching_point && (
            <div className="bg-accent/10 border border-accent/20 rounded-lg p-4">
              <h3 className="font-semibold text-sm mb-2 flex items-center gap-2 text-accent">
                <Lightbulb className="h-4 w-4" />
                Key Point
              </h3>
              <p className="text-sm">{content.key_teaching_point}</p>
            </div>
          )}

          {/* Grammar Focus */}
          {content.grammar_focus && (
            <div>
              <h3 className="font-semibold text-sm mb-3 flex items-center gap-2">
                <BookOpen className="h-4 w-4 text-primary" />
                Grammar Focus
              </h3>
              <div className="space-y-3 pl-6">
                {content.grammar_focus.structure && (
                  <div>
                    <p className="text-xs font-semibold text-muted-foreground mb-1">Structure:</p>
                    <p className="text-sm font-mono bg-secondary/50 p-2 rounded">{content.grammar_focus.structure}</p>
                  </div>
                )}
                {content.grammar_focus.examples && content.grammar_focus.examples.length > 0 && (
                  <div>
                    <p className="text-xs font-semibold text-muted-foreground mb-1">Examples:</p>
                    <ul className="space-y-1">
                      {content.grammar_focus.examples.map((ex: string, idx: number) => (
                        <li key={idx} className="text-sm flex items-start gap-2">
                          <span className="text-primary">•</span>
                          <span>{ex}</span>
                        </li>
                      ))}
                    </ul>
                  </div>
                )}
                {content.grammar_focus.why_not && (
                  <div className="bg-destructive/5 border border-destructive/20 rounded p-3">
                    <p className="text-xs font-semibold text-destructive mb-1">❌ Avoid:</p>
                    <p className="text-sm">{content.grammar_focus.why_not.avoid}</p>
                    <p className="text-xs text-muted-foreground mt-1">
                      <span className="font-semibold">Why:</span> {content.grammar_focus.why_not.reason}
                    </p>
                  </div>
                )}
              </div>
            </div>
          )}

          {/* Vocabulary Focus */}
          {content.vocabulary_focus && (
            <div>
              <h3 className="font-semibold text-sm mb-3 flex items-center gap-2">
                <BookOpen className="h-4 w-4 text-accent" />
                Vocabulary Focus
              </h3>
              <div className="space-y-4 pl-6">
                {content.vocabulary_focus.greetings && (
                  <div>
                    <p className="text-xs font-semibold text-muted-foreground mb-2">Greetings:</p>
                    <div className="grid gap-2">
                      {content.vocabulary_focus.greetings.map((item: any, idx: number) => (
                        <div key={idx} className="flex items-start gap-3 p-2 rounded bg-secondary/30">
                          <span className="font-medium text-sm min-w-[100px]">{item.word}</span>
                          <span className="text-sm text-muted-foreground">{item.use}</span>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
                {content.vocabulary_focus.name_vocabulary && (
                  <div>
                    <p className="text-xs font-semibold text-muted-foreground mb-2">Name Vocabulary:</p>
                    <div className="grid gap-2">
                      {content.vocabulary_focus.name_vocabulary.map((item: any, idx: number) => (
                        <div key={idx} className="flex items-start gap-3 p-2 rounded bg-secondary/30">
                          <span className="font-medium text-sm min-w-[100px]">{item.term}</span>
                          <span className="text-sm text-muted-foreground">Example: {item.example}</span>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            </div>
          )}

          {/* Pronunciation Focus */}
          {content.pronunciation_focus && (
            <div className="bg-purple-50 dark:bg-purple-950/20 border border-purple-200 dark:border-purple-800 rounded-lg p-4">
              <h3 className="font-semibold text-sm mb-3 flex items-center gap-2 text-purple-700 dark:text-purple-300">
                <Volume2 className="h-4 w-4" />
                Pronunciation Focus
              </h3>
              <div className="space-y-2 text-sm">
                {content.pronunciation_focus.key_issue && (
                  <p><span className="font-semibold">Issue:</span> {content.pronunciation_focus.key_issue}</p>
                )}
                {content.pronunciation_focus.wrong && (
                  <p className="text-destructive">❌ Wrong: {content.pronunciation_focus.wrong}</p>
                )}
                {content.pronunciation_focus.right && (
                  <p className="text-success">✅ Right: {content.pronunciation_focus.right}</p>
                )}
                {content.pronunciation_focus.practice_words && (
                  <div>
                    <p className="font-semibold mb-1">Practice these words:</p>
                    <div className="flex flex-wrap gap-2">
                      {content.pronunciation_focus.practice_words.map((word: string, idx: number) => (
                        <Badge key={idx} variant="outline">{word}</Badge>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            </div>
          )}

          {/* Pragmatics */}
          {content.pragmatics && (
            <div className="bg-blue-50 dark:bg-blue-950/20 border border-blue-200 dark:border-blue-800 rounded-lg p-4">
              <h3 className="font-semibold text-sm mb-2 flex items-center gap-2 text-blue-700 dark:text-blue-300">
                <Users className="h-4 w-4" />
                Cultural Note
              </h3>
              <div className="space-y-2 text-sm">
                {content.pragmatics.cultural_note && <p>{content.pragmatics.cultural_note}</p>}
                {content.pragmatics.professional_formula && (
                  <p className="font-mono bg-blue-100 dark:bg-blue-900/30 p-2 rounded">
                    {content.pragmatics.professional_formula}
                  </p>
                )}
              </div>
            </div>
          )}

          {/* Drill Items */}
          {content.drill_items && content.drill_items.length > 0 && (
            <div>
              <h3 className="font-semibold text-sm mb-3">Practice Drill:</h3>
              <div className="space-y-2">
                {content.drill_items.map((item: any, idx: number) => (
                  <div key={idx} className="flex items-center justify-between p-3 rounded bg-secondary/50 border">
                    <div className="flex items-center gap-3">
                      <Clock className="h-4 w-4 text-muted-foreground" />
                      <span className="font-medium">{item.time}</span>
                    </div>
                    <span className="text-sm text-muted-foreground">→ {item.expected}</span>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Situations (for communicative tasks) */}
          {content.situations && content.situations.length > 0 && (
            <div>
              <h3 className="font-semibold text-sm mb-3">Situations:</h3>
              <div className="space-y-4">
                {content.situations.map((situation: any, idx: number) => (
                  <Card key={idx} className="border-2">
                    <CardHeader className="pb-3">
                      <CardTitle className="text-base flex items-center justify-between">
                        <span>{situation.room}</span>
                        <Badge variant="outline">{situation.time}</Badge>
                      </CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-2 text-sm">
                      <p><span className="font-semibold">Context:</span> {situation.context}</p>
                      <p><span className="font-semibold">Formality:</span> {situation.formality}</p>
                      <p><span className="font-semibold">Your Task:</span> {situation.your_task}</p>
                      <div className="bg-primary/5 border border-primary/20 rounded p-2 mt-2">
                        <p className="text-xs font-semibold text-primary mb-1">Expected Language:</p>
                        <p className="font-mono text-sm">{situation.expected_language}</p>
                      </div>
                    </CardContent>
                  </Card>
                ))}
              </div>
            </div>
          )}

          {/* Success Criteria */}
          {content.success_criteria && (
            <div className="bg-success/5 border border-success/20 rounded-lg p-4">
              <h3 className="font-semibold text-sm mb-2 text-success">Success Criteria:</h3>
              {Array.isArray(content.success_criteria) ? (
                <ul className="space-y-1">
                  {content.success_criteria.map((criterion: string, idx: number) => (
                    <li key={idx} className="text-sm flex items-start gap-2">
                      <CheckCircle2 className="h-4 w-4 text-success mt-0.5 flex-shrink-0" />
                      <span>{criterion}</span>
                    </li>
                  ))}
                </ul>
              ) : (
                <p className="text-sm">{content.success_criteria}</p>
              )}
            </div>
          )}

          {/* Student Action */}
          {content.student_action && (
            <Alert className="border-primary/30 bg-primary/5">
              <CheckCircle2 className="h-4 w-4 text-primary" />
              <AlertDescription className="text-sm">
                <span className="font-semibold">What to do: </span>
                {content.student_action}
              </AlertDescription>
            </Alert>
          )}

          {/* Self Study Instructions */}
          {content.self_study_instructions && (
            <Alert>
              <Lightbulb className="h-4 w-4" />
              <AlertDescription className="text-sm">
                <span className="font-semibold">Self-Study Tip: </span>
                {content.self_study_instructions}
              </AlertDescription>
            </Alert>
          )}

          {/* Reflection Questions */}
          {content.reflection_questions && content.reflection_questions.length > 0 && (
            <div>
              <h3 className="font-semibold text-sm mb-2">Reflect:</h3>
              <ul className="space-y-2">
                {content.reflection_questions.map((question: string, idx: number) => (
                  <li key={idx} className="text-sm text-muted-foreground flex items-start gap-2">
                    <span className="text-primary">•</span>
                    <span>{question}</span>
                  </li>
                ))}
              </ul>
            </div>
          )}

          {/* Feedback Framework */}
          {content.feedback_framework && (
            <div className="space-y-3">
              <h3 className="font-semibold text-sm mb-2">Feedback Framework:</h3>
              {content.feedback_framework.strength && (
                <div className="flex items-start gap-2 p-2 rounded bg-success/10">
                  <span className="text-success font-semibold text-sm">💪 Strength:</span>
                  <span className="text-sm">{content.feedback_framework.strength}</span>
                </div>
              )}
              {content.feedback_framework.fix && (
                <div className="flex items-start gap-2 p-2 rounded bg-warning/10">
                  <span className="text-warning font-semibold text-sm">🔧 Fix:</span>
                  <span className="text-sm">{content.feedback_framework.fix}</span>
                </div>
              )}
              {content.feedback_framework.upgrade && (
                <div className="flex items-start gap-2 p-2 rounded bg-primary/10">
                  <span className="text-primary font-semibold text-sm">⬆️ Upgrade:</span>
                  <span className="text-sm">{content.feedback_framework.upgrade}</span>
                </div>
              )}
            </div>
          )}

          {/* Next Steps */}
          {content.next_steps && content.next_steps.length > 0 && (
            <div>
              <h3 className="font-semibold text-sm mb-2">Next Steps:</h3>
              <ul className="space-y-1">
                {content.next_steps.map((step: string, idx: number) => (
                  <li key={idx} className="text-sm flex items-start gap-2">
                    <span className="text-primary">→</span>
                    <span>{step}</span>
                  </li>
                ))}
              </ul>
            </div>
          )}
        </CardContent>
      </Card>

      {/* Teacher Notes - Hidden from students */}
      {false && content.teacher_notes && (
        <Alert className="border-muted bg-muted/30">
          <AlertDescription className="text-xs text-muted-foreground">
            <span className="font-semibold">Teacher Notes: </span>
            {content.teacher_notes}
          </AlertDescription>
        </Alert>
      )}
    </div>
  );
}

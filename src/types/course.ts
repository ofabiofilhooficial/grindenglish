// English Mastery Lab - Core Data Types
// Based on CEFR levels A0-C2 with Professional/Academic overlays

export type CEFRLevel = 'A0' | 'A1' | 'A2' | 'B1' | 'B2' | 'C1' | 'C2';

export type TrackType = 'core' | 'professional' | 'academic' | 'elective';

export type SkillType = 
  | 'listening' 
  | 'reading' 
  | 'speaking' 
  | 'writing' 
  | 'grammar' 
  | 'vocabulary' 
  | 'pronunciation' 
  | 'pragmatics'
  | 'mediation'
  | 'fluency';

export type LessonType = 
  | 'listening'
  | 'reading'
  | 'grammar'
  | 'vocabulary'
  | 'pronunciation'
  | 'speaking'
  | 'writing'
  | 'fluency'
  | 'mediation'
  | 'integrated';

export type AssetType = 'audio' | 'video' | 'pdf' | 'image' | 'transcript';

export type SubmissionType = 'speaking' | 'writing' | 'reflection';

export type UserRole = 'admin' | 'curriculum_designer' | 'teacher' | 'learner' | 'reviewer';

// ============ COURSE STRUCTURE ============

export interface Course {
  id: string;
  title: string;
  description: string;
  levels: Level[];
  createdAt: Date;
  updatedAt: Date;
  publishedAt?: Date;
  status: 'draft' | 'published' | 'archived';
}

export interface Level {
  id: string;
  courseId: string;
  cefrLevel: CEFRLevel;
  title: string;
  description: string;
  objectives: string[];
  units: Unit[];
  order: number;
  estimatedHours: number;
  color: string;
}

export interface Unit {
  id: string;
  levelId: string;
  title: string;
  theme: string;
  flagshipTask: string;
  secondaryTasks: string[];
  outcomes: UnitOutcomes;
  vocabularyTargets: string[]; // Lexicon entry IDs
  grammarTargets: string[]; // GRB chapter IDs
  pronunciationTargets: PronunciationTarget[];
  pragmaticsTargets: PragmaticsTarget;
  lessons: Lesson[];
  inputAssets: Asset[];
  deliverables: UnitDeliverables;
  recyclingPlan: RecyclingPlan;
  track: TrackType;
  order: number;
  status: 'draft' | 'published';
  estimatedMinutes: number;
}

export interface UnitOutcomes {
  listening: string[];
  reading: string[];
  speaking: string[];
  writing: string[];
  grammar: string[];
  vocabulary: string[];
  pronunciation: string[];
  pragmatics: string[];
}

export interface UnitDeliverables {
  speakingArtifact: DeliverableSpec;
  writingArtifact: DeliverableSpec;
  reflection: DeliverableSpec;
  vocabLogSnippet?: DeliverableSpec;
}

export interface DeliverableSpec {
  title: string;
  description: string;
  rubricId?: string;
  checklist: string[];
}

export interface RecyclingPlan {
  vocabularyItems: string[]; // Lexicon entry IDs
  grammarPatterns: string[]; // GRB chapter IDs
  pronunciationTargets: string[];
  pragmaticsItems: string[];
}

// ============ LESSONS ============

export interface Lesson {
  id: string;
  unitId: string;
  type: LessonType;
  title: string;
  goal: string;
  successCriteria: string[];
  recycledLanguage: string[];
  newLanguage: string[];
  stages: LessonStage[];
  interactionPattern: 'solo' | 'pair' | 'group' | 'async';
  feedbackFocus: string[];
  homework: HomeworkSpec;
  supportTrack?: string;
  challengeTrack?: string;
  order: number;
  estimatedMinutes: number;
  status: 'draft' | 'published';
  assets?: LessonAsset[]; // Linked grammar chapters, vocabulary, etc.
}

export interface LessonAsset {
  id: string;
  lessonId: string;
  stageId?: string; // Optional: if provided, asset is linked to a specific stage
  assetType: 'grammar' | 'vocabulary' | 'pronunciation' | 'pragmatics';
  assetId: string; // UUID of the grammar_chapter or lexicon_entry
  orderIndex: number;
  isRequired: boolean;
  contextNote?: string;
  // Populated data (when fetched with joins)
  grammarChapter?: GrammarChapter;
  lexiconEntry?: LexiconEntry;
}

export interface LessonStage {
  id: string;
  lessonId: string;
  type: StageType;
  title: string;
  instructions: string;
  content: StageContent;
  timing: number; // minutes
  order: number;
}

export type StageType = 
  | 'retrieval_warmup'
  | 'lead_in'
  | 'input'
  | 'comprehension'
  | 'noticing'
  | 'focus_practice'
  | 'communicative_use'
  | 'feedback_upgrade'
  | 'assignment'
  | 'reflection';

export interface StageContent {
  type: 'text' | 'audio' | 'video' | 'interactive' | 'recording' | 'writing';
  assets?: Asset[];
  transcript?: string;
  tasks?: InteractiveTask[];
  writingPrompt?: string;
  speakingPrompt?: string;
}

export interface InteractiveTask {
  id: string;
  type: 'mcq' | 'ordering' | 'matching' | 'cloze' | 'short_answer' | 'highlight' | 'annotate';
  question: string;
  options?: string[];
  correctAnswer?: string | string[];
  feedback?: string;
}

export interface HomeworkSpec {
  retrieval: string;
  input: string;
  output: string;
}

// ============ ASSETS ============

export interface Asset {
  id: string;
  type: AssetType;
  title: string;
  url: string;
  duration?: number; // seconds for audio/video
  transcript?: string;
  metadata: AssetMetadata;
  tags: string[];
  createdAt: Date;
}

export interface AssetMetadata {
  cefrLevel?: CEFRLevel;
  skill?: SkillType;
  unitId?: string;
  grammarIds?: string[];
  lexiconIds?: string[];
  pronunciationTargets?: string[];
  speechActs?: string[];
  medium?: string;
  register?: string;
}

// ============ LEXICON (VOCABULARY) ============

export type LexiconEntryType = 'lemma' | 'sense' | 'phrase' | 'collocation' | 'discourse_marker' | 'routine';

export interface LexiconEntry {
  id: string;
  headword: string;
  type: LexiconEntryType;
  partOfSpeech: string;
  cefrReceptive: CEFRLevel;
  cefrProductive: CEFRLevel;
  ipa: string;
  stress: string;
  definitionSimple: string;
  definitionTeacher: string;
  usageNotes: string;
  register: 'informal' | 'neutral' | 'formal';
  variety: 'us' | 'uk' | 'international';
  examples: string[];
  collocations: string[]; // Other entry IDs
  patterns: string[];
  topicTags: string[];
  unitTags: string[];
  overlayTags: TrackType[];
  frequencyBand: 1 | 2 | 3 | 4 | 5;
  audioUrl?: string;
  introducedInUnit?: string;
  recycledInUnits: string[];
}

// ============ GRAMMAR REFERENCE BOOK ============

export interface GrammarChapter {
  id: string; // e.g., "B1.G.01"
  cefrLevel: CEFRLevel;
  title: string;
  
  // The 9-Section Pedagogical Sequence (all optional for graceful degradation)
  diagnosticHook?: string; // Optional. A brief scenario or "Notice the Gap" challenge
  meaning: string; // Core concept explained simply
  form: string; // The syntax/structure
  use: string; // Pragmatic application in corporate/professional environment
  contrast: string; // L1 Contrast (pt-BR) - explicit comparison to Brazilian Portuguese
  commonErrors: string[]; // "Don't say X, Say Y" format
  taskUpgrades?: string; // Basic vs. Professional phrases (side-by-side comparison)
  microPractice: InteractiveTask[]; // Small interactive block or short controlled drill
  crossLinks: string[]; // Prerequisites and upcoming chapters (B1.G.16, etc.)
  
  order: number;
}

// ============ PRONUNCIATION ============

export type PronunciationCategory = 
  | 'segmentals'
  | 'word_stress'
  | 'sentence_stress'
  | 'rhythm'
  | 'connected_speech'
  | 'intonation'
  | 'fluency_mechanics';

export interface PronunciationTarget {
  id: string;
  category: PronunciationCategory;
  name: string;
  description: string;
  priority: number;
}

export interface ShadowingScript {
  id: string;
  type: 'micro' | 'chunk' | 'dialogue' | 'monologue';
  text: string;
  chunkedVersion: string;
  stressMarkedVersion: string;
  focusTags: string[];
  unitTags: string[];
  speedPlan: string;
  audioUrl: string;
  duration: number;
}

export interface SoundMap {
  id: string;
  learnerId: string;
  topTargets: PronunciationTarget[];
  practiceModes: string[];
  assignedPlaylists: ShadowingScript[];
  weeklyRoutine: string;
  selfMonitoringChecklist: string[];
}

// ============ PRAGMATICS/CULTURE ============

export type SpeechActType = 
  | 'requests'
  | 'refusals'
  | 'apologies'
  | 'complaints'
  | 'disagreement'
  | 'feedback'
  | 'negotiation'
  | 'boundaries';

export interface PragmaticsPack {
  id: string;
  speechAct: SpeechActType;
  title: string;
  description: string;
  registerLadder: RegisterLevel[];
  mediumGuides: MediumGuide[];
  items: PragmaticsItem[];
}

export interface RegisterLevel {
  level: 'direct' | 'softened' | 'formal';
  examples: string[];
  notes: string;
}

export interface MediumGuide {
  medium: 'email' | 'chat' | 'phone' | 'meeting' | 'seminar';
  conventions: string[];
  examples: string[];
}

export interface PragmaticsItem {
  id: string;
  phrase: string;
  register: 'direct' | 'softened' | 'formal';
  context: string;
  appropriateFor: string[];
  avoidWhen: string[];
}

export interface InterculturalCaseStudy {
  id: string;
  title: string;
  scenario: string;
  interpretations: string[];
  reflectionQuestions: string[];
  rolePlayTasks: string[];
  cefrLevel: CEFRLevel;
}

export interface PragmaticsTarget {
  speechActFocus: SpeechActType;
  registerTarget: 'direct' | 'softened' | 'formal';
  medium: 'email' | 'chat' | 'phone' | 'meeting' | 'seminar';
  interactionSkill: string;
  repairStrategy: string;
  interculturalNote: string;
}

// ============ USER & ENROLLMENT ============

export interface User {
  id: string;
  email: string;
  name: string;
  avatarUrl?: string;
  role: UserRole;
  organizationId?: string;
  preferences: UserPreferences;
  createdAt: Date;
}

export interface UserPreferences {
  timezone: string;
  language: string;
  notificationsEnabled: boolean;
  recordingConsent: boolean;
}

export interface Organization {
  id: string;
  name: string;
  logoUrl?: string;
  settings: OrganizationSettings;
  createdAt: Date;
}

export interface OrganizationSettings {
  allowSelfPaced: boolean;
  requireCohorts: boolean;
  dataRetentionDays: number;
}

export interface Enrollment {
  id: string;
  userId: string;
  courseId: string;
  cohortId?: string;
  currentLevelId: string;
  currentUnitId: string;
  startedAt: Date;
  completedAt?: Date;
  mode: 'self_paced' | 'cohort';
}

export interface Cohort {
  id: string;
  name: string;
  courseId: string;
  teacherId: string;
  schedule: CohortSchedule;
  enrollments: Enrollment[];
  startDate: Date;
  endDate: Date;
}

export interface CohortSchedule {
  timezone: string;
  liveSessions: LiveSession[];
  dueDates: DueDate[];
}

export interface LiveSession {
  id: string;
  title: string;
  dateTime: Date;
  duration: number;
  meetingLink: string;
}

export interface DueDate {
  unitId: string;
  lessonId?: string;
  deadline: Date;
}

// ============ SUBMISSIONS & FEEDBACK ============

export interface Submission {
  id: string;
  type: SubmissionType;
  userId: string;
  unitId: string;
  lessonId?: string;
  status: 'draft' | 'submitted' | 'reviewed' | 'revised';
  content: SubmissionContent;
  files: SubmissionFile[];
  feedback: FeedbackComment[];
  submittedAt?: Date;
  reviewedAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

export interface SubmissionContent {
  text?: string;
  audioUrl?: string;
  videoUrl?: string;
  revisionHistory?: RevisionEntry[];
}

export interface RevisionEntry {
  content: string;
  timestamp: Date;
  note?: string;
}

export interface SubmissionFile {
  id: string;
  name: string;
  url: string;
  type: string;
  size: number;
  uploadedAt: Date;
}

export interface FeedbackComment {
  id: string;
  authorId: string;
  content: string;
  timestamp?: number; // For audio/video
  code?: string; // Feedback code
  upgradeLinks?: string[]; // Lexicon/GRB/PCI IDs
  createdAt: Date;
}

// ============ SRS (SPACED REPETITION) ============

export interface SRSDeck {
  id: string;
  userId: string;
  unitId?: string;
  type: 'vocabulary' | 'grammar' | 'pronunciation' | 'pragmatics' | 'mixed';
  cards: SRSCard[];
  createdAt: Date;
}

export interface SRSCard {
  id: string;
  deckId: string;
  front: string;
  back: string;
  linkedEntryId?: string;
  linkedEntryType?: 'lexicon' | 'grammar' | 'pragmatics';
  interval: number;
  easeFactor: number;
  dueDate: Date;
  reviewCount: number;
  lastReviewedAt?: Date;
}

export interface SRSReview {
  id: string;
  cardId: string;
  userId: string;
  rating: 1 | 2 | 3 | 4 | 5;
  responseTime: number;
  reviewedAt: Date;
}

// ============ PROGRESS & ANALYTICS ============

export interface ProgressEvent {
  id: string;
  userId: string;
  verb: 'started' | 'completed' | 'submitted' | 'reviewed' | 'practiced';
  objectType: 'lesson' | 'unit' | 'level' | 'srs_review' | 'submission';
  objectId: string;
  duration?: number;
  score?: number;
  metadata?: Record<string, unknown>;
  timestamp: Date;
}

export interface LearnerProgress {
  userId: string;
  courseId: string;
  currentStreak: number;
  longestStreak: number;
  totalTimeMinutes: number;
  lessonsCompleted: number;
  unitsCompleted: number;
  levelsCompleted: number;
  vocabularyMastered: number;
  grammarPracticed: number;
  speakingSubmissions: number;
  writingSubmissions: number;
  srsReviewsDone: number;
  retentionEstimate: number;
  lastActivityAt: Date;
}

// ============ TAGS ============

export interface Tag {
  id: string;
  name: string;
  category: 'cefr' | 'skill' | 'theme' | 'grammar' | 'lexicon' | 'pronunciation' | 'speech_act' | 'medium' | 'register' | 'track';
  color?: string;
}

export interface Tagging {
  id: string;
  tagId: string;
  targetId: string;
  targetType: 'unit' | 'lesson' | 'asset' | 'lexicon' | 'grammar' | 'pragmatics';
}

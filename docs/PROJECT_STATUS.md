# GrindEnglish — Project Status

**Last updated:** 2026-02-23

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | React 18 + Vite |
| Language | TypeScript |
| Styling | Tailwind CSS + tailwindcss-animate |
| UI Components | shadcn/ui (Radix primitives) |
| Routing | React Router DOM v6 |
| State/Data | TanStack React Query v5 |
| Forms | React Hook Form + Zod |
| Charts | Recharts |
| Auth | Lovable Cloud (Supabase Auth) |
| Database | PostgreSQL (Lovable Cloud) |
| Icons | Lucide React |
| Animations | Framer-compatible CSS keyframes |
| Toasts | Sonner |
| Package Manager | Bun |

---

## Database Schema (Active Tables)

| Table | Purpose |
|-------|---------|
| `profiles` | User profile data (name, avatar) |
| `user_roles` | Role assignments (admin, curriculum_designer, teacher, learner) |
| `courses` | Top-level course container |
| `levels` | CEFR levels within a course |
| `units` | Units within levels (theme, tasks, outcomes) |
| `lessons` | Lessons within units (type, goal, stages) |
| `lesson_stages` | Individual stages within lessons |
| `lexicon_entries` | Vocabulary database |
| `grammar_chapters` | Grammar reference content |
| `pronunciation_scripts` | Shadowing scripts |
| `pragmatics_packs` | Speech act packs |
| `pragmatics_items` | Phrases within packs |
| `assets` | Uploaded media files |
| `tags` / `taggings` | Polymorphic tag system |
| `progress_events` | User activity event log |
| `learner_progress` | Aggregated user progress stats |
| `srs_cards` | Spaced repetition vocabulary cards |
| `cohorts` | Teacher-managed student groups |
| `cohort_members` | Student-cohort relationships |
| `assignments` | Content assignments to students/cohorts |

---

## Authentication & Roles

- Email/password signup and login (Lovable Cloud Auth)
- Auto-assigned `learner` role on signup
- Four roles: `admin`, `curriculum_designer`, `teacher`, `learner`
- `has_role()` database function for RLS checks
- Role-based sidebar navigation and route protection

---

## Implemented Pages

### Public
- `/` — Landing page (EN/PT toggle, simplified hook design)
- `/login` — Login
- `/signup` — Signup

### Learner (Protected)
- `/dashboard` — Dashboard
- `/course` — Course overview
- `/course/unit/:unitId` — Unit detail
- `/course/lesson/:lessonId` — Lesson player
- `/lexicon` — Vocabulary reference (search, CEFR filter)
- `/grammar` — Grammar reference (Form/Meaning/Use tabs)
- `/pronunciation` — Pronunciation reference (with voice recorder)
- `/pragmatics` — Pragmatics reference (speech act packs)

### Author (Protected, content creator role)
- `/author/courses` — Course builder
- `/author/courses/:courseId/levels/:levelId` — Level detail
- `/author/units/:unitId` — Unit editor
- `/author/lessons/:lessonId` — Lesson editor
- `/author/lexicon` — Lexicon manager
- `/author/grammar` — Grammar manager
- `/author/pronunciation` — Pronunciation manager
- `/author/pragmatics` — Pragmatics manager
- `/author/assets` — Asset manager
- `/author/tags` — Tag manager

### Teacher (Protected)
- `/teach/dashboard` — Cohort dashboard (list all cohorts)
- `/teach/cohorts/:cohortId` — Cohort detail (progress, assignments, live class)
- `/teach/feedback` — Feedback queue
- `/teach/analytics` — Student analytics

### Admin (Protected)
- `/admin/users` — User management
- `/admin/settings` — Organization settings

---

## A0 Course Content (Seeded in DB)

### Units (3)
1. **The Professional Intro** — Identity language, greetings, self-introduction
2. **The Alphabet & Email** — Letter sounds, email dictation, digital communication
3. **Digital Business Card Portfolio** — Voice recording artifact submission

### Lessons (15)
Covering: listening, vocabulary, pronunciation, grammar, speaking, writing, review

### Grammar Chapters (12)
- A0.G.01. Sentence Basics
- A0.G.02. The Verb be
- A0.G.03. Subject Pronouns & Possessive Adjectives
- A0.G.04. Articles I
- A0.G.05. Plurals & This/That/These/Those
- A0.G.06. Imperatives
- A0.G.07. There is/are
- A0.G.08. Basic Prepositions of Place
- A0.G.09. Basic Questions
- A0.G.10. Can
- A0.G.11. Have
- A0.G.12. Simple Connectors

### Lexicon Entries (15)
Identity chunks, email symbols, professions, basic verbs

### Pragmatics Packs (3)
- Greeting Register Ladder (formal/informal)
- Self-Introduction Speech Act
- Email Etiquette Basics

---

## Custom Components
- `VoiceRecorder` — Browser MediaRecorder API, supports record/playback/download (.webm)
- `ProgressRing` — SVG circular progress indicator
- `LevelBadge` — CEFR level color-coded badge
- `SkillIcon` — Skill-specific icons

---

## What's Not Yet Built
- Lesson stages (interactive content within lessons)
- B2+ course content
- File upload to storage (asset manager)
- Feedback workspace (teacher section)
- CSV import/export for lexicon
- Dedicated Progress page with detailed analytics
- Study time tracking (automatic timer)
- Achievement/badge system
- SRS statistics and retention graphs
- Audio pronunciation in SRS reviews

---

## Recent Feature Implementations

### SRS (Spaced Repetition System) MVP (2026-03-06)
Implemented a complete vocabulary learning system using spaced repetition:

**Database Schema:**
- `srs_cards` table tracks individual word progress per user
- SM-2 algorithm implementation for optimal review scheduling
- Automatic `words_learned` counter integration
- Database functions: `get_or_create_srs_card()`, `update_srs_card()`, `get_due_cards_count()`

**SM-2 Algorithm:**
- Simplified SuperMemo 2 algorithm for review scheduling
- Four rating levels: Forgot (0), Hard (3), Good (4), Easy (5)
- Dynamic intervals: 1 day → 6 days → exponential growth
- Ease factor adjustment based on performance (1.3 to 3.0+)
- Automatic reset on forgotten words

**Metacognitive Assessment:**
- Bilingual modal (English/Portuguese) for A0/A1 learners
- Appears when closing vocabulary definitions
- Only triggers for new words or due reviews
- Four color-coded rating buttons with emoji indicators
- Toast confirmation on successful review

**Daily Review Queue:**
- Dashboard component showing due word count
- Bilingual call-to-action card
- Full-screen review session with progress tracking
- Loops through all due words automatically
- Shows word details, definition, examples, collocations
- Completion celebration screen

**Vocabulary Integration:**
- Automatic SRS card creation on first word view
- Contextual review trigger when closing definitions
- Seamless integration with existing vocabulary reference page
- No disruption to browsing experience

**Progress Tracking:**
- Words learned counter automatically increments
- Tracks first successful recall (repetitions 0 → 1+)
- Database trigger for automatic updates
- Displayed on dashboard with other metrics

**Security:**
- Row Level Security on all SRS cards
- Users can only access their own cards
- Content creators can view all for analytics
- Automatic user_id validation

**Documentation:**
- Complete guide in `docs/SRS_SYSTEM_GUIDE.md`
- SM-2 algorithm explanation
- Component API reference
- Testing procedures
- Migration file: `supabase/migrations/20260306000000_create_srs_system.sql`

**User Experience:**
- Non-intrusive review prompts
- Clear visual feedback
- Bilingual support for beginners
- Motivating progress indicators
- Simple, intuitive interface

### Cohort Management & Assignment System (2026-03-07)
Implemented complete teacher workflow for grouping students, tracking progress, and managing assignments:

**Database Schema:**
- `cohorts` table for teacher-managed student groups
- `cohort_members` junction table for student-cohort relationships
- `assignments` table for content assignments (grammar, vocabulary, lessons, units)
- Helper functions: `is_teacher()`, `get_teacher_students()`, `get_cohort_progress()`, `teacher_add_words_to_srs()`, `get_student_assignments()`
- Enhanced RLS policies allow teachers to view/manage their students' SRS cards and progress

**Cohort Management:**
- Create cohorts with name and description (e.g., "João Private", "Maria & Ana B1")
- Add/remove students from cohorts
- View cohort member count and status
- Edit cohort details or delete cohorts
- Support for 1-on-1 or small group (2-on-1) teaching

**Progress Tracking:**
- Real-time view of all students in a cohort
- Per-student metrics: current streak, words learned, lessons completed, last activity date
- Pending and completed assignment counts
- Leverages existing `learner_progress` table
- Automatic updates via Supabase subscriptions

**Assignment System:**
- Assign grammar chapters to entire cohorts or individual students
- Set optional due dates and notes
- Track assignment status: pending, in_progress, completed
- Students can view and update their assignments
- Auto-completion timestamp when status changes to completed
- Support for multiple content types (grammar, vocabulary, lesson, unit)

**Live Class SRS Trigger:**
- Search vocabulary from A1 Master Lexicon
- Select multiple words covered in live class
- Bulk add words to all students' SRS queues
- Words appear in students' daily review queue
- Uses existing `get_or_create_srs_card()` function
- Enables teacher-initiated vocabulary review based on class performance

**Teacher Dashboard:**
- List all active cohorts with member counts
- Create new cohorts via dialog
- Navigate to cohort detail pages
- View cohort status and creation dates
- Clean, professional UI with shadcn/ui components

**Cohort Detail Page:**
- Three-tab interface: Progress, Assignments, Live Class
- Progress tab: student list with metrics and actions
- Assignments tab: create/view/delete assignments
- Live Class tab: vocabulary search and SRS injection
- Edit cohort details or delete cohort
- Back navigation to dashboard

**Custom Hooks:**
- `useCohorts()`: Manages cohort CRUD operations and member management
- `useAssignments()`: Handles assignment creation, updates, and queries
- Both hooks provide loading states and error handling
- Automatic data refresh after mutations

**Security:**
- Row Level Security on all cohort tables
- Teachers can only access their own cohorts and students
- Students can view their cohorts and assignments
- Students can update assignment status but not other fields
- Admins have full visibility for oversight

**Integration:**
- Seamlessly integrates with existing SRS system
- Uses existing progress tracking infrastructure
- Compatible with current authentication and role system
- Extends teacher role capabilities

**Documentation:**
- Complete guide in `docs/COHORT_MANAGEMENT_GUIDE.md`
- Database schema reference
- Usage workflows and examples
- Deployment checklist
- Troubleshooting guide
- Migration file: `supabase/migrations/20260307000000_create_cohort_management.sql`

**User Experience:**
- Intuitive three-tab layout for different teacher tasks
- Real-time progress updates
- Clear visual feedback with icons and badges
- Bilingual support (EN/PT) for Brazilian market
- Responsive design with loading states and error handling

**Future Enhancements:**
- Pacing calendars for scheduled content delivery
- Bulk assignment operations
- Detailed student analytics with charts
- Assignment templates
- Cohort cloning
- Parent/guardian access
- Automated reminders for due assignments

### Progress Tracking System (2026-03-05)
Implemented comprehensive user activity tracking and streak counter system:

**Database Schema:**
- `progress_events` table logs all user activity (page views, content interactions)
- `learner_progress` table stores aggregated stats per user (streaks, time, words learned)
- Automatic streak calculation with consecutive day logic
- Database functions: `log_activity_event()` and `update_user_streak()`

**Activity Tracking:**
- Tracks 11 event types: login, dashboard_view, lesson_start, lesson_complete, grammar_view, vocab_view, pronunciation_view, pragmatics_view, course_view, level_view, unit_view
- Automatic page view tracking via `usePageViewTracker` hook
- Custom event logging via `useActivityTracker` hook
- Real-time progress updates with Supabase subscriptions

**Dashboard Integration:**
- Live streak counter (current and longest streak)
- Total study time display (formatted as hours/minutes)
- Words learned counter (ready for vocabulary exercise integration)
- SRS retention placeholder (for future spaced repetition system)
- Automatic activity logging on dashboard visit

**Streak Logic:**
- First activity starts streak at 1 day
- Consecutive daily visits increment the streak
- Missing a day resets streak to 1
- Longest streak is tracked separately
- Updates happen automatically on any tracked activity

**Content Tracking:**
- Grammar chapter views tracked with chapter details
- Vocabulary entry views tracked with word details
- Pronunciation and pragmatics views tracked
- Course navigation tracked (course, level, unit pages)

**Security:**
- Row Level Security (RLS) on all progress tables
- Users can only view/modify their own progress
- Content creators can view all progress for analytics
- Automatic progress record creation on first activity

**Documentation:**
- Complete guide in `docs/PROGRESS_TRACKING_GUIDE.md`
- API reference for hooks and database functions
- Migration file: `supabase/migrations/20260305000000_create_progress_tracking.sql`

**Future Enhancements:**
- Automatic study time tracking with session timers
- Words learned counter integration with vocabulary exercises
- Dedicated Progress page with charts and detailed analytics
- Achievement/badge system for milestones
- Weekly/monthly progress reports

### Publish/Unpublish Functionality (2026-02-23)
Added comprehensive publish controls across all course builder pages to manage content visibility for students:

- **Course Level**: Publish/unpublish entire courses from the Course Builder page
- **Level Level**: Toggle visibility for individual CEFR levels (A0-C2) within courses
- **Unit Level**: Publish/unpublish units from both the Level Detail page and Unit Editor page
- **Lesson Level**: Control lesson visibility from both the Unit Editor and Lesson Editor pages

**Implementation Details:**
- All content types (courses, levels, units, lessons) have `is_published` boolean fields in the database
- Publish buttons appear on hover for list items, and as prominent buttons in editor pages
- Visual feedback with Eye/EyeOff icons and status badges (Published/Draft)
- Toast notifications confirm publish state changes
- RLS policies ensure only published content is visible to learner role users
- Content creators (admin/curriculum_designer) can see all content regardless of publish status

**User Experience:**
- Draft content is hidden from students but visible to teachers and admins
- Allows incremental content development without exposing incomplete work
- Clear visual indicators show publish status throughout the interface
- One-click toggle between published and draft states

**Student-Facing Pages Updated:**
- CoursePage now queries and displays only published levels with unit counts
- New LevelPage created to show published units within a level
- UnitPage updated to show only published lessons
- Proper routing added for student navigation: /course → /course/level/:levelId → /course/:level/:unitId
- Empty states guide students when no content is published yet

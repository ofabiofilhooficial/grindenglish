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
- `/teach/dashboard` — Cohort dashboard
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
- SRS system (spaced repetition)
- File upload to storage (asset manager)
- Cohort management (teacher section)
- Feedback workspace (teacher section)
- CSV import/export for lexicon
- Dedicated Progress page with detailed analytics
- Study time tracking (automatic timer)
- Words learned counter (vocabulary exercise integration)
- Achievement/badge system

---

## Recent Feature Implementations

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

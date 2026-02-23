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

### Grammar Chapters (4)
- Be vs Have: The Identity Verb
- Subject Pronouns & Verb Agreement
- Articles: A/An with Professions
- Prepositions of Origin: From

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
- Student progress tracking / SRS system
- File upload to storage (asset manager)
- Cohort management (teacher section)
- Feedback workspace (teacher section)
- CSV import/export for lexicon
- Real dashboard data (currently placeholder)

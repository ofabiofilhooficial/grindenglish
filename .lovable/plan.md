

# Phase 1: From Prototype to Real Platform

This plan transforms the current UI prototype into a functional platform with authentication, role-based access, and content authoring tools -- so you can start building the A0 course immediately.

---

## Step 1: Enable Backend (Lovable Cloud + Supabase)

Connect the project to Lovable Cloud to get a managed database, authentication, and file storage. This is the foundation for everything else.

---

## Step 2: Authentication and User Roles

### What changes for users
- **Signup page** creates a real account (email + password)
- **Login page** authenticates against the database
- **Sign Out** button works
- Every new user is automatically assigned the **learner** role
- Hardcoded "Jane Doe" references throughout the app are replaced with the real logged-in user's name and initials

### Technical details
- Create a `profiles` table (id, full_name, avatar_url, created_at) linked to `auth.users`
- Create a `user_roles` table with an `app_role` enum: `admin`, `curriculum_designer`, `teacher`, `learner`
- Database trigger: on signup, auto-create a profile row AND insert a `learner` role
- `has_role()` security-definer function for safe RLS checks
- Build a React auth context (`useAuth` hook) providing current user, profile, and roles
- Protect all `/dashboard`, `/course`, `/author/*`, `/teach/*`, `/admin/*` routes -- redirect to `/login` if not authenticated
- Wire up the existing Login, Signup, and Sign Out UI to Supabase Auth

---

## Step 3: Role-Based Navigation

### What changes for users
- The sidebar adapts based on your role:
  - **Learners** see: Dashboard, My Course, Review Center, Portfolio, Progress, and Reference sections (as today)
  - **Teachers** see the learner sections PLUS a "Teaching" section: Cohort Dashboard, Feedback Queue, Student Analytics
  - **Curriculum Designers / Admins** see everything PLUS an "Authoring" section: Course Builder, Lexicon Manager, Grammar Chapters, Pronunciation Lab, Pragmatics Lab, Asset Manager
  - **Admins** also see: User Management, Organization Settings
- The header shows the real user's name/avatar instead of "Jane Doe"

### Technical details
- Refactor `AppSidebar` to read roles from the auth context and conditionally render navigation sections
- Create route guards that check `has_role` before rendering admin/author/teacher pages
- Add new route definitions in `App.tsx` for all the new sections

---

## Step 4: Database Schema for Content

Create the core tables that store course content (replacing the in-memory seed data):

| Table | Purpose |
|-------|---------|
| `courses` | Top-level course container |
| `levels` | CEFR levels (A0-C2) within a course |
| `units` | Units within levels (theme, flagship task, outcomes, targets) |
| `lessons` | Lessons within units (type, goal, stages) |
| `lesson_stages` | Individual stages within a lesson |
| `assets` | Uploaded media files (audio, video, PDF, images) |
| `lexicon_entries` | Vocabulary database |
| `grammar_chapters` | Grammar reference chapters |
| `pronunciation_scripts` | Shadowing scripts |
| `pragmatics_packs` | Speech act packs |
| `pragmatics_items` | Individual phrases within packs |
| `tags` | Reusable tags |
| `taggings` | Polymorphic tag associations |

All tables have RLS enabled:
- Admins and curriculum designers can create, edit, and delete content
- Teachers can read all published content
- Learners can read published content only

---

## Step 5: Admin Section

### Pages to build

**User Management** (`/admin/users`)
- Table of all users with name, email, current role(s), signup date
- Click a user to change their role (promote to teacher, curriculum_designer, or admin)
- Search and filter users

**Organization Settings** (`/admin/settings`)
- Platform name, logo upload
- Default settings (self-paced vs cohort mode)

---

## Step 6: Content Authoring Section (CMS)

This is the biggest piece -- the tools you'll use to create the A0 course.

### 6A. Course Outline Builder (`/author/courses`)
- View the course with all CEFR levels listed
- Expand a level to see its units
- Add, reorder, or delete units within a level
- Each unit shows: title, theme, status (draft/published), lesson count

### 6B. Unit Editor (`/author/units/:id`)
A tabbed form with 7 tabs:

1. **Overview** -- title, theme, flagship task, secondary tasks, estimated time, track (core/professional/academic)
2. **Outcomes** -- text fields grouped by skill (listening, reading, speaking, writing, grammar, vocabulary, pronunciation, pragmatics)
3. **Targets** -- searchable pickers to link vocabulary entries, grammar chapters, pronunciation targets, and pragmatics targets
4. **Inputs** -- upload or attach audio, video, PDFs, transcripts; manage input assets for the unit
5. **Lesson Sequence** -- ordered list of lessons; add new lessons with type selector; drag to reorder
6. **Recycling** -- select items from earlier units that should reappear
7. **Deliverables** -- define the speaking artifact, writing artifact, and reflection with checklists

### 6C. Lesson Editor (`/author/lessons/:id`)
- Header fields: title, type, goal, success criteria, interaction pattern
- Stage builder: add stages from a template menu (retrieval warm-up, lead-in, input, comprehension, noticing, practice, communicative use, feedback, assignment, reflection)
- Each stage has: title, instructions, timing, content type, asset attachments
- Interactive task builder for comprehension stages (MCQ, cloze, matching, ordering, short answer)
- Homework section (retrieval, input, output fields)
- Support track / challenge track optional fields

### 6D. Lexicon Manager (`/author/lexicon`)
- Searchable/filterable table of all vocabulary entries
- Detail view/editor with all fields (headword, type, POS, CEFR levels, IPA, definitions, examples, collocations, patterns, tags, register, frequency)
- CSV import and export
- Shows which units introduce and recycle each entry

### 6E. Grammar Chapters Manager (`/author/grammar`)
- List view grouped by CEFR level
- Chapter editor: form, meaning, use, contrast, common errors, micro-practice tasks, task upgrades, cross-links

### 6F. Pronunciation Lab Manager (`/author/pronunciation`)
- Shadowing script list with filters
- Script editor: text, chunked version, stress-marked version, focus tags, speed plan, audio upload

### 6G. Pragmatics Lab Manager (`/author/pragmatics`)
- Speech act pack list
- Pack editor: register ladder items, medium guide items, phrase items
- Case study editor

### 6H. Asset Manager (`/author/assets`)
- Central media library: upload audio, video, PDFs, images
- Tag each asset with CEFR level, skill, unit associations
- See where each asset is used

---

## Step 7: Teacher Section

### Pages to build

**Cohort Dashboard** (`/teach/dashboard`)
- List of teacher's cohorts with student count, progress summary
- Create new cohort (name, course, start/end dates)

**Cohort Detail** (`/teach/cohorts/:id`)
- Student roster with individual progress
- Assign due dates per unit
- Add live session links

**Feedback Queue** (`/teach/feedback`)
- List of pending student submissions (speaking recordings, writing drafts)
- Filter by cohort, unit, type

**Feedback Workspace** (`/teach/feedback/:id`)
- For speaking: audio player with ability to add timestamped comments
- For writing: inline text with comment/markup tools
- Mark as reviewed; student gets notified

---

## Step 8: Clean Up Placeholder Data

- Remove all hardcoded data from `DashboardPage`, `CoursePage`, `UnitPage`, `LessonPlayerPage`
- Replace with database queries (TanStack Query + Supabase client)
- The dashboard shows real data: actual current unit, real streak, real SRS count
- Course page fetches levels and units from the database
- Empty states shown when no content exists yet (instead of fake data)
- Seed the database with the A0 level structure (6 units with titles/themes) so you have a starting point to fill in

---

## Implementation Order

The work will be done in this sequence since each step depends on the previous:

1. **Enable Lovable Cloud** (backend connection)
2. **Auth + profiles + roles** (signup/login work, new users are learners)
3. **Core content tables** (database schema)
4. **Role-based sidebar + routing** (navigation adapts to role)
5. **Admin user management** (so you can promote yourself to admin/author)
6. **Course Outline Builder** (create levels and units)
7. **Unit Editor** (fill in unit details)
8. **Lesson Editor** (build lessons with stages)
9. **Lexicon, Grammar, Pronunciation, Pragmatics managers** (reference content)
10. **Asset Manager** (media uploads)
11. **Teacher section** (cohorts + feedback)
12. **Remove placeholder data** from learner pages, connect to real DB

Due to the size of this work, it will be implemented across multiple conversations. The first implementation will cover steps 1-5 (backend, auth, schema, routing, and admin), giving you a working platform where you can sign up, get assigned as admin, and start seeing the authoring UI structure.


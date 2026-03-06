# GrindEnglish Documentation

Welcome to the GrindEnglish documentation! This folder contains comprehensive guides for developers, content creators, and administrators.

## Quick Start

- **New to the project?** Start with [PROJECT_STATUS.md](./PROJECT_STATUS.md)
- **Setting up progress tracking?** See [PROGRESS_TRACKING_QUICK_REF.md](./PROGRESS_TRACKING_QUICK_REF.md)
- **Publishing content?** Read [PUBLISH_FEATURE_GUIDE.md](./PUBLISH_FEATURE_GUIDE.md)

## Documentation Index

### Project Overview
- **[PROJECT_STATUS.md](./PROJECT_STATUS.md)** - Current state of the project, tech stack, database schema, and implemented features

### Feature Guides

#### Progress Tracking System
- **[PROGRESS_TRACKING_QUICK_REF.md](./PROGRESS_TRACKING_QUICK_REF.md)** - Quick reference for adding activity tracking to pages
- **[PROGRESS_TRACKING_GUIDE.md](./PROGRESS_TRACKING_GUIDE.md)** - Complete guide to the progress tracking system
- **[PROGRESS_TRACKING_IMPLEMENTATION.md](./PROGRESS_TRACKING_IMPLEMENTATION.md)** - Implementation details and technical decisions

#### Publishing System
- **[PUBLISH_FEATURE_GUIDE.md](./PUBLISH_FEATURE_GUIDE.md)** - How to use the publish/unpublish functionality
- **[PUBLISH_FIX_SUMMARY.md](./PUBLISH_FIX_SUMMARY.md)** - Technical details of the publishing system implementation

#### SRS (Spaced Repetition System)
- **[SRS_SYSTEM_GUIDE.md](./SRS_SYSTEM_GUIDE.md)** - Complete guide to the vocabulary SRS system
- **[SRS_IMPLEMENTATION_SUMMARY.md](./SRS_IMPLEMENTATION_SUMMARY.md)** - Implementation details and technical decisions

## Feature Documentation

### Progress Tracking System

The progress tracking system monitors user activity and maintains engagement metrics.

**Key Features:**
- Automatic streak tracking (consecutive daily visits)
- Activity event logging (page views, content interactions)
- Real-time progress updates on dashboard
- Study time tracking (foundation in place)
- Words learned counter (foundation in place)

**Quick Links:**
- [Quick Reference](./PROGRESS_TRACKING_QUICK_REF.md) - Code snippets and common patterns
- [Complete Guide](./PROGRESS_TRACKING_GUIDE.md) - Full documentation
- [Implementation Details](./PROGRESS_TRACKING_IMPLEMENTATION.md) - Technical overview

### SRS (Spaced Repetition System)

The SRS system helps students retain vocabulary through scientifically-proven spaced repetition.

**Key Features:**
- SM-2 algorithm for optimal review scheduling
- Bilingual assessment modal (EN/PT)
- Daily review queue on dashboard
- Automatic words learned tracking
- Four rating levels (Forgot, Hard, Good, Easy)

**Quick Links:**
- [Complete Guide](./SRS_SYSTEM_GUIDE.md) - Full documentation
- [Implementation Details](./SRS_IMPLEMENTATION_SUMMARY.md) - Technical overview

### Publishing System

The publishing system controls content visibility for students.

**Key Features:**
- Publish/unpublish courses, levels, units, and lessons
- Draft mode for content development
- Visual indicators for publish status
- Role-based content visibility

**Quick Links:**
- [Feature Guide](./PUBLISH_FEATURE_GUIDE.md) - How to use the publishing system
- [Implementation Summary](./PUBLISH_FIX_SUMMARY.md) - Technical details

## Database

### Schema Overview

The database uses PostgreSQL with Supabase for authentication and real-time features.

**Core Tables:**
- `profiles` - User profile data
- `user_roles` - Role assignments
- `courses`, `levels`, `units`, `lessons` - Course structure
- `lexicon_entries` - Vocabulary database
- `grammar_chapters` - Grammar reference
- `progress_events` - Activity logging
- `learner_progress` - Aggregated progress stats
- `srs_cards` - Spaced repetition vocabulary cards

**Migrations:**
- Located in `supabase/migrations/`
- Run in Supabase SQL Editor
- See [PROJECT_STATUS.md](./PROJECT_STATUS.md) for table details

### Security

All tables use Row Level Security (RLS):
- Users can only access their own data
- Content creators can view all content
- Admins have full access

## Development Workflow

### Adding a New Feature

1. **Plan**: Document the feature requirements
2. **Database**: Create migration if needed
3. **Backend**: Add database functions/triggers
4. **Frontend**: Create React components and hooks
5. **Test**: Verify functionality
6. **Document**: Update relevant docs

### Adding Activity Tracking

1. Import `usePageViewTracker` or `useActivityTracker`
2. Add tracking to your component
3. Test in browser console
4. Verify events in `progress_events` table

See [PROGRESS_TRACKING_QUICK_REF.md](./PROGRESS_TRACKING_QUICK_REF.md) for code examples.

### Publishing Content

1. Create content in author pages
2. Click publish button when ready
3. Content becomes visible to students
4. Unpublish anytime to hide from students

See [PUBLISH_FEATURE_GUIDE.md](./PUBLISH_FEATURE_GUIDE.md) for details.

## Tech Stack

- **Frontend**: React 18 + TypeScript + Vite
- **Styling**: Tailwind CSS + shadcn/ui
- **Database**: PostgreSQL (Supabase)
- **Auth**: Supabase Auth
- **State**: TanStack React Query
- **Routing**: React Router v6

See [PROJECT_STATUS.md](./PROJECT_STATUS.md) for complete tech stack.

## Contributing

### Documentation Standards

- Use Markdown for all documentation
- Include code examples where relevant
- Keep guides focused and concise
- Update PROJECT_STATUS.md when adding features
- Create separate guides for complex features

### Code Standards

- TypeScript for all new code
- Use React hooks for state management
- Follow existing component patterns
- Add JSDoc comments for complex functions
- Use meaningful variable names

## Getting Help

### Common Issues

**Streak not updating?**
- See [PROGRESS_TRACKING_GUIDE.md](./PROGRESS_TRACKING_GUIDE.md#troubleshooting)

**Content not visible to students?**
- Check publish status in author pages
- See [PUBLISH_FEATURE_GUIDE.md](./PUBLISH_FEATURE_GUIDE.md)

**Database errors?**
- Verify migrations are applied
- Check RLS policies in Supabase
- Review error logs in browser console

### Resources

- **Supabase Docs**: https://supabase.com/docs
- **React Docs**: https://react.dev
- **Tailwind CSS**: https://tailwindcss.com/docs
- **shadcn/ui**: https://ui.shadcn.com

## Roadmap

### In Progress
- Study time tracking with session timers
- Dedicated Progress page with analytics
- SRS statistics and retention graphs

### Planned
- Achievement/badge system
- Teacher analytics dashboard
- Cohort management
- Feedback workspace
- Audio pronunciation in SRS reviews
- Bulk vocabulary import

See [PROJECT_STATUS.md](./PROJECT_STATUS.md) for complete roadmap.

## License

[Add license information here]

## Contact

[Add contact information here]

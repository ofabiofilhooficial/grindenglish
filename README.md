# Grind English

A comprehensive English language learning platform built with modern web technologies.

## Tech Stack

- **Frontend**: React + TypeScript + Vite
- **UI**: shadcn/ui + Tailwind CSS
- **Backend**: Supabase (PostgreSQL + Auth + Storage)
- **Deployment**: Vercel
- **Version Control**: GitHub

## Getting Started

### Prerequisites

- Node.js 18+ and npm (install with [nvm](https://github.com/nvm-sh/nvm#installing-and-updating))
- Supabase account and project
- Vercel account (for deployment)

### Local Development

1. Clone the repository:
```sh
git clone <YOUR_GIT_URL>
cd <YOUR_PROJECT_NAME>
```

2. Install dependencies:
```sh
npm install
```

3. Set up environment variables:
Create a `.env` file in the root directory with:
```
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

4. Start the development server:
```sh
npm run dev
```

The app will be available at `http://localhost:8080`

### Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run build:dev` - Build in development mode
- `npm run preview` - Preview production build
- `npm run lint` - Run ESLint
- `npm run test` - Run tests once
- `npm run test:watch` - Run tests in watch mode

### Vocabulary Management Scripts

- `npm run vocab:validate` - Validate vocabulary data
- `npm run vocab:progress` - Check vocabulary progress
- `npm run vocab:report` - Generate vocabulary report
- `npm run vocab:verify` - Verify vocabulary in database
- `npm run vocab:debug` - Debug database vocabulary

## Deployment

### Vercel Deployment

1. Connect your GitHub repository to Vercel
2. Configure environment variables in Vercel dashboard:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
3. Deploy automatically on push to main branch

The `vercel.json` configuration handles SPA routing automatically.

### Supabase Setup

1. Create a new Supabase project
2. Run migrations from `supabase/migrations/` directory
3. Configure authentication providers (Google, LinkedIn, GitHub)
4. Set up RLS policies (included in migrations)

## Project Structure

```
├── src/
│   ├── components/     # React components
│   ├── hooks/          # Custom React hooks
│   ├── integrations/   # Third-party integrations (Supabase)
│   ├── pages/          # Page components
│   └── lib/            # Utility functions
├── supabase/
│   └── migrations/     # Database migrations
├── public/             # Static assets
└── docs/               # Documentation
```

## Features

- **Authentication**: Email/password and OAuth (Google, LinkedIn, GitHub)
- **Role-Based Access**: Admin, Curriculum Designer, Teacher, Learner roles
- **Course Management**: CEFR-aligned course structure (A0-C2)
- **Lesson Player**: Interactive lesson stages with multimedia support
- **Vocabulary System**: Comprehensive lexicon with SRS practice
- **Progress Tracking**: Student progress and analytics
- **Content Authoring**: CMS for curriculum designers

## Contributing

1. Create a feature branch
2. Make your changes
3. Run tests and linting
4. Submit a pull request

## License

Private - All rights reserved

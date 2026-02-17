-- Courses table
CREATE TABLE courses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  slug TEXT UNIQUE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Levels table (CEFR A0-C2)
CREATE TABLE levels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  name TEXT NOT NULL, -- A0, A1, A2, B1, B2, C1, C2
  order_index INT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Units table
CREATE TABLE units (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  level_id UUID NOT NULL REFERENCES levels(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  theme TEXT,
  status TEXT DEFAULT 'draft', -- draft, published
  order_index INT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Lessons table
CREATE TABLE lessons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  unit_id UUID NOT NULL REFERENCES units(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  type TEXT NOT NULL,
  goal TEXT,
  order_index INT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Lesson stages table
CREATE TABLE lesson_stages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  type TEXT NOT NULL,
  instructions TEXT,
  timing INT,
  order_index INT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Assets table
CREATE TABLE assets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  type TEXT NOT NULL, -- audio, video, image, pdf
  url TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Lexicon entries table
CREATE TABLE lexicon_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  headword TEXT NOT NULL,
  part_of_speech TEXT,
  cefr_level TEXT,
  ipa TEXT,
  definition TEXT,
  examples TEXT[],
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Grammar chapters table
CREATE TABLE grammar_chapters (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  cefr_level TEXT,
  form TEXT,
  meaning TEXT,
  use_case TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Pronunciation scripts table
CREATE TABLE pronunciation_scripts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  text TEXT NOT NULL,
  audio_url TEXT,
  cefr_level TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Pragmatics packs table
CREATE TABLE pragmatics_packs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  speech_act TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tags table
CREATE TABLE tags (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT UNIQUE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS on all content tables
ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE levels ENABLE ROW LEVEL SECURITY;
ALTER TABLE units ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE lesson_stages ENABLE ROW LEVEL SECURITY;
ALTER TABLE assets ENABLE ROW LEVEL SECURITY;
ALTER TABLE lexicon_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE grammar_chapters ENABLE ROW LEVEL SECURITY;
ALTER TABLE pronunciation_scripts ENABLE ROW LEVEL SECURITY;
ALTER TABLE pragmatics_packs ENABLE ROW LEVEL SECURITY;
ALTER TABLE tags ENABLE ROW LEVEL SECURITY;

-- RLS Policies - Authors/Admins can manage content
CREATE POLICY "Authors can create content"
  ON courses FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM user_roles 
      WHERE user_id = auth.uid() AND app_role IN ('admin', 'curriculum_designer')
    )
  );

CREATE POLICY "Everyone can view published content"
  ON courses FOR SELECT
  USING (true);

CREATE POLICY "Authors can update content"
  ON courses FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM user_roles 
      WHERE user_id = auth.uid() AND app_role IN ('admin', 'curriculum_designer')
    )
  );

-- Apply similar policies to other content tables
CREATE POLICY "Everyone can view levels"
  ON levels FOR SELECT
  USING (true);

CREATE POLICY "Everyone can view units"
  ON units FOR SELECT
  USING (true);

CREATE POLICY "Everyone can view lessons"
  ON lessons FOR SELECT
  USING (true);

CREATE POLICY "Everyone can view lesson_stages"
  ON lesson_stages FOR SELECT
  USING (true);

CREATE POLICY "Everyone can view assets"
  ON assets FOR SELECT
  USING (true);

CREATE POLICY "Everyone can view lexicon_entries"
  ON lexicon_entries FOR SELECT
  USING (true);

CREATE POLICY "Everyone can view grammar_chapters"
  ON grammar_chapters FOR SELECT
  USING (true);

CREATE POLICY "Everyone can view pronunciation_scripts"
  ON pronunciation_scripts FOR SELECT
  USING (true);

CREATE POLICY "Everyone can view pragmatics_packs"
  ON pragmatics_packs FOR SELECT
  USING (true);

CREATE POLICY "Authors can insert to all content"
  ON levels FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM user_roles 
      WHERE user_id = auth.uid() AND app_role IN ('admin', 'curriculum_designer')
    )
  );

CREATE POLICY "Authors can update all content"
  ON levels FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM user_roles 
      WHERE user_id = auth.uid() AND app_role IN ('admin', 'curriculum_designer')
    )
  );

-- Repeat insert/update policies for other tables
CREATE POLICY "Authors can insert units"
  ON units FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM user_roles 
      WHERE user_id = auth.uid() AND app_role IN ('admin', 'curriculum_designer')
    )
  );

CREATE POLICY "Authors can update units"
  ON units FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM user_roles 
      WHERE user_id = auth.uid() AND app_role IN ('admin', 'curriculum_designer')
    )
  );

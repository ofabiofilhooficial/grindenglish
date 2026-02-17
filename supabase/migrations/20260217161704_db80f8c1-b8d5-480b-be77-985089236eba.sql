
-- Courses
CREATE TABLE public.courses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  is_published BOOLEAN NOT NULL DEFAULT false,
  created_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;

-- Levels
CREATE TABLE public.levels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id UUID NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  cefr_code TEXT NOT NULL, -- A0, A1, A2, B1, B2, C1, C2
  sort_order INT NOT NULL DEFAULT 0,
  is_published BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.levels ENABLE ROW LEVEL SECURITY;

-- Units
CREATE TABLE public.units (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  level_id UUID NOT NULL REFERENCES public.levels(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  theme TEXT,
  flagship_task TEXT,
  secondary_tasks JSONB DEFAULT '[]',
  outcomes JSONB DEFAULT '{}',
  estimated_time_minutes INT,
  track TEXT NOT NULL DEFAULT 'core', -- core, professional, academic
  is_published BOOLEAN NOT NULL DEFAULT false,
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.units ENABLE ROW LEVEL SECURITY;

-- Lessons
CREATE TYPE public.lesson_type AS ENUM (
  'listening', 'reading', 'grammar', 'vocabulary', 'pronunciation',
  'speaking', 'writing', 'fluency', 'mediation', 'review', 'assessment'
);

CREATE TABLE public.lessons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  unit_id UUID NOT NULL REFERENCES public.units(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  lesson_type public.lesson_type NOT NULL DEFAULT 'listening',
  goal TEXT,
  success_criteria TEXT,
  interaction_pattern TEXT, -- solo, pair, group, async
  recycled_language JSONB DEFAULT '[]',
  new_language JSONB DEFAULT '[]',
  homework JSONB DEFAULT '{}',
  support_track TEXT,
  challenge_track TEXT,
  is_published BOOLEAN NOT NULL DEFAULT false,
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.lessons ENABLE ROW LEVEL SECURITY;

-- Lesson stages
CREATE TABLE public.lesson_stages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id UUID NOT NULL REFERENCES public.lessons(id) ON DELETE CASCADE,
  stage_type TEXT NOT NULL, -- warm_up, lead_in, input, comprehension, noticing, practice, communicative_use, feedback, assignment, reflection
  title TEXT NOT NULL,
  instructions TEXT,
  timing_minutes INT,
  content JSONB DEFAULT '{}',
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.lesson_stages ENABLE ROW LEVEL SECURITY;

-- Assets
CREATE TABLE public.assets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  file_name TEXT NOT NULL,
  file_url TEXT NOT NULL,
  file_type TEXT NOT NULL, -- audio, video, pdf, image, transcript
  file_size_bytes BIGINT,
  metadata JSONB DEFAULT '{}',
  uploaded_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.assets ENABLE ROW LEVEL SECURITY;

-- Lexicon entries
CREATE TABLE public.lexicon_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  headword TEXT NOT NULL,
  entry_type TEXT NOT NULL DEFAULT 'lemma', -- lemma, phrase, collocation, discourse_marker, routine
  pos TEXT, -- noun, verb, adj, adv, etc.
  cefr_receptive TEXT,
  cefr_productive TEXT,
  ipa TEXT,
  definition_simple TEXT,
  definition_teacher TEXT,
  usage_notes TEXT,
  register TEXT,
  variety TEXT, -- US, UK, international
  examples JSONB DEFAULT '[]',
  collocations JSONB DEFAULT '[]',
  patterns JSONB DEFAULT '[]',
  frequency_band TEXT,
  is_published BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.lexicon_entries ENABLE ROW LEVEL SECURITY;

-- Grammar chapters
CREATE TABLE public.grammar_chapters (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_code TEXT NOT NULL UNIQUE, -- e.g. B1.G.01
  title TEXT NOT NULL,
  cefr_level TEXT NOT NULL,
  form_content TEXT,
  meaning_content TEXT,
  use_content TEXT,
  contrast_notes TEXT,
  common_errors TEXT,
  micro_practice JSONB DEFAULT '[]',
  cross_links JSONB DEFAULT '[]',
  is_published BOOLEAN NOT NULL DEFAULT false,
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.grammar_chapters ENABLE ROW LEVEL SECURITY;

-- Pronunciation scripts
CREATE TABLE public.pronunciation_scripts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  script_type TEXT NOT NULL DEFAULT 'micro_shadow', -- micro_shadow, chunk, dialogue, monologue
  text_content TEXT,
  chunked_content TEXT,
  stress_marked_content TEXT,
  focus_tags JSONB DEFAULT '[]',
  speed_plan TEXT,
  audio_asset_id UUID REFERENCES public.assets(id),
  cefr_level TEXT,
  is_published BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.pronunciation_scripts ENABLE ROW LEVEL SECURITY;

-- Pragmatics packs
CREATE TABLE public.pragmatics_packs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  pack_type TEXT NOT NULL, -- speech_act, register_ladder, medium_guide, case_study
  description TEXT,
  cefr_level TEXT,
  is_published BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.pragmatics_packs ENABLE ROW LEVEL SECURITY;

-- Pragmatics items
CREATE TABLE public.pragmatics_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pack_id UUID NOT NULL REFERENCES public.pragmatics_packs(id) ON DELETE CASCADE,
  label TEXT NOT NULL,
  content JSONB DEFAULT '{}',
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.pragmatics_items ENABLE ROW LEVEL SECURITY;

-- Tags
CREATE TABLE public.tags (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  category TEXT, -- cefr, skill, theme, grammar, lexicon, pronunciation, speech_act, medium, register
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.tags ENABLE ROW LEVEL SECURITY;

-- Taggings (polymorphic)
CREATE TABLE public.taggings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tag_id UUID NOT NULL REFERENCES public.tags(id) ON DELETE CASCADE,
  taggable_type TEXT NOT NULL, -- unit, lesson, lexicon_entry, grammar_chapter, etc.
  taggable_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (tag_id, taggable_type, taggable_id)
);
ALTER TABLE public.taggings ENABLE ROW LEVEL SECURITY;

-- RLS policies for all content tables: content creators can CRUD, authenticated can read published
-- Courses
CREATE POLICY "Content creators full access" ON public.courses FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));
CREATE POLICY "Authenticated read published" ON public.courses FOR SELECT TO authenticated USING (is_published = true);

-- Levels
CREATE POLICY "Content creators full access" ON public.levels FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));
CREATE POLICY "Authenticated read published" ON public.levels FOR SELECT TO authenticated USING (is_published = true);

-- Units
CREATE POLICY "Content creators full access" ON public.units FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));
CREATE POLICY "Authenticated read published" ON public.units FOR SELECT TO authenticated USING (is_published = true);

-- Lessons
CREATE POLICY "Content creators full access" ON public.lessons FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));
CREATE POLICY "Authenticated read published" ON public.lessons FOR SELECT TO authenticated USING (is_published = true);

-- Lesson stages
CREATE POLICY "Content creators full access" ON public.lesson_stages FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));
CREATE POLICY "Authenticated read published stages" ON public.lesson_stages FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.lessons WHERE id = lesson_id AND is_published = true)
);

-- Assets
CREATE POLICY "Content creators full access" ON public.assets FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));
CREATE POLICY "Authenticated read assets" ON public.assets FOR SELECT TO authenticated USING (true);

-- Lexicon entries
CREATE POLICY "Content creators full access" ON public.lexicon_entries FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));
CREATE POLICY "Authenticated read published" ON public.lexicon_entries FOR SELECT TO authenticated USING (is_published = true);

-- Grammar chapters
CREATE POLICY "Content creators full access" ON public.grammar_chapters FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));
CREATE POLICY "Authenticated read published" ON public.grammar_chapters FOR SELECT TO authenticated USING (is_published = true);

-- Pronunciation scripts
CREATE POLICY "Content creators full access" ON public.pronunciation_scripts FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));
CREATE POLICY "Authenticated read published" ON public.pronunciation_scripts FOR SELECT TO authenticated USING (is_published = true);

-- Pragmatics packs
CREATE POLICY "Content creators full access" ON public.pragmatics_packs FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));
CREATE POLICY "Authenticated read published" ON public.pragmatics_packs FOR SELECT TO authenticated USING (is_published = true);

-- Pragmatics items
CREATE POLICY "Content creators full access" ON public.pragmatics_items FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));
CREATE POLICY "Authenticated read published items" ON public.pragmatics_items FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.pragmatics_packs WHERE id = pack_id AND is_published = true)
);

-- Tags (readable by all, editable by content creators)
CREATE POLICY "Anyone can read tags" ON public.tags FOR SELECT TO authenticated USING (true);
CREATE POLICY "Content creators manage tags" ON public.tags FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));

-- Taggings
CREATE POLICY "Anyone can read taggings" ON public.taggings FOR SELECT TO authenticated USING (true);
CREATE POLICY "Content creators manage taggings" ON public.taggings FOR ALL TO authenticated USING (public.is_content_creator(auth.uid())) WITH CHECK (public.is_content_creator(auth.uid()));

-- Updated_at triggers for content tables
CREATE TRIGGER update_courses_updated_at BEFORE UPDATE ON public.courses FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER update_levels_updated_at BEFORE UPDATE ON public.levels FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER update_units_updated_at BEFORE UPDATE ON public.units FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER update_lessons_updated_at BEFORE UPDATE ON public.lessons FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER update_lexicon_updated_at BEFORE UPDATE ON public.lexicon_entries FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER update_grammar_updated_at BEFORE UPDATE ON public.grammar_chapters FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER update_pronunciation_updated_at BEFORE UPDATE ON public.pronunciation_scripts FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER update_pragmatics_packs_updated_at BEFORE UPDATE ON public.pragmatics_packs FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- Indexes
CREATE INDEX idx_levels_course ON public.levels(course_id);
CREATE INDEX idx_units_level ON public.units(level_id);
CREATE INDEX idx_lessons_unit ON public.lessons(unit_id);
CREATE INDEX idx_lesson_stages_lesson ON public.lesson_stages(lesson_id);
CREATE INDEX idx_user_roles_user ON public.user_roles(user_id);
CREATE INDEX idx_taggings_taggable ON public.taggings(taggable_type, taggable_id);
CREATE INDEX idx_lexicon_headword ON public.lexicon_entries(headword);
CREATE INDEX idx_grammar_level ON public.grammar_chapters(cefr_level);

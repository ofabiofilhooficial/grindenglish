-- Fix Asset Linking Display Issues
-- This migration adds views and functions to properly display linked assets

-- Create a view that properly joins lesson_assets with their content
CREATE OR REPLACE VIEW public.lesson_assets_with_content AS
SELECT 
  la.id,
  la.lesson_id,
  la.stage_id,
  la.asset_type,
  la.asset_id,
  la.order_index,
  la.is_required,
  la.context_note,
  la.created_at,
  -- Grammar chapter data
  CASE 
    WHEN la.asset_type = 'grammar' THEN gc.title
    WHEN la.asset_type = 'vocabulary' THEN le.headword
    WHEN la.asset_type = 'pronunciation' THEN le.headword
    WHEN la.asset_type = 'pragmatics' THEN gc.title
    ELSE NULL
  END as asset_title,
  CASE 
    WHEN la.asset_type = 'grammar' THEN gc.chapter_code
    WHEN la.asset_type = 'vocabulary' THEN le.pos
    ELSE NULL
  END as asset_code,
  -- Full grammar chapter
  CASE 
    WHEN la.asset_type = 'grammar' OR la.asset_type = 'pragmatics' 
    THEN jsonb_build_object(
      'id', gc.id,
      'chapter_code', gc.chapter_code,
      'title', gc.title,
      'cefr_level', gc.cefr_level,
      'meaning_content', gc.meaning_content,
      'form_content', gc.form_content,
      'use_content', gc.use_content,
      'contrast_notes', gc.contrast_notes,
      'common_errors', gc.common_errors
    )
    ELSE NULL
  END as grammar_chapter,
  -- Full lexicon entry
  CASE 
    WHEN la.asset_type = 'vocabulary' OR la.asset_type = 'pronunciation'
    THEN jsonb_build_object(
      'id', le.id,
      'headword', le.headword,
      'pos', le.pos,
      'ipa', le.ipa,
      'definition_simple', le.definition_simple,
      'definition_teacher', le.definition_teacher,
      'examples', le.examples,
      'usage_notes', le.usage_notes,
      'register', le.register
    )
    ELSE NULL
  END as lexicon_entry
FROM public.lesson_assets la
LEFT JOIN public.grammar_chapters gc ON la.asset_id = gc.id AND la.asset_type IN ('grammar', 'pragmatics')
LEFT JOIN public.lexicon_entries le ON la.asset_id = le.id AND la.asset_type IN ('vocabulary', 'pronunciation');

-- Create similar view for unit assets
CREATE OR REPLACE VIEW public.unit_assets_with_content AS
SELECT 
  ua.id,
  ua.unit_id,
  ua.asset_type,
  ua.asset_id,
  ua.order_index,
  ua.is_required,
  ua.context_note,
  ua.created_at,
  -- Asset title
  CASE 
    WHEN ua.asset_type = 'grammar' THEN gc.title
    WHEN ua.asset_type = 'vocabulary' THEN le.headword
    WHEN ua.asset_type = 'pronunciation' THEN le.headword
    WHEN ua.asset_type = 'pragmatics' THEN gc.title
    ELSE NULL
  END as asset_title,
  CASE 
    WHEN ua.asset_type = 'grammar' THEN gc.chapter_code
    WHEN ua.asset_type = 'vocabulary' THEN le.pos
    ELSE NULL
  END as asset_code,
  -- Full grammar chapter
  CASE 
    WHEN ua.asset_type = 'grammar' OR ua.asset_type = 'pragmatics' 
    THEN jsonb_build_object(
      'id', gc.id,
      'chapter_code', gc.chapter_code,
      'title', gc.title,
      'cefr_level', gc.cefr_level,
      'meaning_content', gc.meaning_content,
      'form_content', gc.form_content,
      'use_content', gc.use_content,
      'contrast_notes', gc.contrast_notes,
      'common_errors', gc.common_errors
    )
    ELSE NULL
  END as grammar_chapter,
  -- Full lexicon entry
  CASE 
    WHEN ua.asset_type = 'vocabulary' OR ua.asset_type = 'pronunciation'
    THEN jsonb_build_object(
      'id', le.id,
      'headword', le.headword,
      'pos', le.pos,
      'ipa', le.ipa,
      'definition_simple', le.definition_simple,
      'definition_teacher', le.definition_teacher,
      'examples', le.examples,
      'usage_notes', le.usage_notes,
      'register', le.register
    )
    ELSE NULL
  END as lexicon_entry
FROM public.unit_assets ua
LEFT JOIN public.grammar_chapters gc ON ua.asset_id = gc.id AND ua.asset_type IN ('grammar', 'pragmatics')
LEFT JOIN public.lexicon_entries le ON ua.asset_id = le.id AND ua.asset_type IN ('vocabulary', 'pronunciation');

-- Grant access to views
ALTER VIEW public.lesson_assets_with_content OWNER TO postgres;
ALTER VIEW public.unit_assets_with_content OWNER TO postgres;

GRANT SELECT ON public.lesson_assets_with_content TO authenticated;
GRANT SELECT ON public.unit_assets_with_content TO authenticated;

-- Add RLS policies for the views
ALTER VIEW public.lesson_assets_with_content SET (security_invoker = on);
ALTER VIEW public.unit_assets_with_content SET (security_invoker = on);

COMMENT ON VIEW public.lesson_assets_with_content IS 'Lesson assets with full grammar and vocabulary content for display';
COMMENT ON VIEW public.unit_assets_with_content IS 'Unit assets with full grammar and vocabulary content for display';

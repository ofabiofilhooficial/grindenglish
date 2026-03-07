-- Create unit_assets table for unit-level learning targets
-- Students can study these resources before starting lessons

CREATE TABLE public.unit_assets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  unit_id UUID NOT NULL REFERENCES public.units(id) ON DELETE CASCADE,
  asset_type TEXT NOT NULL CHECK (asset_type IN ('grammar', 'vocabulary', 'pronunciation', 'pragmatics')),
  asset_id UUID NOT NULL,
  order_index INT NOT NULL DEFAULT 0,
  is_required BOOLEAN NOT NULL DEFAULT true,
  context_note TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(unit_id, asset_type, asset_id)
);

CREATE INDEX idx_unit_assets_unit ON public.unit_assets(unit_id);
CREATE INDEX idx_unit_assets_type ON public.unit_assets(asset_type);
CREATE INDEX idx_unit_assets_asset ON public.unit_assets(asset_id);

ALTER TABLE public.unit_assets ENABLE ROW LEVEL SECURITY;

COMMENT ON TABLE public.unit_assets IS 'Links units to reference content (grammar chapters, vocabulary entries, etc.) for pre-study';
COMMENT ON COLUMN public.unit_assets.asset_type IS 'Type of linked asset: grammar, vocabulary, pronunciation, or pragmatics';
COMMENT ON COLUMN public.unit_assets.is_required IS 'If true, student should study this asset before starting lessons';
COMMENT ON COLUMN public.unit_assets.context_note IS 'Note about why this asset is important for the unit';

-- RLS Policies
CREATE POLICY "Users can view unit assets for published units"
  ON public.unit_assets FOR SELECT TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.units u
      WHERE u.id = unit_id AND u.is_published = true
    )
  );

CREATE POLICY "Content creators can manage unit assets"
  ON public.unit_assets FOR ALL TO authenticated
  USING (public.is_content_creator(auth.uid()))
  WITH CHECK (public.is_content_creator(auth.uid()));

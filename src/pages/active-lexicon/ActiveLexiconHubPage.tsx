import { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from '@/components/ui/sheet';
import { Badge } from '@/components/ui/badge';
import { Checkbox } from '@/components/ui/checkbox';
import {
  useActiveLexiconLexicon,
  useActiveLexiconEntryDetail,
  useStartLearning,
} from '@/hooks/useActiveLexiconLexicon';
import type { CefrLevel, MasteryStatus } from '@/lib/active-lexicon/types';
import { Loader2, Search, Filter, Play, BookOpen, X } from 'lucide-react';
import { usePageViewTracker } from '@/hooks/useActivityTracker';
import { Link } from 'react-router-dom';

const CEFR_LEVELS: CefrLevel[] = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
const STATUSES: MasteryStatus[] = ['New', 'Learning', 'Mastered'];
const PAGE_SIZE = 50;

export default function ActiveLexiconHubPage() {
  const [searchParams] = useSearchParams();
  const highlightId = searchParams.get('highlight');
  const [search, setSearch] = useState('');
  const [cefrLevels, setCefrLevels] = useState<CefrLevel[]>([]);
  const [units, setUnits] = useState<string[]>([]);
  const [statuses, setStatuses] = useState<MasteryStatus[]>([]);
  const [page, setPage] = useState(1);
  const [detailId, setDetailId] = useState<string | null>(highlightId || null);
  const [filterOpen, setFilterOpen] = useState(false);

  const filters = {
    search: search || undefined,
    cefr_levels: cefrLevels.length ? cefrLevels : undefined,
    units: units.length ? units : undefined,
    statuses: statuses.length ? statuses : undefined,
  };

  const { data, loading, refetch } = useActiveLexiconLexicon(filters, page, PAGE_SIZE);
  const { data: detail, isLoading: detailLoading } = useActiveLexiconEntryDetail(detailId);
  const startLearningMutation = useStartLearning();

  usePageViewTracker('active_lexicon_hub_view');

  useEffect(() => {
    if (highlightId) setDetailId(highlightId);
  }, [highlightId]);

  const toggleCefr = (level: CefrLevel) =>
    setCefrLevels((prev) =>
      prev.includes(level) ? prev.filter((l) => l !== level) : [...prev, level]
    );
  const toggleStatus = (s: MasteryStatus) =>
    setStatuses((prev) =>
      prev.includes(s) ? prev.filter((x) => x !== s) : [...prev, s]
    );

  const handleKeyDown = useCallback(
    (e: KeyboardEvent) => {
      if (e.key === 's' && !['INPUT', 'TEXTAREA'].includes((e.target as HTMLElement)?.tagName)) {
        e.preventDefault();
        document.getElementById('lexicon-search')?.focus();
      }
      if (e.key === 'f' && !['INPUT', 'TEXTAREA'].includes((e.target as HTMLElement)?.tagName)) {
        e.preventDefault();
        setFilterOpen((o) => !o);
      }
      if (e.key === 'Escape') {
        setDetailId(null);
        setFilterOpen(false);
      }
    },
    []
  );

  useEffect(() => {
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [handleKeyDown]);

  const items = data?.items ?? [];
  const totalCount = data?.total_count ?? 0;
  const totalPages = Math.max(1, Math.ceil(totalCount / PAGE_SIZE));

  return (
    <AppLayout title="Lexicon Hub" subtitle="Browse and start learning vocabulary">
      <div className="p-6 max-w-6xl mx-auto space-y-4">
        <div className="flex flex-col sm:flex-row gap-4">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
            <Input
              id="lexicon-search"
              type="search"
              placeholder="Search vocabulary…"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="pl-9"
              aria-label="Search vocabulary"
            />
          </div>
          <Button
            variant="outline"
            onClick={() => setFilterOpen((o) => !o)}
            aria-expanded={filterOpen}
            aria-controls="filter-panel"
          >
            <Filter className="h-4 w-4 mr-2" />
            Filters
          </Button>
        </div>

        {filterOpen && (
          <Card id="filter-panel" role="region" aria-label="Filter panel">
            <CardHeader>
              <CardTitle className="text-base">Filter by</CardTitle>
            </CardHeader>
            <CardContent className="flex flex-wrap gap-6">
              <fieldset>
                <legend className="text-sm font-medium mb-2">CEFR Level</legend>
                <div className="flex flex-wrap gap-2">
                  {CEFR_LEVELS.map((level) => (
                    <label key={level} className="flex items-center gap-2">
                      <Checkbox
                        checked={cefrLevels.includes(level)}
                        onCheckedChange={() => toggleCefr(level)}
                      />
                      {level}
                    </label>
                  ))}
                </div>
              </fieldset>
              <fieldset>
                <legend className="text-sm font-medium mb-2">Status</legend>
                <div className="flex flex-wrap gap-2">
                  {STATUSES.map((s) => (
                    <label key={s} className="flex items-center gap-2">
                      <Checkbox
                        checked={statuses.includes(s)}
                        onCheckedChange={() => toggleStatus(s)}
                      />
                      {s}
                    </label>
                  ))}
                </div>
              </fieldset>
            </CardContent>
          </Card>
        )}

        <Card>
          <CardContent className="p-0">
            {loading ? (
              <div className="flex items-center justify-center py-12 gap-2 text-muted-foreground">
                <Loader2 className="h-5 w-5 animate-spin" />
                Loading…
              </div>
            ) : (
              <>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>English Word</TableHead>
                      <TableHead>CEFR</TableHead>
                      <TableHead>Unit</TableHead>
                      <TableHead>Status</TableHead>
                      <TableHead className="w-10" />
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {items.map((row) => (
                      <TableRow
                        key={row.lexicon_entry_id}
                        className="cursor-pointer"
                        onClick={() => setDetailId(row.lexicon_entry_id)}
                        aria-label={`${row.english_word}, ${row.cefr_level}, ${row.unit}, ${row.mastery_status}`}
                      >
                        <TableCell className="font-medium">{row.english_word}</TableCell>
                        <TableCell>{row.cefr_level}</TableCell>
                        <TableCell>{row.unit}</TableCell>
                        <TableCell>
                          <Badge variant="secondary">{row.mastery_status}</Badge>
                        </TableCell>
                        <TableCell>
                          <Button
                            variant="ghost"
                            size="icon"
                            onClick={(e) => {
                              e.stopPropagation();
                              setDetailId(row.lexicon_entry_id);
                            }}
                            aria-label="View details"
                          >
                            <BookOpen className="h-4 w-4" />
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
                {totalPages > 1 && (
                  <div className="flex items-center justify-between border-t px-4 py-2">
                    <p className="text-sm text-muted-foreground">
                      Page {page} of {totalPages} · {totalCount} total
                    </p>
                    <div className="flex gap-2">
                      <Button
                        variant="outline"
                        size="sm"
                        disabled={page <= 1}
                        onClick={() => setPage((p) => p - 1)}
                      >
                        Previous
                      </Button>
                      <Button
                        variant="outline"
                        size="sm"
                        disabled={page >= totalPages}
                        onClick={() => setPage((p) => p + 1)}
                      >
                        Next
                      </Button>
                    </div>
                  </div>
                )}
              </>
            )}
          </CardContent>
        </Card>
      </div>

      <Sheet open={!!detailId} onOpenChange={(open) => !open && setDetailId(null)}>
        <SheetContent className="flex flex-col sm:max-w-lg">
          <SheetHeader className="flex flex-row items-center justify-between">
            <SheetTitle>Word details</SheetTitle>
            <Button
              variant="ghost"
              size="icon"
              onClick={() => setDetailId(null)}
              aria-label="Close panel"
            >
              <X className="h-4 w-4" />
            </Button>
          </SheetHeader>
          <div className="flex-1 overflow-auto pt-4">
            {detailId && (
              <DetailPanel
                detail={detail}
                loading={detailLoading}
                onStartLearning={async () => {
                  await startLearningMutation.mutateAsync(detailId);
                  refetch();
                }}
                startLearningLoading={startLearningMutation.isPending}
              />
            )}
          </div>
        </SheetContent>
      </Sheet>
    </AppLayout>
  );
}

function DetailPanel({
  detail,
  loading,
  onStartLearning,
  startLearningLoading,
}: {
  detail: ReturnType<typeof useActiveLexiconEntryDetail>['data'];
  loading: boolean;
  onStartLearning: () => Promise<unknown>;
  startLearningLoading: boolean;
}) {
  if (loading || !detail) {
    return (
      <div className="flex items-center gap-2 text-muted-foreground">
        <Loader2 className="h-4 w-4 animate-spin" />
        Loading…
      </div>
    );
  }

  return (
    <div className="space-y-4" role="region" aria-label="Revealed content">
      <div>
        <p className="text-sm text-muted-foreground" aria-label={`English word: ${detail.english_word}`}>
          {detail.english_word}
        </p>
        <p className="font-medium text-lg">{detail.definition}</p>
      </div>
      <p className="text-sm" aria-label="Example sentence">
        {detail.example_sentence}
      </p>
      <div className="flex items-center gap-2">
        <Badge>{detail.cefr_level}</Badge>
        <Badge variant="outline">{detail.unit}</Badge>
        <Badge variant="secondary">{detail.mastery_status}</Badge>
      </div>
      {detail.audio_url && (
        <div>
          <audio controls src={detail.audio_url} className="w-full" aria-label="Pronunciation" />
        </div>
      )}
      {detail.l1_notes && (
        <div className="p-3 rounded-lg bg-muted/50" aria-label={`L1 Notes: ${detail.l1_notes}`}>
          <p className="text-sm font-medium mb-1">L1 notes</p>
          <p className="text-sm">{detail.l1_notes}</p>
        </div>
      )}
      <Link to="/active-lexicon/practice">
        <Button
          className="min-h-[44px] w-full"
          onClick={onStartLearning}
          disabled={startLearningLoading}
          aria-label="Start learning this word"
        >
          {startLearningLoading ? (
            <Loader2 className="h-4 w-4 animate-spin mr-2" />
          ) : (
            <Play className="h-4 w-4 mr-2" />
          )}
          Start learning
        </Button>
      </Link>
    </div>
  );
}

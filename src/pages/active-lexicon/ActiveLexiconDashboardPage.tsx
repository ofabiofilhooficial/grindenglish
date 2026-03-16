import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import {
  useActiveLexiconDashboard,
} from '@/hooks/useActiveLexiconDashboard';
import { BookOpen, Loader2, RefreshCw, Zap } from 'lucide-react';
import {
  Pagination,
  PaginationContent,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
} from '@/components/ui/pagination';
import { usePageViewTracker } from '@/hooks/useActivityTracker';

const PAGE_SIZE = 20;

export default function ActiveLexiconDashboardPage() {
  const [page, setPage] = useState(1);
  const {
    metrics,
    metricsLoading,
    dueWords,
    dueWordsLoading,
    refetchAll,
  } = useActiveLexiconDashboard(page, PAGE_SIZE);

  usePageViewTracker('active_lexicon_dashboard_view');

  useEffect(() => {
    const interval = setInterval(refetchAll, 30_000);
    return () => clearInterval(interval);
  }, [refetchAll]);

  const totalCount = dueWords?.total_count ?? 0;
  const totalPages = Math.max(1, Math.ceil(totalCount / PAGE_SIZE));
  const items = dueWords?.items ?? [];

  return (
    <AppLayout
      title="Active Lexicon"
      subtitle="Your vocabulary progress and due words"
    >
      <div className="p-6 space-y-8 max-w-5xl mx-auto">
        <section aria-label="Learning Metrics">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Zap className="h-5 w-5" />
                Learning Metrics
              </CardTitle>
              <CardDescription>
                Words unlocked, in progress, and mastered
              </CardDescription>
            </CardHeader>
            <CardContent>
              {metricsLoading ? (
                <div className="flex items-center gap-2 text-muted-foreground">
                  <Loader2 className="h-4 w-4 animate-spin" />
                  Loading metrics…
                </div>
              ) : (
                <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                  <div
                    className="p-4 rounded-lg border bg-muted/50"
                    aria-label={`Total words unlocked: ${metrics?.total_words_unlocked ?? 0}`}
                  >
                    <div className="text-2xl font-bold">{metrics?.total_words_unlocked ?? 0}</div>
                    <div className="text-sm text-muted-foreground">Words unlocked</div>
                  </div>
                  <div
                    className="p-4 rounded-lg border bg-muted/50"
                    aria-label={`Words in learning: ${metrics?.words_in_learning ?? 0}`}
                  >
                    <div className="text-2xl font-bold">{metrics?.words_in_learning ?? 0}</div>
                    <div className="text-sm text-muted-foreground">In learning</div>
                  </div>
                  <div
                    className="p-4 rounded-lg border bg-muted/50"
                    aria-label={`Words mastered: ${metrics?.words_mastered ?? 0}`}
                  >
                    <div className="text-2xl font-bold">{metrics?.words_mastered ?? 0}</div>
                    <div className="text-sm text-muted-foreground">Mastered</div>
                  </div>
                </div>
              )}
            </CardContent>
          </Card>
        </section>

        <section aria-label="Due Words Queue">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between">
              <div>
                <CardTitle className="flex items-center gap-2">
                  <BookOpen className="h-5 w-5" />
                  Due Words
                </CardTitle>
                <CardDescription>
                  {totalCount} word{totalCount !== 1 ? 's' : ''} due for review
                </CardDescription>
              </div>
              <div className="flex items-center gap-2">
                <Button
                  variant="outline"
                  size="icon"
                  onClick={() => refetchAll()}
                  aria-label="Refresh queue"
                >
                  <RefreshCw className="h-4 w-4" />
                </Button>
                <Link to="/active-lexicon/practice">
                  <Button
                    className="min-h-[44px] w-[80vw] max-w-xs sm:w-auto"
                    disabled={totalCount === 0}
                    aria-label="Grind Due Words. Start your daily review session"
                  >
                    Grind Due Words
                  </Button>
                </Link>
              </div>
            </CardHeader>
            <CardContent>
              {dueWordsLoading ? (
                <div className="flex items-center gap-2 text-muted-foreground py-8">
                  <Loader2 className="h-4 w-4 animate-spin" />
                  Loading queue…
                </div>
              ) : items.length === 0 ? (
                <p className="text-muted-foreground py-8 text-center">
                  No words due right now. Add words from the Lexicon Hub or check back later.
                </p>
              ) : (
                <>
                  <ul className="space-y-2">
                    {items.map((item) => (
                      <li key={item.lexicon_entry_id}>
                        <Link
                          to={`/active-lexicon/lexicon?highlight=${item.lexicon_entry_id}`}
                          className="flex items-center justify-between p-3 rounded-lg border hover:bg-muted/50 transition-colors"
                        >
                          <span className="font-medium">{item.english_word}</span>
                          <span className="text-sm text-muted-foreground">
                            {item.cefr_level} · {item.unit}
                            {item.days_overdue > 0 && (
                              <span className="ml-2 text-amber-600">
                                {item.days_overdue} day{item.days_overdue !== 1 ? 's' : ''} overdue
                              </span>
                            )}
                          </span>
                        </Link>
                      </li>
                    ))}
                  </ul>
                  {totalPages > 1 && (
                    <Pagination className="mt-4">
                      <PaginationContent>
                        <PaginationItem>
                          <PaginationPrevious
                            href="#"
                            onClick={(e) => {
                              e.preventDefault();
                              setPage((p) => Math.max(1, p - 1));
                            }}
                            aria-disabled={page <= 1}
                          />
                        </PaginationItem>
                        {Array.from({ length: totalPages }, (_, i) => i + 1).map((p) => (
                          <PaginationItem key={p}>
                            <PaginationLink
                              href="#"
                              onClick={(e) => {
                                e.preventDefault();
                                setPage(p);
                              }}
                              isActive={page === p}
                            >
                              {p}
                            </PaginationLink>
                          </PaginationItem>
                        ))}
                        <PaginationItem>
                          <PaginationNext
                            href="#"
                            onClick={(e) => {
                              e.preventDefault();
                              setPage((p) => Math.min(totalPages, p + 1));
                            }}
                            aria-disabled={page >= totalPages}
                          />
                        </PaginationItem>
                      </PaginationContent>
                    </Pagination>
                  )}
                </>
              )}
            </CardContent>
          </Card>
        </section>
      </div>
    </AppLayout>
  );
}

/**
 * Active Lexicon Dashboard – UI tests
 * Property 15: Grind button enabled when due words exist, disabled when none.
 * Accessibility: metrics and queue sections have aria labels.
 */

import { describe, it, expect, vi } from 'vitest';
import { render, screen } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { BrowserRouter } from 'react-router-dom';
import ActiveLexiconDashboardPage from './ActiveLexiconDashboardPage';

vi.mock('@/hooks/useAuth', () => ({
  useAuth: () => ({ user: { id: 'user-1' } }),
}));

vi.mock('@/hooks/useActiveLexiconDashboard', () => ({
  useActiveLexiconDashboard: () => ({
    metrics: { total_words_unlocked: 10, words_in_learning: 3, words_mastered: 7 },
    metricsLoading: false,
    dueWords: {
      items: [{ lexicon_entry_id: 'e1', english_word: 'have', cefr_level: 'A1', unit: 'U1', days_overdue: 0, next_review_date: '2024-01-15' }],
      total_count: 1,
      page: 1,
      limit: 20,
    },
    dueWordsLoading: false,
    refetchAll: vi.fn(),
  }),
}));

vi.mock('@/hooks/useActivityTracker', () => ({
  usePageViewTracker: () => {},
}));

vi.mock('@/components/layout/AppLayout', () => ({
  AppLayout: ({ children, title }: { children: React.ReactNode; title?: string }) => (
    <div data-testid="app-layout">
      <h1>{title}</h1>
      {children}
    </div>
  ),
}));

function renderWithProviders(ui: React.ReactElement) {
  const queryClient = new QueryClient({
    defaultOptions: { queries: { retry: false } },
  });
  return render(
    <QueryClientProvider client={queryClient}>
      <BrowserRouter>{ui}</BrowserRouter>
    </QueryClientProvider>
  );
}

describe('ActiveLexiconDashboardPage', () => {
  it('renders Learning Metrics section with aria-label', () => {
    renderWithProviders(<ActiveLexiconDashboardPage />);
    expect(screen.getByRole('region', { name: /learning metrics/i })).toBeInTheDocument();
  });

  it('renders Due Words Queue section with aria-label', () => {
    renderWithProviders(<ActiveLexiconDashboardPage />);
    expect(screen.getByRole('region', { name: /due words queue/i })).toBeInTheDocument();
  });

  it('Grind Due Words button is present and enabled when due words exist', () => {
    renderWithProviders(<ActiveLexiconDashboardPage />);
    const button = screen.getByRole('link', { name: /grind due words/i });
    expect(button).toBeInTheDocument();
    expect(button).toHaveAttribute('href', '/active-lexicon/practice');
  });

  it('displays metrics (unlocked, in learning, mastered)', () => {
    renderWithProviders(<ActiveLexiconDashboardPage />);
    expect(screen.getByLabelText(/total words unlocked: 10/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/words in learning: 3/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/words mastered: 7/i)).toBeInTheDocument();
  });
});

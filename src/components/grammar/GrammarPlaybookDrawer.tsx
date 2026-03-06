import { useState, useEffect, useRef } from 'react';
import { Sheet, SheetContent, SheetHeader, SheetTitle } from '@/components/ui/sheet';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent } from '@/components/ui/card';
import { Separator } from '@/components/ui/separator';
import { Button } from '@/components/ui/button';
import { AlertTriangle, CheckCircle2, XCircle, ArrowUpCircle, Link2, Lightbulb, BookOpen, MessageSquare, Languages, Target } from 'lucide-react';
import { cn } from '@/lib/utils';
import { InteractiveTask } from '@/types/course';

interface GrammarChapterData {
  id: string;
  chapter_code: string;
  title: string;
  cefr_level: string;
  diagnostic_hook?: string;
  meaning_content?: string;
  form_content?: string;
  use_content?: string;
  contrast_notes?: string;
  common_errors?: string;
  task_upgrades?: string;
  micro_practice?: InteractiveTask[] | string;
  cross_links?: string[] | string;
}

interface GrammarPlaybookDrawerProps {
  chapter: GrammarChapterData | null;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

interface Section {
  id: string;
  title: string;
  icon: React.ReactNode;
  content?: string | string[] | InteractiveTask[];
}

export function GrammarPlaybookDrawer({ chapter, open, onOpenChange }: GrammarPlaybookDrawerProps) {
  const [activeSection, setActiveSection] = useState<string>('');
  const contentRefs = useRef<{ [key: string]: HTMLDivElement | null }>({});
  const scrollAreaRef = useRef<HTMLDivElement>(null);

  const parsedMicroPractice = typeof chapter?.micro_practice === 'string' ? JSON.parse(chapter.micro_practice || '[]') : chapter?.micro_practice || [];
  const parsedCrossLinks = typeof chapter?.cross_links === 'string' ? JSON.parse(chapter.cross_links || '[]') : chapter?.cross_links || [];

  const sections: Section[] = [];
  if (chapter?.diagnostic_hook) sections.push({ id: 'diagnostic', title: 'Diagnostic Hook', icon: <Lightbulb className="h-4 w-4" />, content: chapter.diagnostic_hook });
  if (chapter?.meaning_content) sections.push({ id: 'meaning', title: 'Meaning', icon: <BookOpen className="h-4 w-4" />, content: chapter.meaning_content });
  if (chapter?.form_content) sections.push({ id: 'form', title: 'Form (Structure)', icon: <Target className="h-4 w-4" />, content: chapter.form_content });
  if (chapter?.use_content) sections.push({ id: 'use', title: 'Use (Context)', icon: <MessageSquare className="h-4 w-4" />, content: chapter.use_content });
  if (chapter?.contrast_notes) sections.push({ id: 'contrast', title: 'L1 Contrast (pt-BR)', icon: <Languages className="h-4 w-4" />, content: chapter.contrast_notes });
  if (chapter?.common_errors) sections.push({ id: 'errors', title: 'Common Errors', icon: <AlertTriangle className="h-4 w-4" />, content: chapter.common_errors });
  if (chapter?.task_upgrades) sections.push({ id: 'upgrades', title: 'Upgrades', icon: <ArrowUpCircle className="h-4 w-4" />, content: chapter.task_upgrades });
  if (parsedMicroPractice.length > 0) sections.push({ id: 'practice', title: 'Micro-Practice', icon: <CheckCircle2 className="h-4 w-4" />, content: parsedMicroPractice });
  if (parsedCrossLinks.length > 0) sections.push({ id: 'links', title: 'Links / Next Steps', icon: <Link2 className="h-4 w-4" />, content: parsedCrossLinks });

  useEffect(() => {
    if (!open || sections.length === 0) return;
    const handleScroll = () => {
      const scrollContainer = scrollAreaRef.current?.querySelector('[data-radix-scroll-area-viewport]');
      if (!scrollContainer) return;
      let currentSection = sections[0].id;
      let maxVisibility = 0;
      sections.forEach(section => {
        const element = contentRefs.current[section.id];
        if (!element) return;
        const rect = element.getBoundingClientRect();
        const containerRect = scrollContainer.getBoundingClientRect();
        const visibleTop = Math.max(rect.top, containerRect.top);
        const visibleBottom = Math.min(rect.bottom, containerRect.bottom);
        const visibleHeight = Math.max(0, visibleBottom - visibleTop);
        if (visibleHeight > maxVisibility) {
          maxVisibility = visibleHeight;
          currentSection = section.id;
        }
      });
      setActiveSection(currentSection);
    };
    const scrollContainer = scrollAreaRef.current?.querySelector('[data-radix-scroll-area-viewport]');
    scrollContainer?.addEventListener('scroll', handleScroll);
    if (sections.length > 0) setActiveSection(sections[0].id);
    return () => scrollContainer?.removeEventListener('scroll', handleScroll);
  }, [open, sections.length]);

  const scrollToSection = (sectionId: string) => {
    const element = contentRefs.current[sectionId];
    if (element) element.scrollIntoView({ behavior: 'smooth', block: 'start' });
  };

  if (!chapter) return null;

  return (
    <Sheet open={open} onOpenChange={onOpenChange}>
      <SheetContent side="right" className="w-full sm:max-w-4xl p-0 flex flex-col">
        <SheetHeader className="px-6 py-4 border-b bg-[#0B1630] text-[#F3EBDD]">
          <div className="flex items-start gap-3">
            <div className="flex-1">
              <SheetTitle className="text-xl font-display uppercase tracking-wide text-[#F3EBDD]">{chapter.title}</SheetTitle>
              <div className="flex gap-2 mt-2">
                <Badge variant="outline" className="bg-[#F3EBDD] text-[#0B1630] border-[#F3EBDD]">{chapter.cefr_level}</Badge>
                <Badge variant="secondary" className="font-mono text-xs bg-[#F3EBDD]/20 text-[#F3EBDD]">{chapter.chapter_code}</Badge>
              </div>
            </div>
          </div>
        </SheetHeader>
        <div className="flex flex-1 overflow-hidden">
          <nav className="w-56 border-r bg-muted/30 p-4 overflow-y-auto">
            <p className="text-xs font-semibold uppercase tracking-wider text-muted-foreground mb-3">Contents</p>
            <div className="space-y-1">
              {sections.map((section) => (
                <Button key={section.id} variant="ghost" size="sm" className={cn("w-full justify-start text-left font-normal", activeSection === section.id && "bg-accent text-accent-foreground")} onClick={() => scrollToSection(section.id)}>
                  <span className="mr-2">{section.icon}</span>
                  <span className="text-sm">{section.title}</span>
                </Button>
              ))}
            </div>
          </nav>
          <ScrollArea ref={scrollAreaRef} className="flex-1">
            <div className="p-6 space-y-8 max-w-3xl">
              {sections.map((section, index) => (
                <div key={section.id} ref={(el) => (contentRefs.current[section.id] = el)} className="scroll-mt-6">
                  <SectionRenderer section={section} />
                  {index < sections.length - 1 && <Separator className="mt-8" />}
                </div>
              ))}
            </div>
          </ScrollArea>
        </div>
      </SheetContent>
    </Sheet>
  );
}

function SectionRenderer({ section }: { section: Section }) {
  return (
    <div className="space-y-4">
      <div className="flex items-center gap-2">
        <div className="text-[#0B1630]">{section.icon}</div>
        <h3 className="text-lg font-display font-semibold uppercase tracking-wide text-[#0B1630]">{section.title}</h3>
      </div>
      {section.id === 'diagnostic' && typeof section.content === 'string' && <DiagnosticHookBlock content={section.content} />}
      {section.id === 'meaning' && typeof section.content === 'string' && <MeaningBlock content={section.content} />}
      {section.id === 'form' && typeof section.content === 'string' && <FormBlock content={section.content} />}
      {section.id === 'use' && typeof section.content === 'string' && <UseBlock content={section.content} />}
      {section.id === 'contrast' && typeof section.content === 'string' && <L1ContrastBlock content={section.content} />}
      {section.id === 'errors' && typeof section.content === 'string' && <ErrorCorrectionBlock content={section.content} />}
      {section.id === 'upgrades' && typeof section.content === 'string' && <UpgradesBlock content={section.content} />}
      {section.id === 'practice' && Array.isArray(section.content) && <MicroPracticeBlock tasks={section.content as InteractiveTask[]} />}
      {section.id === 'links' && Array.isArray(section.content) && <CrossLinksBlock links={section.content as string[]} />}
    </div>
  );
}

function DiagnosticHookBlock({ content }: { content: string }) {
  return <Card className="border-l-4 border-l-[#D61F3A] bg-[#D61F3A]/5"><CardContent className="pt-4"><p className="text-sm leading-relaxed whitespace-pre-wrap">{content}</p></CardContent></Card>;
}

function MeaningBlock({ content }: { content: string }) {
  return <div className="prose prose-sm max-w-none"><p className="text-base leading-relaxed whitespace-pre-wrap">{content}</p></div>;
}

function FormBlock({ content }: { content: string }) {
  return <Card className="bg-muted/50"><CardContent className="pt-4"><pre className="whitespace-pre-wrap text-sm font-mono leading-relaxed">{content}</pre></CardContent></Card>;
}

function UseBlock({ content }: { content: string }) {
  return <div className="prose prose-sm max-w-none"><p className="text-sm leading-relaxed whitespace-pre-wrap">{content}</p></div>;
}

function L1ContrastBlock({ content }: { content: string }) {
  return <Card className="border-l-4 border-l-yellow-500 bg-yellow-50 dark:bg-yellow-950/20"><CardContent className="pt-4"><p className="text-sm leading-relaxed whitespace-pre-wrap">{content}</p></CardContent></Card>;
}

function ErrorCorrectionBlock({ content }: { content: string }) {
  const lines = content.split('\n').filter(line => line.trim());
  return (
    <div className="space-y-3">
      {lines.map((line, index) => {
        const isIncorrect = line.toLowerCase().includes('incorrect') || line.toLowerCase().includes('missing') || line.toLowerCase().includes('wrong');
        const isCorrect = line.toLowerCase().includes('correct') || line.toLowerCase().includes('fix:');
        return (
          <div key={index} className="flex items-start gap-3">
            {isIncorrect && <XCircle className="h-5 w-5 text-[#D61F3A] flex-shrink-0 mt-0.5" />}
            {isCorrect && <CheckCircle2 className="h-5 w-5 text-green-600 flex-shrink-0 mt-0.5" />}
            {!isIncorrect && !isCorrect && <span className="w-5" />}
            <p className="text-sm leading-relaxed flex-1">{line}</p>
          </div>
        );
      })}
    </div>
  );
}

function UpgradesBlock({ content }: { content: string }) {
  return <Card className="bg-gradient-to-br from-blue-50 to-indigo-50 dark:from-blue-950/20 dark:to-indigo-950/20"><CardContent className="pt-4"><p className="text-sm leading-relaxed whitespace-pre-wrap">{content}</p></CardContent></Card>;
}

function MicroPracticeBlock({ tasks }: { tasks: InteractiveTask[] }) {
  return (
    <div className="space-y-4">
      {tasks.map((task, index) => (
        <Card key={task.id || index} className="border-2 border-primary/20">
          <CardContent className="pt-4">
            <p className="font-medium mb-2">{task.question}</p>
            {task.options && (
              <div className="space-y-2 mt-3">
                {task.options.map((option, optIndex) => (
                  <div key={optIndex} className="flex items-center gap-2">
                    <div className="w-6 h-6 rounded-full border-2 border-muted-foreground/30 flex items-center justify-center text-xs">{String.fromCharCode(65 + optIndex)}</div>
                    <span className="text-sm">{option}</span>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>
      ))}
    </div>
  );
}

function CrossLinksBlock({ links }: { links: string[] }) {
  return (
    <div className="flex flex-wrap gap-2">
      {links.map((link, index) => (
        <Badge key={index} variant="outline" className="text-sm px-3 py-1">
          <Link2 className="h-3 w-3 mr-1" />
          {link}
        </Badge>
      ))}
    </div>
  );
}

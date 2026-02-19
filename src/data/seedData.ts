// English Mastery Lab - Configuration Data
// CEFR level configuration (not placeholder — used for UI rendering)

import { CEFRLevel } from '@/types/course';

export const CEFR_LEVEL_CONFIG: Record<CEFRLevel, { 
  name: string; 
  description: string; 
  color: string;
  gradient: string;
  unitCount: number;
  hoursEstimate: number;
}> = {
  A0: {
    name: 'Pre-A1 (Breakthrough)',
    description: 'First steps in English. Basic survival phrases and foundational vocabulary.',
    color: 'hsl(var(--level-a0))',
    gradient: 'from-purple-500 to-violet-600',
    unitCount: 6,
    hoursEstimate: 30,
  },
  A1: {
    name: 'A1 (Elementary)',
    description: 'Simple everyday expressions and basic phrases for practical needs.',
    color: 'hsl(var(--level-a1))',
    gradient: 'from-violet-500 to-indigo-600',
    unitCount: 10,
    hoursEstimate: 50,
  },
  A2: {
    name: 'A2 (Pre-Intermediate)',
    description: 'Routine tasks and direct exchange of information on familiar topics.',
    color: 'hsl(var(--level-a2))',
    gradient: 'from-blue-500 to-cyan-600',
    unitCount: 10,
    hoursEstimate: 60,
  },
  B1: {
    name: 'B1 (Intermediate)',
    description: 'Handle most travel situations, describe experiences, give reasons and explanations.',
    color: 'hsl(var(--level-b1))',
    gradient: 'from-teal-500 to-emerald-600',
    unitCount: 10,
    hoursEstimate: 80,
  },
  B2: {
    name: 'B2 (Upper-Intermediate)',
    description: 'Interact with fluency and spontaneity, produce detailed text on wide range of subjects.',
    color: 'hsl(var(--level-b2))',
    gradient: 'from-emerald-500 to-green-600',
    unitCount: 10,
    hoursEstimate: 100,
  },
  C1: {
    name: 'C1 (Advanced)',
    description: 'Express ideas fluently and spontaneously without obvious searching for expressions.',
    color: 'hsl(var(--level-c1))',
    gradient: 'from-amber-500 to-orange-600',
    unitCount: 8,
    hoursEstimate: 120,
  },
  C2: {
    name: 'C2 (Mastery)',
    description: 'Understand with ease virtually everything heard or read. Express precisely and fluently.',
    color: 'hsl(var(--level-c2))',
    gradient: 'from-orange-500 to-red-600',
    unitCount: 8,
    hoursEstimate: 150,
  },
};

import * as React from "react";
import { cn } from "@/lib/utils";
import { CEFRLevel } from "@/types/course";

interface LevelBadgeProps {
  level: CEFRLevel;
  size?: 'sm' | 'md' | 'lg';
  className?: string;
}

const levelStyles: Record<CEFRLevel, string> = {
  A0: 'bg-level-a0 text-white',
  A1: 'bg-level-a1 text-white',
  A2: 'bg-level-a2 text-white',
  B1: 'bg-level-b1 text-white',
  B2: 'bg-level-b2 text-white',
  C1: 'bg-level-c1 text-white',
  C2: 'bg-level-c2 text-white',
};

const sizeStyles = {
  sm: 'px-2 py-0.5 text-xs font-medium',
  md: 'px-3 py-1 text-sm font-semibold',
  lg: 'px-4 py-1.5 text-base font-bold',
};

const LevelBadge = React.forwardRef<HTMLSpanElement, LevelBadgeProps>(
  ({ level, size = 'md', className }, ref) => {
    return (
      <span
        ref={ref}
        className={cn(
          "inline-flex items-center justify-center rounded-full shadow-sm",
          levelStyles[level],
          sizeStyles[size],
          className
        )}
      >
        {level}
      </span>
    );
  }
);

LevelBadge.displayName = "LevelBadge";

export { LevelBadge };

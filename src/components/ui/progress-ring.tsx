import * as React from "react";
import { cn } from "@/lib/utils";

interface ProgressRingProps {
  progress: number;
  size?: number;
  strokeWidth?: number;
  className?: string;
  children?: React.ReactNode;
  variant?: 'default' | 'accent' | 'success';
}

const ProgressRing = React.forwardRef<SVGSVGElement, ProgressRingProps>(
  ({ progress, size = 80, strokeWidth = 6, className, children, variant = 'default' }, ref) => {
    const radius = (size - strokeWidth) / 2;
    const circumference = radius * 2 * Math.PI;
    const offset = circumference - (progress / 100) * circumference;

    const strokeColors = {
      default: 'stroke-primary',
      accent: 'stroke-accent',
      success: 'stroke-success',
    };

    return (
      <div className={cn("relative inline-flex items-center justify-center", className)}>
        <svg
          ref={ref}
          width={size}
          height={size}
          className="-rotate-90 transform"
        >
          {/* Background circle */}
          <circle
            cx={size / 2}
            cy={size / 2}
            r={radius}
            className="stroke-muted fill-none"
            strokeWidth={strokeWidth}
          />
          {/* Progress circle */}
          <circle
            cx={size / 2}
            cy={size / 2}
            r={radius}
            className={cn("fill-none transition-all duration-500 ease-out", strokeColors[variant])}
            strokeWidth={strokeWidth}
            strokeDasharray={circumference}
            strokeDashoffset={offset}
            strokeLinecap="round"
          />
        </svg>
        {children && (
          <div className="absolute inset-0 flex items-center justify-center">
            {children}
          </div>
        )}
      </div>
    );
  }
);

ProgressRing.displayName = "ProgressRing";

export { ProgressRing };

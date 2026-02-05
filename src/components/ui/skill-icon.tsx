import * as React from "react";
import { cn } from "@/lib/utils";
import { SkillType } from "@/types/course";
import { 
  Headphones, 
  BookOpen, 
  Mic, 
  PenTool, 
  Languages, 
  BookText, 
  Speech, 
  Users,
  Zap,
  Waves
} from "lucide-react";

interface SkillIconProps {
  skill: SkillType;
  size?: number;
  className?: string;
  showLabel?: boolean;
}

const skillConfig: Record<SkillType, { icon: React.ElementType; label: string; colorClass: string }> = {
  listening: { icon: Headphones, label: 'Listening', colorClass: 'text-skill-listening bg-skill-listening/10' },
  reading: { icon: BookOpen, label: 'Reading', colorClass: 'text-skill-reading bg-skill-reading/10' },
  speaking: { icon: Mic, label: 'Speaking', colorClass: 'text-skill-speaking bg-skill-speaking/10' },
  writing: { icon: PenTool, label: 'Writing', colorClass: 'text-skill-writing bg-skill-writing/10' },
  grammar: { icon: Languages, label: 'Grammar', colorClass: 'text-skill-grammar bg-skill-grammar/10' },
  vocabulary: { icon: BookText, label: 'Vocabulary', colorClass: 'text-skill-vocabulary bg-skill-vocabulary/10' },
  pronunciation: { icon: Waves, label: 'Pronunciation', colorClass: 'text-skill-pronunciation bg-skill-pronunciation/10' },
  pragmatics: { icon: Speech, label: 'Pragmatics', colorClass: 'text-skill-pragmatics bg-skill-pragmatics/10' },
  mediation: { icon: Users, label: 'Mediation', colorClass: 'text-primary bg-primary/10' },
  fluency: { icon: Zap, label: 'Fluency', colorClass: 'text-accent bg-accent/10' },
};

const SkillIcon = React.forwardRef<HTMLDivElement, SkillIconProps>(
  ({ skill, size = 20, className, showLabel = false }, ref) => {
    const config = skillConfig[skill];
    const Icon = config.icon;

    return (
      <div 
        ref={ref}
        className={cn(
          "inline-flex items-center gap-2 rounded-lg p-2",
          config.colorClass,
          className
        )}
      >
        <Icon size={size} />
        {showLabel && (
          <span className="text-sm font-medium">{config.label}</span>
        )}
      </div>
    );
  }
);

SkillIcon.displayName = "SkillIcon";

export { SkillIcon, skillConfig };

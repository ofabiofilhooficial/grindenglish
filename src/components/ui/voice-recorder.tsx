import { useState, useRef, useCallback } from 'react';
import { Button } from '@/components/ui/button';
import { Mic, Square, Play, Pause, Trash2, Download } from 'lucide-react';
import { cn } from '@/lib/utils';

interface VoiceRecorderProps {
  onRecordingComplete?: (blob: Blob, url: string) => void;
  maxDuration?: number; // seconds
  className?: string;
  label?: string;
}

export function VoiceRecorder({ onRecordingComplete, maxDuration = 60, className, label }: VoiceRecorderProps) {
  const [status, setStatus] = useState<'idle' | 'recording' | 'recorded'>('idle');
  const [duration, setDuration] = useState(0);
  const [audioUrl, setAudioUrl] = useState<string | null>(null);
  const [isPlaying, setIsPlaying] = useState(false);

  const mediaRecorderRef = useRef<MediaRecorder | null>(null);
  const chunksRef = useRef<Blob[]>([]);
  const timerRef = useRef<NodeJS.Timeout | null>(null);
  const audioRef = useRef<HTMLAudioElement | null>(null);

  const formatTime = (s: number) => {
    const m = Math.floor(s / 60);
    const sec = s % 60;
    return `${m}:${sec.toString().padStart(2, '0')}`;
  };

  const startRecording = useCallback(async () => {
    try {
      const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
      const recorder = new MediaRecorder(stream);
      mediaRecorderRef.current = recorder;
      chunksRef.current = [];
      setDuration(0);

      recorder.ondataavailable = (e) => {
        if (e.data.size > 0) chunksRef.current.push(e.data);
      };

      recorder.onstop = () => {
        const blob = new Blob(chunksRef.current, { type: 'audio/webm' });
        const url = URL.createObjectURL(blob);
        setAudioUrl(url);
        setStatus('recorded');
        onRecordingComplete?.(blob, url);
        stream.getTracks().forEach((t) => t.stop());
      };

      recorder.start();
      setStatus('recording');

      let elapsed = 0;
      timerRef.current = setInterval(() => {
        elapsed++;
        setDuration(elapsed);
        if (elapsed >= maxDuration) {
          recorder.stop();
          clearInterval(timerRef.current!);
        }
      }, 1000);
    } catch {
      console.error('Microphone access denied');
    }
  }, [maxDuration, onRecordingComplete]);

  const stopRecording = useCallback(() => {
    mediaRecorderRef.current?.stop();
    if (timerRef.current) clearInterval(timerRef.current);
  }, []);

  const togglePlayback = useCallback(() => {
    if (!audioUrl) return;
    if (!audioRef.current) {
      audioRef.current = new Audio(audioUrl);
      audioRef.current.onended = () => setIsPlaying(false);
    }
    if (isPlaying) {
      audioRef.current.pause();
      setIsPlaying(false);
    } else {
      audioRef.current.play();
      setIsPlaying(true);
    }
  }, [audioUrl, isPlaying]);

  const discard = useCallback(() => {
    if (audioUrl) URL.revokeObjectURL(audioUrl);
    audioRef.current?.pause();
    audioRef.current = null;
    setAudioUrl(null);
    setStatus('idle');
    setDuration(0);
    setIsPlaying(false);
  }, [audioUrl]);

  return (
    <div className={cn('flex flex-col items-center gap-3 rounded-xl border border-border bg-card p-4', className)}>
      {label && <p className="text-sm font-medium text-foreground">{label}</p>}

      {/* Waveform placeholder / timer */}
      <div className="flex items-center gap-3">
        <div className={cn(
          'h-3 w-3 rounded-full',
          status === 'recording' ? 'bg-destructive animate-pulse' : 'bg-muted'
        )} />
        <span className="font-mono text-lg text-foreground">{formatTime(duration)}</span>
        {maxDuration && status === 'recording' && (
          <span className="text-xs text-muted-foreground">/ {formatTime(maxDuration)}</span>
        )}
      </div>

      {/* Controls */}
      <div className="flex items-center gap-2">
        {status === 'idle' && (
          <Button onClick={startRecording} size="lg" className="bg-gradient-primary hover:opacity-90 gap-2">
            <Mic className="h-5 w-5" /> Record
          </Button>
        )}
        {status === 'recording' && (
          <Button onClick={stopRecording} variant="destructive" size="lg" className="gap-2">
            <Square className="h-4 w-4" /> Stop
          </Button>
        )}
        {status === 'recorded' && (
          <>
            <Button onClick={togglePlayback} variant="outline" size="icon">
              {isPlaying ? <Pause className="h-4 w-4" /> : <Play className="h-4 w-4" />}
            </Button>
            <Button onClick={discard} variant="ghost" size="icon" className="text-destructive hover:text-destructive">
              <Trash2 className="h-4 w-4" />
            </Button>
            {audioUrl && (
              <a href={audioUrl} download="recording.webm">
                <Button variant="ghost" size="icon"><Download className="h-4 w-4" /></Button>
              </a>
            )}
          </>
        )}
      </div>
    </div>
  );
}

export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.1"
  }
  public: {
    Tables: {
      assets: {
        Row: {
          created_at: string
          file_name: string
          file_size_bytes: number | null
          file_type: string
          file_url: string
          id: string
          metadata: Json | null
          uploaded_by: string | null
        }
        Insert: {
          created_at?: string
          file_name: string
          file_size_bytes?: number | null
          file_type: string
          file_url: string
          id?: string
          metadata?: Json | null
          uploaded_by?: string | null
        }
        Update: {
          created_at?: string
          file_name?: string
          file_size_bytes?: number | null
          file_type?: string
          file_url?: string
          id?: string
          metadata?: Json | null
          uploaded_by?: string | null
        }
        Relationships: []
      }
      assignments: {
        Row: {
          assigned_at: string
          cohort_id: string | null
          completed_at: string | null
          content_id: string
          content_type: string
          created_at: string
          due_date: string | null
          id: string
          notes: string | null
          status: string
          student_id: string | null
          teacher_id: string
          updated_at: string
        }
        Insert: {
          assigned_at?: string
          cohort_id?: string | null
          completed_at?: string | null
          content_id: string
          content_type: string
          created_at?: string
          due_date?: string | null
          id?: string
          notes?: string | null
          status?: string
          student_id?: string | null
          teacher_id: string
          updated_at?: string
        }
        Update: {
          assigned_at?: string
          cohort_id?: string | null
          completed_at?: string | null
          content_id?: string
          content_type?: string
          created_at?: string
          due_date?: string | null
          id?: string
          notes?: string | null
          status?: string
          student_id?: string | null
          teacher_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "assignments_cohort_id_fkey"
            columns: ["cohort_id"]
            isOneToOne: false
            referencedRelation: "cohorts"
            referencedColumns: ["id"]
          },
        ]
      }
      cohort_members: {
        Row: {
          cohort_id: string
          id: string
          joined_at: string
          student_id: string
        }
        Insert: {
          cohort_id: string
          id?: string
          joined_at?: string
          student_id: string
        }
        Update: {
          cohort_id?: string
          id?: string
          joined_at?: string
          student_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "cohort_members_cohort_id_fkey"
            columns: ["cohort_id"]
            isOneToOne: false
            referencedRelation: "cohorts"
            referencedColumns: ["id"]
          },
        ]
      }
      cohorts: {
        Row: {
          created_at: string
          description: string | null
          id: string
          is_active: boolean
          name: string
          teacher_id: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          description?: string | null
          id?: string
          is_active?: boolean
          name: string
          teacher_id: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          description?: string | null
          id?: string
          is_active?: boolean
          name?: string
          teacher_id?: string
          updated_at?: string
        }
        Relationships: []
      }
      courses: {
        Row: {
          created_at: string
          created_by: string | null
          description: string | null
          id: string
          is_published: boolean
          title: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          created_by?: string | null
          description?: string | null
          id?: string
          is_published?: boolean
          title: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          created_by?: string | null
          description?: string | null
          id?: string
          is_published?: boolean
          title?: string
          updated_at?: string
        }
        Relationships: []
      }
      grammar_chapters: {
        Row: {
          cefr_level: string
          chapter_code: string
          common_errors: string | null
          contrast_notes: string | null
          created_at: string
          cross_links: Json | null
          form_content: string | null
          id: string
          is_published: boolean
          meaning_content: string | null
          micro_practice: Json | null
          sort_order: number
          title: string
          updated_at: string
          use_content: string | null
        }
        Insert: {
          cefr_level: string
          chapter_code: string
          common_errors?: string | null
          contrast_notes?: string | null
          created_at?: string
          cross_links?: Json | null
          form_content?: string | null
          id?: string
          is_published?: boolean
          meaning_content?: string | null
          micro_practice?: Json | null
          sort_order?: number
          title: string
          updated_at?: string
          use_content?: string | null
        }
        Update: {
          cefr_level?: string
          chapter_code?: string
          common_errors?: string | null
          contrast_notes?: string | null
          created_at?: string
          cross_links?: Json | null
          form_content?: string | null
          id?: string
          is_published?: boolean
          meaning_content?: string | null
          micro_practice?: Json | null
          sort_order?: number
          title?: string
          updated_at?: string
          use_content?: string | null
        }
        Relationships: []
      }
      learner_progress: {
        Row: {
          created_at: string
          current_streak: number
          grammar_chapters_viewed: number
          id: string
          last_activity_date: string | null
          lessons_completed: number
          longest_streak: number
          total_study_time_minutes: number
          updated_at: string
          user_id: string
          words_learned: number
        }
        Insert: {
          created_at?: string
          current_streak?: number
          grammar_chapters_viewed?: number
          id?: string
          last_activity_date?: string | null
          lessons_completed?: number
          longest_streak?: number
          total_study_time_minutes?: number
          updated_at?: string
          user_id: string
          words_learned?: number
        }
        Update: {
          created_at?: string
          current_streak?: number
          grammar_chapters_viewed?: number
          id?: string
          last_activity_date?: string | null
          lessons_completed?: number
          longest_streak?: number
          total_study_time_minutes?: number
          updated_at?: string
          user_id?: string
          words_learned?: number
        }
        Relationships: []
      }
      lesson_stages: {
        Row: {
          content: Json | null
          created_at: string
          id: string
          instructions: string | null
          lesson_id: string
          sort_order: number
          stage_type: string
          timing_minutes: number | null
          title: string
        }
        Insert: {
          content?: Json | null
          created_at?: string
          id?: string
          instructions?: string | null
          lesson_id: string
          sort_order?: number
          stage_type: string
          timing_minutes?: number | null
          title: string
        }
        Update: {
          content?: Json | null
          created_at?: string
          id?: string
          instructions?: string | null
          lesson_id?: string
          sort_order?: number
          stage_type?: string
          timing_minutes?: number | null
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "lesson_stages_lesson_id_fkey"
            columns: ["lesson_id"]
            isOneToOne: false
            referencedRelation: "lessons"
            referencedColumns: ["id"]
          },
        ]
      }
      lessons: {
        Row: {
          challenge_track: string | null
          created_at: string
          goal: string | null
          homework: Json | null
          id: string
          interaction_pattern: string | null
          is_published: boolean
          lesson_type: Database["public"]["Enums"]["lesson_type"]
          new_language: Json | null
          recycled_language: Json | null
          sort_order: number
          success_criteria: string | null
          support_track: string | null
          title: string
          unit_id: string
          updated_at: string
        }
        Insert: {
          challenge_track?: string | null
          created_at?: string
          goal?: string | null
          homework?: Json | null
          id?: string
          interaction_pattern?: string | null
          is_published?: boolean
          lesson_type?: Database["public"]["Enums"]["lesson_type"]
          new_language?: Json | null
          recycled_language?: Json | null
          sort_order?: number
          success_criteria?: string | null
          support_track?: string | null
          title: string
          unit_id: string
          updated_at?: string
        }
        Update: {
          challenge_track?: string | null
          created_at?: string
          goal?: string | null
          homework?: Json | null
          id?: string
          interaction_pattern?: string | null
          is_published?: boolean
          lesson_type?: Database["public"]["Enums"]["lesson_type"]
          new_language?: Json | null
          recycled_language?: Json | null
          sort_order?: number
          success_criteria?: string | null
          support_track?: string | null
          title?: string
          unit_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "lessons_unit_id_fkey"
            columns: ["unit_id"]
            isOneToOne: false
            referencedRelation: "units"
            referencedColumns: ["id"]
          },
        ]
      }
      levels: {
        Row: {
          cefr_code: string
          course_id: string
          created_at: string
          id: string
          is_published: boolean
          sort_order: number
          title: string
          updated_at: string
        }
        Insert: {
          cefr_code: string
          course_id: string
          created_at?: string
          id?: string
          is_published?: boolean
          sort_order?: number
          title: string
          updated_at?: string
        }
        Update: {
          cefr_code?: string
          course_id?: string
          created_at?: string
          id?: string
          is_published?: boolean
          sort_order?: number
          title?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "levels_course_id_fkey"
            columns: ["course_id"]
            isOneToOne: false
            referencedRelation: "courses"
            referencedColumns: ["id"]
          },
        ]
      }
      lexicon_entries: {
        Row: {
          cefr_productive: string | null
          cefr_receptive: string | null
          collocations: Json | null
          created_at: string
          definition_simple: string | null
          definition_teacher: string | null
          entry_type: string
          examples: Json | null
          frequency_band: string | null
          headword: string
          id: string
          ipa: string | null
          is_published: boolean
          patterns: Json | null
          pos: string | null
          register: string | null
          updated_at: string
          usage_notes: string | null
          variety: string | null
        }
        Insert: {
          cefr_productive?: string | null
          cefr_receptive?: string | null
          collocations?: Json | null
          created_at?: string
          definition_simple?: string | null
          definition_teacher?: string | null
          entry_type?: string
          examples?: Json | null
          frequency_band?: string | null
          headword: string
          id?: string
          ipa?: string | null
          is_published?: boolean
          patterns?: Json | null
          pos?: string | null
          register?: string | null
          updated_at?: string
          usage_notes?: string | null
          variety?: string | null
        }
        Update: {
          cefr_productive?: string | null
          cefr_receptive?: string | null
          collocations?: Json | null
          created_at?: string
          definition_simple?: string | null
          definition_teacher?: string | null
          entry_type?: string
          examples?: Json | null
          frequency_band?: string | null
          headword?: string
          id?: string
          ipa?: string | null
          is_published?: boolean
          patterns?: Json | null
          pos?: string | null
          register?: string | null
          updated_at?: string
          usage_notes?: string | null
          variety?: string | null
        }
        Relationships: []
      }
      pragmatics_items: {
        Row: {
          content: Json | null
          created_at: string
          id: string
          label: string
          pack_id: string
          sort_order: number
        }
        Insert: {
          content?: Json | null
          created_at?: string
          id?: string
          label: string
          pack_id: string
          sort_order?: number
        }
        Update: {
          content?: Json | null
          created_at?: string
          id?: string
          label?: string
          pack_id?: string
          sort_order?: number
        }
        Relationships: [
          {
            foreignKeyName: "pragmatics_items_pack_id_fkey"
            columns: ["pack_id"]
            isOneToOne: false
            referencedRelation: "pragmatics_packs"
            referencedColumns: ["id"]
          },
        ]
      }
      pragmatics_packs: {
        Row: {
          cefr_level: string | null
          created_at: string
          description: string | null
          id: string
          is_published: boolean
          pack_type: string
          title: string
          updated_at: string
        }
        Insert: {
          cefr_level?: string | null
          created_at?: string
          description?: string | null
          id?: string
          is_published?: boolean
          pack_type: string
          title: string
          updated_at?: string
        }
        Update: {
          cefr_level?: string | null
          created_at?: string
          description?: string | null
          id?: string
          is_published?: boolean
          pack_type?: string
          title?: string
          updated_at?: string
        }
        Relationships: []
      }
      profiles: {
        Row: {
          avatar_url: string | null
          created_at: string
          full_name: string | null
          id: string
          updated_at: string
        }
        Insert: {
          avatar_url?: string | null
          created_at?: string
          full_name?: string | null
          id: string
          updated_at?: string
        }
        Update: {
          avatar_url?: string | null
          created_at?: string
          full_name?: string | null
          id?: string
          updated_at?: string
        }
        Relationships: []
      }
      progress_events: {
        Row: {
          created_at: string
          event_data: Json | null
          event_type: string
          id: string
          user_id: string
        }
        Insert: {
          created_at?: string
          event_data?: Json | null
          event_type: string
          id?: string
          user_id: string
        }
        Update: {
          created_at?: string
          event_data?: Json | null
          event_type?: string
          id?: string
          user_id?: string
        }
        Relationships: []
      }
      pronunciation_scripts: {
        Row: {
          audio_asset_id: string | null
          cefr_level: string | null
          chunked_content: string | null
          created_at: string
          focus_tags: Json | null
          id: string
          is_published: boolean
          script_type: string
          speed_plan: string | null
          stress_marked_content: string | null
          text_content: string | null
          title: string
          updated_at: string
        }
        Insert: {
          audio_asset_id?: string | null
          cefr_level?: string | null
          chunked_content?: string | null
          created_at?: string
          focus_tags?: Json | null
          id?: string
          is_published?: boolean
          script_type?: string
          speed_plan?: string | null
          stress_marked_content?: string | null
          text_content?: string | null
          title: string
          updated_at?: string
        }
        Update: {
          audio_asset_id?: string | null
          cefr_level?: string | null
          chunked_content?: string | null
          created_at?: string
          focus_tags?: Json | null
          id?: string
          is_published?: boolean
          script_type?: string
          speed_plan?: string | null
          stress_marked_content?: string | null
          text_content?: string | null
          title?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "pronunciation_scripts_audio_asset_id_fkey"
            columns: ["audio_asset_id"]
            isOneToOne: false
            referencedRelation: "assets"
            referencedColumns: ["id"]
          },
        ]
      }
      srs_cards: {
        Row: {
          created_at: string
          ease_factor: number
          id: string
          interval: number
          last_reviewed_at: string | null
          next_review_date: string
          repetitions: number
          updated_at: string
          user_id: string
          word_id: string
        }
        Insert: {
          created_at?: string
          ease_factor?: number
          id?: string
          interval?: number
          last_reviewed_at?: string | null
          next_review_date?: string
          repetitions?: number
          updated_at?: string
          user_id: string
          word_id: string
        }
        Update: {
          created_at?: string
          ease_factor?: number
          id?: string
          interval?: number
          last_reviewed_at?: string | null
          next_review_date?: string
          repetitions?: number
          updated_at?: string
          user_id?: string
          word_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "srs_cards_word_id_fkey"
            columns: ["word_id"]
            isOneToOne: false
            referencedRelation: "lexicon_entries"
            referencedColumns: ["id"]
          },
        ]
      }
      taggings: {
        Row: {
          created_at: string
          id: string
          tag_id: string
          taggable_id: string
          taggable_type: string
        }
        Insert: {
          created_at?: string
          id?: string
          tag_id: string
          taggable_id: string
          taggable_type: string
        }
        Update: {
          created_at?: string
          id?: string
          tag_id?: string
          taggable_id?: string
          taggable_type?: string
        }
        Relationships: [
          {
            foreignKeyName: "taggings_tag_id_fkey"
            columns: ["tag_id"]
            isOneToOne: false
            referencedRelation: "tags"
            referencedColumns: ["id"]
          },
        ]
      }
      tags: {
        Row: {
          category: string | null
          created_at: string
          id: string
          name: string
        }
        Insert: {
          category?: string | null
          created_at?: string
          id?: string
          name: string
        }
        Update: {
          category?: string | null
          created_at?: string
          id?: string
          name?: string
        }
        Relationships: []
      }
      units: {
        Row: {
          created_at: string
          estimated_time_minutes: number | null
          flagship_task: string | null
          id: string
          is_published: boolean
          level_id: string
          outcomes: Json | null
          secondary_tasks: Json | null
          sort_order: number
          theme: string | null
          title: string
          track: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          estimated_time_minutes?: number | null
          flagship_task?: string | null
          id?: string
          is_published?: boolean
          level_id: string
          outcomes?: Json | null
          secondary_tasks?: Json | null
          sort_order?: number
          theme?: string | null
          title: string
          track?: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          estimated_time_minutes?: number | null
          flagship_task?: string | null
          id?: string
          is_published?: boolean
          level_id?: string
          outcomes?: Json | null
          secondary_tasks?: Json | null
          sort_order?: number
          theme?: string | null
          title?: string
          track?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "units_level_id_fkey"
            columns: ["level_id"]
            isOneToOne: false
            referencedRelation: "levels"
            referencedColumns: ["id"]
          },
        ]
      }
      user_roles: {
        Row: {
          created_at: string
          id: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Update: {
          created_at?: string
          id?: string
          role?: Database["public"]["Enums"]["app_role"]
          user_id?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      get_cohort_progress: {
        Args: { _cohort_id: string }
        Returns: {
          completed_assignments: number
          current_streak: number
          full_name: string
          last_activity_date: string
          lessons_completed: number
          pending_assignments: number
          student_id: string
          words_learned: number
        }[]
      }
      get_due_cards_count: { Args: { _user_id: string }; Returns: number }
      get_or_create_srs_card: {
        Args: { _user_id: string; _word_id: string }
        Returns: string
      }
      get_student_assignments: {
        Args: { _student_id: string }
        Returns: {
          assigned_at: string
          cohort_name: string
          content_id: string
          content_type: string
          due_date: string
          id: string
          notes: string
          status: string
          teacher_name: string
        }[]
      }
      get_teacher_students: {
        Args: { _teacher_id: string }
        Returns: {
          avatar_url: string
          cohort_count: number
          full_name: string
          student_id: string
        }[]
      }
      has_role: {
        Args: {
          _role: Database["public"]["Enums"]["app_role"]
          _user_id: string
        }
        Returns: boolean
      }
      is_content_creator: { Args: { _user_id: string }; Returns: boolean }
      is_teacher: { Args: { _user_id: string }; Returns: boolean }
      log_activity_event: {
        Args: { _event_data?: Json; _event_type: string; _user_id: string }
        Returns: string
      }
      teacher_add_words_to_srs: {
        Args: {
          _student_ids: string[]
          _teacher_id: string
          _word_ids: string[]
        }
        Returns: {
          card_id: string
          student_id: string
          success: boolean
          word_id: string
        }[]
      }
      update_srs_card: {
        Args: { _card_id: string; _user_rating: number }
        Returns: {
          new_ease_factor: number
          new_interval: number
          new_next_review_date: string
          new_repetitions: number
        }[]
      }
      update_user_streak: { Args: { _user_id: string }; Returns: undefined }
    }
    Enums: {
      app_role: "admin" | "curriculum_designer" | "teacher" | "learner"
      lesson_type:
        | "listening"
        | "reading"
        | "grammar"
        | "vocabulary"
        | "pronunciation"
        | "speaking"
        | "writing"
        | "fluency"
        | "mediation"
        | "review"
        | "assessment"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      app_role: ["admin", "curriculum_designer", "teacher", "learner"],
      lesson_type: [
        "listening",
        "reading",
        "grammar",
        "vocabulary",
        "pronunciation",
        "speaking",
        "writing",
        "fluency",
        "mediation",
        "review",
        "assessment",
      ],
    },
  },
} as const

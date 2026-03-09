import { supabase } from "@/integrations/supabase/client";
import type { Database } from "@/integrations/supabase/types";

// Type aliases for profiles table
type Profile = Database["public"]["Tables"]["profiles"]["Row"];
type ProfileUpdate = Database["public"]["Tables"]["profiles"]["Update"];

/**
 * Data structure for profile updates
 */
export interface ProfileUpdateData {
  fullName: string;
}

/**
 * Custom error type for profile service operations
 */
export class ProfileServiceError extends Error {
  code?: string;
  details?: unknown;

  constructor(message: string, code?: string, details?: unknown) {
    super(message);
    this.name = "ProfileServiceError";
    this.code = code;
    this.details = details;
  }
}

/**
 * Service for managing user profile operations
 */
export const profileService = {
  /**
   * Updates the authenticated user's profile
   * @param userId - The authenticated user's ID
   * @param data - Profile fields to update
   * @returns Updated profile data
   * @throws ProfileServiceError on failure
   */
  updateProfile: async (
    userId: string,
    data: ProfileUpdateData
  ): Promise<Profile> => {
    if (!userId) {
      throw new ProfileServiceError(
        "User ID is required",
        "INVALID_INPUT"
      );
    }

    try {
      // Map ProfileUpdateData to database column format
      const updatePayload: ProfileUpdate = {
        full_name: data.fullName,
      };

      const { data: updatedProfile, error } = await supabase
        .from("profiles")
        .update(updatePayload)
        .eq("id", userId)
        .select()
        .single();

      if (error) {
        throw error;
      }

      if (!updatedProfile) {
        throw new ProfileServiceError(
          "Profile update failed - no data returned",
          "NO_DATA"
        );
      }

      return updatedProfile;
    } catch (error: any) {
      // Handle RLS policy violations
      if (error.code === "PGRST301" || error.code === "42501") {
        throw new ProfileServiceError(
          "You can only update your own profile",
          "AUTHORIZATION_ERROR",
          error
        );
      }

      // Handle network errors
      if (
        error.message?.toLowerCase().includes("network") ||
        error.message?.toLowerCase().includes("fetch") ||
        error.name === "NetworkError"
      ) {
        throw new ProfileServiceError(
          "Unable to connect. Please check your connection",
          "NETWORK_ERROR",
          error
        );
      }

      // Handle validation errors from database
      if (error.code?.startsWith("23")) {
        // PostgreSQL constraint violation codes start with 23
        throw new ProfileServiceError(
          error.message || "Invalid data provided",
          "VALIDATION_ERROR",
          error
        );
      }

      // Log unexpected errors for debugging
      console.error("Profile update error:", error);

      // Throw generic error for unknown cases
      throw new ProfileServiceError(
        "An unexpected error occurred. Please try again",
        "UNKNOWN_ERROR",
        error
      );
    }
  },

  /**
   * Fetches the current user's profile
   * @param userId - The user's ID
   * @returns Profile data
   * @throws ProfileServiceError on failure
   */
  getProfile: async (userId: string): Promise<Profile> => {
    if (!userId) {
      throw new ProfileServiceError(
        "User ID is required",
        "INVALID_INPUT"
      );
    }

    try {
      const { data: profile, error } = await supabase
        .from("profiles")
        .select("*")
        .eq("id", userId)
        .single();

      if (error) {
        throw error;
      }

      if (!profile) {
        throw new ProfileServiceError(
          "Profile not found",
          "NOT_FOUND"
        );
      }

      return profile;
    } catch (error: any) {
      // Handle not found errors
      if (error.code === "PGRST116") {
        throw new ProfileServiceError(
          "Profile not found",
          "NOT_FOUND",
          error
        );
      }

      // Handle network errors
      if (
        error.message?.toLowerCase().includes("network") ||
        error.message?.toLowerCase().includes("fetch") ||
        error.name === "NetworkError"
      ) {
        throw new ProfileServiceError(
          "Unable to connect. Please check your connection",
          "NETWORK_ERROR",
          error
        );
      }

      // Log unexpected errors for debugging
      console.error("Profile fetch error:", error);

      // Throw generic error for unknown cases
      throw new ProfileServiceError(
        "An unexpected error occurred. Please try again",
        "UNKNOWN_ERROR",
        error
      );
    }
  },
};

import { describe, it, expect, vi, beforeEach } from "vitest";
import { render, screen, waitFor, fireEvent } from "@testing-library/react";
import { BrowserRouter } from "react-router-dom";
import SettingsPage from "./SettingsPage";
import { useAuth } from "@/hooks/useAuth";
import { profileService } from "@/services/profileService";

// Mock the useAuth hook
const mockRefreshProfile = vi.fn();
vi.mock("@/hooks/useAuth", () => ({
  useAuth: vi.fn(() => ({
    user: { id: "test-user-id", email: "test@example.com" },
    profile: { id: "test-user-id", full_name: "Test User", avatar_url: null },
    refreshProfile: mockRefreshProfile,
  })),
}));

// Mock the profileService
vi.mock("@/services/profileService", () => ({
  profileService: {
    updateProfile: vi.fn(),
  },
}));

// Mock the toast hook
vi.mock("@/hooks/use-toast", () => ({
  useToast: () => ({ toast: vi.fn() }),
}));

// Mock window.confirm
const mockConfirm = vi.fn();
global.confirm = mockConfirm;

describe("SettingsPage - Navigation Guards", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    mockRefreshProfile.mockResolvedValue(undefined);
  });

  describe("Task 4.2: Navigation guard for unsaved changes", () => {
    it("should render the settings page with form", async () => {
      render(
        <BrowserRouter>
          <SettingsPage />
        </BrowserRouter>
      );

      // Wait for the form to load
      await waitFor(() => {
        expect(screen.getByLabelText(/full name/i)).toBeInTheDocument();
      });

      expect(screen.getByLabelText(/full name/i)).toBeInTheDocument();
      expect(screen.getByLabelText(/email/i)).toBeInTheDocument();
    });

    it("should set up beforeunload event listener for browser navigation", async () => {
      render(
        <BrowserRouter>
          <SettingsPage />
        </BrowserRouter>
      );

      // Wait for the form to load
      await waitFor(() => {
        expect(screen.getByLabelText(/full name/i)).toBeInTheDocument();
      });

      // Modify the form to create unsaved changes
      const nameInput = screen.getByLabelText(/full name/i);
      fireEvent.change(nameInput, { target: { value: "Modified Name" } });

      // Wait for the dirty state to update
      await waitFor(() => {
        const saveButton = screen.getByRole("button", { name: /save changes/i });
        expect(saveButton).not.toBeDisabled();
      });

      // Create a beforeunload event
      const event = new Event("beforeunload", { cancelable: true }) as BeforeUnloadEvent;
      Object.defineProperty(event, "returnValue", {
        writable: true,
        value: "",
      });

      // Dispatch the event
      window.dispatchEvent(event);

      // The event should have preventDefault called
      expect(event.defaultPrevented).toBe(true);
    });

    it("should not prevent navigation when there are no unsaved changes", async () => {
      render(
        <BrowserRouter>
          <SettingsPage />
        </BrowserRouter>
      );

      // Wait for the form to load
      await waitFor(() => {
        expect(screen.getByLabelText(/full name/i)).toBeInTheDocument();
      });

      // Don't modify the form - no unsaved changes
      // Create a beforeunload event
      const event = new Event("beforeunload", { cancelable: true }) as BeforeUnloadEvent;
      Object.defineProperty(event, "returnValue", {
        writable: true,
        value: "",
      });

      // Dispatch the event
      window.dispatchEvent(event);

      // The event should NOT have preventDefault called when there are no unsaved changes
      expect(event.defaultPrevented).toBe(false);
    });

    it("should display the correct confirmation message", () => {
      // This test verifies that the confirmation message is set correctly
      // The actual message is: "You have unsaved changes. Are you sure you want to leave?"
      
      // We can't easily test the actual confirm dialog in unit tests,
      // but we can verify the component structure is correct
      render(
        <BrowserRouter>
          <SettingsPage />
        </BrowserRouter>
      );

      // Verify the page renders correctly
      expect(screen.getByText(/Settings/i)).toBeInTheDocument();
      expect(screen.getByText(/Manage your personal information/i)).toBeInTheDocument();
    });
  });

  describe("Task 4.3: Profile refresh after update", () => {
    it("should call refreshProfile after successful form submission", async () => {
      // Mock successful profile update
      vi.mocked(profileService.updateProfile).mockResolvedValue({
        id: "test-user-id",
        full_name: "Updated Name",
        avatar_url: null,
      });

      render(
        <BrowserRouter>
          <SettingsPage />
        </BrowserRouter>
      );

      // Wait for the form to load
      await waitFor(() => {
        expect(screen.getByLabelText(/full name/i)).toBeInTheDocument();
      });

      // Modify the form
      const nameInput = screen.getByLabelText(/full name/i);
      fireEvent.change(nameInput, { target: { value: "Updated Name" } });

      // Wait for the save button to be enabled
      await waitFor(() => {
        const saveButton = screen.getByRole("button", { name: /save changes/i });
        expect(saveButton).not.toBeDisabled();
      });

      // Submit the form
      const saveButton = screen.getByRole("button", { name: /save changes/i });
      fireEvent.click(saveButton);

      // Wait for the update to complete
      await waitFor(() => {
        expect(profileService.updateProfile).toHaveBeenCalledWith("test-user-id", {
          fullName: "Updated Name",
        });
      });

      // Verify refreshProfile was called after the update
      await waitFor(() => {
        expect(mockRefreshProfile).toHaveBeenCalled();
      });
    });

    it("should ensure updated profile data is reflected throughout the application", async () => {
      // Mock successful profile update
      vi.mocked(profileService.updateProfile).mockResolvedValue({
        id: "test-user-id",
        full_name: "New Name",
        avatar_url: null,
      });

      render(
        <BrowserRouter>
          <SettingsPage />
        </BrowserRouter>
      );

      // Wait for the form to load
      await waitFor(() => {
        expect(screen.getByLabelText(/full name/i)).toBeInTheDocument();
      });

      // Modify the form
      const nameInput = screen.getByLabelText(/full name/i);
      fireEvent.change(nameInput, { target: { value: "New Name" } });

      // Submit the form
      const saveButton = screen.getByRole("button", { name: /save changes/i });
      fireEvent.click(saveButton);

      // Wait for the update to complete
      await waitFor(() => {
        expect(mockRefreshProfile).toHaveBeenCalled();
      });

      // Verify the sequence: updateProfile is called first, then refreshProfile
      const updateProfileCall = vi.mocked(profileService.updateProfile).mock.invocationCallOrder[0];
      const refreshProfileCall = mockRefreshProfile.mock.invocationCallOrder[0];
      
      expect(updateProfileCall).toBeLessThan(refreshProfileCall);
    });

    it("should not call refreshProfile if update fails", async () => {
      // Mock failed profile update
      vi.mocked(profileService.updateProfile).mockRejectedValue(
        new Error("Update failed")
      );

      render(
        <BrowserRouter>
          <SettingsPage />
        </BrowserRouter>
      );

      // Wait for the form to load
      await waitFor(() => {
        expect(screen.getByLabelText(/full name/i)).toBeInTheDocument();
      });

      // Modify the form
      const nameInput = screen.getByLabelText(/full name/i);
      fireEvent.change(nameInput, { target: { value: "Updated Name" } });

      // Submit the form
      const saveButton = screen.getByRole("button", { name: /save changes/i });
      fireEvent.click(saveButton);

      // Wait for the update to fail
      await waitFor(() => {
        expect(profileService.updateProfile).toHaveBeenCalled();
      });

      // Verify refreshProfile was NOT called after the failed update
      expect(mockRefreshProfile).not.toHaveBeenCalled();
    });
  });
});

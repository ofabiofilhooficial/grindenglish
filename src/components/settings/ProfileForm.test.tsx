import { describe, it, expect, vi, beforeEach } from "vitest";
import { render, screen, waitFor, fireEvent } from "@testing-library/react";
import { ProfileForm } from "./ProfileForm";

// Mock the toast hook
const mockToast = vi.fn();
vi.mock("@/hooks/use-toast", () => ({
  useToast: () => ({ toast: mockToast }),
}));

describe("ProfileForm", () => {
  const mockProfile = {
    id: "test-user-id",
    full_name: "John Doe",
    avatar_url: null,
  };

  const mockEmail = "john@example.com";
  const mockOnSave = vi.fn();
  const mockOnDirtyChange = vi.fn();

  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe("Task 2.5: Display and initial state", () => {
    it("should display current profile data", () => {
      render(
        <ProfileForm
          profile={mockProfile}
          email={mockEmail}
          onSave={mockOnSave}
          onDirtyChange={mockOnDirtyChange}
        />
      );

      const nameInput = screen.getByLabelText(/full name/i) as HTMLInputElement;
      const emailInput = screen.getByLabelText(/email/i) as HTMLInputElement;

      expect(nameInput.value).toBe("John Doe");
      expect(emailInput.value).toBe("john@example.com");
    });

    it("should display empty input field when full name is null", () => {
      const profileWithNullName = {
        ...mockProfile,
        full_name: null,
      };

      render(
        <ProfileForm
          profile={profileWithNullName}
          email={mockEmail}
          onSave={mockOnSave}
          onDirtyChange={mockOnDirtyChange}
        />
      );

      const nameInput = screen.getByLabelText(/full name/i) as HTMLInputElement;
      expect(nameInput.value).toBe("");
    });

    it("should display empty input field when full name is empty string", () => {
      const profileWithEmptyName = {
        ...mockProfile,
        full_name: "",
      };

      render(
        <ProfileForm
          profile={profileWithEmptyName}
          email={mockEmail}
          onSave={mockOnSave}
          onDirtyChange={mockOnDirtyChange}
        />
      );

      const nameInput = screen.getByLabelText(/full name/i) as HTMLInputElement;
      expect(nameInput.value).toBe("");
    });

    it("should have save button disabled when no changes made", () => {
      render(
        <ProfileForm
          profile={mockProfile}
          email={mockEmail}
          onSave={mockOnSave}
          onDirtyChange={mockOnDirtyChange}
        />
      );

      const saveButton = screen.getByRole("button", { name: /save changes/i });
      expect(saveButton).toBeDisabled();
    });
  });

  describe("Task 2.2: Form submission and feedback handling", () => {

  it("should show success toast notification on successful update", async () => {
    mockOnSave.mockResolvedValueOnce(undefined);

    render(
      <ProfileForm
        profile={mockProfile}
        email={mockEmail}
        onSave={mockOnSave}
        onDirtyChange={mockOnDirtyChange}
      />
    );

    const nameInput = screen.getByLabelText(/full name/i);
    const saveButton = screen.getByRole("button", { name: /save changes/i });

    // Modify the name
    fireEvent.change(nameInput, { target: { value: "Jane Doe" } });

    // Submit the form
    fireEvent.click(saveButton);

    // Wait for the async operation to complete
    await waitFor(() => {
      expect(mockOnSave).toHaveBeenCalledWith({ fullName: "Jane Doe" });
    });

    // Verify success toast was called
    await waitFor(() => {
      expect(mockToast).toHaveBeenCalledWith({
        title: "Profile updated",
        description: "Your profile has been updated successfully.",
      });
    });
  });

  it("should show error toast notification on failed update", async () => {
    const errorMessage = "Network error occurred";
    mockOnSave.mockRejectedValueOnce(new Error(errorMessage));

    render(
      <ProfileForm
        profile={mockProfile}
        email={mockEmail}
        onSave={mockOnSave}
        onDirtyChange={mockOnDirtyChange}
      />
    );

    const nameInput = screen.getByLabelText(/full name/i);
    const saveButton = screen.getByRole("button", { name: /save changes/i });

    // Modify the name
    fireEvent.change(nameInput, { target: { value: "Jane Doe" } });

    // Submit the form
    fireEvent.click(saveButton);

    // Wait for the async operation to complete
    await waitFor(() => {
      expect(mockOnSave).toHaveBeenCalled();
    });

    // Verify error toast was called with descriptive message
    await waitFor(() => {
      expect(mockToast).toHaveBeenCalledWith({
        title: "Update failed",
        description: errorMessage,
        variant: "destructive",
      });
    });
  });

  it("should trim whitespace from full name before submission", async () => {
    mockOnSave.mockResolvedValueOnce(undefined);

    render(
      <ProfileForm
        profile={mockProfile}
        email={mockEmail}
        onSave={mockOnSave}
        onDirtyChange={mockOnDirtyChange}
      />
    );

    const nameInput = screen.getByLabelText(/full name/i);
    const saveButton = screen.getByRole("button", { name: /save changes/i });

    // Type name with leading and trailing whitespace
    fireEvent.change(nameInput, { target: { value: "  Jane Doe  " } });

    // Submit the form
    fireEvent.click(saveButton);

    // Verify that the trimmed value was passed to onSave
    await waitFor(() => {
      expect(mockOnSave).toHaveBeenCalledWith({ fullName: "Jane Doe" });
    });
  });

  it("should reset form dirty state after successful submission", async () => {
    mockOnSave.mockResolvedValueOnce(undefined);

    render(
      <ProfileForm
        profile={mockProfile}
        email={mockEmail}
        onSave={mockOnSave}
        onDirtyChange={mockOnDirtyChange}
      />
    );

    const nameInput = screen.getByLabelText(/full name/i);
    const saveButton = screen.getByRole("button", { name: /save changes/i });

    // Initially, the form should not be dirty
    expect(saveButton).toBeDisabled();

    // Modify the name
    fireEvent.change(nameInput, { target: { value: "Jane Doe" } });

    // Form should now be dirty and button enabled
    await waitFor(() => {
      expect(saveButton).not.toBeDisabled();
    });

    // Submit the form
    fireEvent.click(saveButton);

    // Wait for submission to complete
    await waitFor(() => {
      expect(mockOnSave).toHaveBeenCalled();
    });

    // After successful submission, the button should be disabled again (form not dirty)
    await waitFor(() => {
      expect(saveButton).toBeDisabled();
    });
  });

  it("should show loading state on save button during submission", async () => {
    // Create a promise that we can control
    let resolvePromise: () => void;
    const savePromise = new Promise<void>((resolve) => {
      resolvePromise = resolve;
    });
    mockOnSave.mockReturnValueOnce(savePromise);

    render(
      <ProfileForm
        profile={mockProfile}
        email={mockEmail}
        onSave={mockOnSave}
        onDirtyChange={mockOnDirtyChange}
      />
    );

    const nameInput = screen.getByLabelText(/full name/i);
    const saveButton = screen.getByRole("button", { name: /save changes/i });

    // Modify the name
    fireEvent.change(nameInput, { target: { value: "Jane Doe" } });

    // Submit the form
    fireEvent.click(saveButton);

    // Check that button shows loading state
    await waitFor(() => {
      expect(screen.getByText(/saving/i)).toBeInTheDocument();
    });

    // Button should be disabled during submission
    expect(saveButton).toBeDisabled();

    // Resolve the promise to complete the submission
    resolvePromise!();

    // Wait for submission to complete
    await waitFor(() => {
      expect(screen.getByText(/save changes/i)).toBeInTheDocument();
    });
  });
});
});

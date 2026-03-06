import { Navigate } from 'react-router-dom';

// This page has been replaced by the unified auth on the homepage
// Redirect to homepage for authentication
export default function SignupPage() {
  return <Navigate to="/" replace />;
}

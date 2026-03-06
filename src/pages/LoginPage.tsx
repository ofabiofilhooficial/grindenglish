import { Navigate } from 'react-router-dom';

// This page has been replaced by the unified auth on the homepage
// Redirect to homepage for authentication
export default function LoginPage() {
  return <Navigate to="/" replace />;
}

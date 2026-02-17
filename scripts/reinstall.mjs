import { execSync } from 'child_process';

try {
  console.log('Running npm install to regenerate package-lock.json...');
  const output = execSync('npm install', {
    cwd: '/vercel/share/v0-project',
    stdio: 'pipe',
    encoding: 'utf-8',
    timeout: 120000,
  });
  console.log(output);
  console.log('Done! package-lock.json has been regenerated.');
} catch (error) {
  console.error('Error running npm install:', error.stdout || error.message);
  process.exit(1);
}

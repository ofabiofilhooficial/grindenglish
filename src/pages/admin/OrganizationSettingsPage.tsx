import { useState } from 'react'
import { ProtectedRoute } from '@/components/ProtectedRoute'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Label } from '@/components/ui/label'

export const OrganizationSettingsPage = () => {
  const [settings, setSettings] = useState({
    platformName: 'English Compass',
    defaultMode: 'self-paced',
    logoUrl: '',
  })

  const handleChange = (field: string, value: string) => {
    setSettings(prev => ({
      ...prev,
      [field]: value
    }))
  }

  const handleSave = () => {
    // TODO: Save to Supabase settings table
    console.log('Saving settings:', settings)
  }

  return (
    <ProtectedRoute requiredRoles={['admin']}>
      <div className="p-8 max-w-2xl">
        <Card>
          <CardHeader>
            <CardTitle>Organization Settings</CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            <div>
              <Label htmlFor="platformName">Platform Name</Label>
              <Input
                id="platformName"
                value={settings.platformName}
                onChange={(e) => handleChange('platformName', e.target.value)}
                className="mt-2"
              />
            </div>

            <div>
              <Label htmlFor="logoUrl">Logo URL</Label>
              <Input
                id="logoUrl"
                value={settings.logoUrl}
                onChange={(e) => handleChange('logoUrl', e.target.value)}
                placeholder="https://example.com/logo.png"
                className="mt-2"
              />
            </div>

            <div>
              <Label htmlFor="defaultMode">Default Mode</Label>
              <select
                id="defaultMode"
                value={settings.defaultMode}
                onChange={(e) => handleChange('defaultMode', e.target.value)}
                className="mt-2 w-full px-3 py-2 border rounded-md"
              >
                <option value="self-paced">Self-Paced</option>
                <option value="cohort">Cohort-Based</option>
              </select>
            </div>

            <Button onClick={handleSave}>Save Settings</Button>
          </CardContent>
        </Card>
      </div>
    </ProtectedRoute>
  )
}OrganizationSettingsPage.tsx

import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Upload } from 'lucide-react';

export default function AssetManagerPage() {
  return (
    <AppLayout title="Asset Manager" subtitle="Upload and manage media files">
      <div className="p-6">
        <Card>
          <CardHeader>
            <CardTitle className="font-display flex items-center gap-2">
              <Upload className="h-5 w-5" />
              Media Library
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground">Upload audio, video, PDFs, and images. Tag them for easy discovery and link them to lessons and units. File upload functionality coming in the next phase.</p>
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  );
}

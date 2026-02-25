# Publish Feature Guide

## Overview
The publish feature allows content creators (admins and curriculum designers) to control which content is visible to students. Content can be in two states:
- **Draft**: Visible only to content creators and teachers
- **Published**: Visible to all users including students

## How to Use

### Publishing a Course
1. Navigate to `/author/courses` (Course Builder page)
2. Find the course you want to publish
3. Click the **Publish** button next to the course title
4. The course status badge will change from "Draft" to "Published"

### Publishing a Level
1. On the Course Builder page, hover over any CEFR level card (A0, A1, etc.)
2. Click the eye icon that appears in the top-right corner
3. The level's status badge will update to show "Published"

### Publishing a Unit
**Option 1 - From Level Detail Page:**
1. Navigate to a level by clicking on it from the Course Builder
2. Hover over any unit card
3. Click the **Publish** button that appears
4. The unit status will update immediately

**Option 2 - From Unit Editor:**
1. Open any unit in the Unit Editor (`/author/units/:unitId`)
2. Click the **Publish** button in the top-right corner (next to Save)
3. The status badge will update to "Published"

### Publishing a Lesson
**Option 1 - From Unit Editor:**
1. Open a unit and go to the "Lessons" tab
2. Hover over any lesson in the list
3. Click the eye icon that appears
4. The lesson status will update

**Option 2 - From Lesson Editor:**
1. Open any lesson in the Lesson Editor (`/author/lessons/:lessonId`)
2. Click the **Publish** button in the top-right corner (next to Save)
3. The status badge will update to "Published"

## Unpublishing Content
To unpublish any content, simply click the **Unpublish** button (or eye-off icon) in the same location where you published it. The content will immediately become hidden from students.

## Visual Indicators
- **Draft Badge**: Gray/secondary badge indicating content is not visible to students
- **Published Badge**: Primary colored badge indicating content is visible to students
- **Eye Icon**: Appears on hover, click to publish
- **Eye-Off Icon**: Appears on hover for published content, click to unpublish

## Important Notes
- Publishing a course does NOT automatically publish its levels, units, or lessons
- Each level of content hierarchy must be published independently
- Students can only see content where ALL parent items are published (e.g., a lesson is only visible if the lesson, unit, level, AND course are all published)
- Content creators and teachers can always see all content regardless of publish status
- Unpublishing content immediately hides it from students without deleting any data

## Student View
When students log in and navigate to their course:
1. They see only published CEFR levels on the Course page
2. Clicking a level shows only published units within that level
3. Clicking a unit shows only published lessons within that unit
4. Unpublished content appears as "locked" or simply doesn't appear in the list

## Testing the Feature
To verify the publish feature is working:
1. As an admin/curriculum designer, publish a course, level, unit, and lesson
2. Log in as a student (learner role)
3. Navigate to /course and verify you can see the published level
4. Click into the level and verify you can see the published unit
5. Click into the unit and verify you can see the published lesson
6. As admin, unpublish any item in the chain and verify it disappears from the student view

## Database Fields
All content types have an `is_published` boolean field:
- `courses.is_published`
- `levels.is_published`
- `units.is_published`
- `lessons.is_published`

These fields are enforced by Row Level Security (RLS) policies in the database.

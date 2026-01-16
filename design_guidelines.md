# Tuesday Trivia: Season 10 - Design Guidelines

## Design Approach
**System**: Material Design principles adapted for corporate professionalism, emphasizing clarity, hierarchy, and efficiency for team-based trivia management.

## Color System
**Primary Palette**:
- Navy (#1e3a8a): Primary actions, headers, navigation
- Slate (#475569): Body text, secondary elements, borders
- Gold (#f59e0b): Accents, achievements, highlights, point displays
- White/Off-white (#f8fafc): Backgrounds, cards
- Success Green (#10b981): Verification confirmations, approvals
- Alert Red (#ef4444): Rejections, errors, critical actions

**Application**:
- Navigation/headers: Navy backgrounds with white text
- CTAs: Gold buttons with navy text
- Admin actions: Navy buttons with white text
- Team cards: White cards with slate borders, gold accent for team leads
- Leaderboard: Alternating white/slate-50 rows, gold for top 3 positions

## Typography
**Font Stack**: Inter (via Google Fonts) for modern, professional clarity

**Hierarchy**:
- H1 (Page Titles): 2.5rem, font-bold, navy
- H2 (Section Headers): 2rem, font-semibold, navy
- H3 (Card Titles): 1.5rem, font-semibold, slate-800
- Body: 1rem, font-normal, slate-600
- Small/Meta: 0.875rem, font-medium, slate-500
- Stats/Points: 1.25rem, font-bold, gold

## Layout System
**Spacing Units**: Tailwind units of 4, 6, 8, 12, 16 (p-4, m-8, gap-6, etc.)

**Container Structure**:
- Max-width: max-w-7xl for main content
- Section padding: py-12 desktop, py-8 mobile
- Card spacing: p-6 desktop, p-4 mobile
- Form fields: mb-4 consistent spacing

## Component Library

### Navigation
- Fixed top navbar: Navy background, white text, gold border-b-2 accent
- Logo: "Tuesday Trivia" in bold white, "Season 10" in gold italic
- User menu: Right-aligned dropdown with avatar circle, team badge indicator
- Mobile: Hamburger menu, slide-in drawer with same navy styling

### Hero Section (Landing/Login Page)
**Large Hero Image**: Professional trivia-themed imagery (quiz bowls, knowledge symbols, corporate team collaboration)
- Overlay: Navy gradient (opacity 0.85) for text legibility
- Headline: "Tuesday Trivia: Season 10" in white, 3xl bold
- Subheadline: "Where @wwt.com Teams Compete Weekly" in gold
- CTAs: Gold button "Register" (blurred bg), Navy outlined button "Login" (blurred bg)
- Height: 70vh desktop, 50vh mobile

### Cards
**Team Cards**:
- White background, subtle slate border, rounded-lg
- Gold vertical accent bar (4px) for team lead indicator
- Team name: H3 styling
- Member count badge: Slate circle with white text
- Status indicators: Gold "Pending Approval", Green "Active Member"

**Question Cards** (Archives):
- White cards with slate-100 header containing week number
- Question text: Body styling, slate-700
- Answer reveal: Gold highlight background for correct answers
- Points earned: Large gold numbers, right-aligned

### Forms
**Input Fields**:
- Border: 2px slate-300, rounded-md
- Focus: Navy border, gold ring
- Labels: Font-medium, slate-700, mb-2
- Error states: Red border, red helper text below

**Team Creation/Join**:
- Two-column layout desktop (form left, info/preview right)
- Single column mobile
- Submit buttons: Full-width mobile, fixed-width desktop

### Leaderboard
**Table Design**:
- Sticky header: Navy background, white text
- Columns: Rank | Team Name | Members | Total Points
- Top 3: Gold background gradient for rank 1, slate-100 for ranks 2-3
- Hover: Slate-50 row highlight
- Points: Large gold bold numbers, right-aligned
- Mobile: Stacked card layout instead of table

### Admin Portal
**Dashboard Layout**:
- Sidebar navigation (left): Navy background, gold active states
- Main content: White background, generous padding
- Action buttons: Navy primary, slate secondary
- Grading interface: Split-screen (team answer left, correct answer right)
- Point slider: Gold accent, 0-1 range clearly marked

### Submission Interface (Team Leads)
**Answer Entry**:
- Numbered list: Large navy numbers, gold on current question
- Textarea inputs: Generous height (h-24), slate borders
- Save draft: Slate outlined button
- Submit final: Large gold button with navy text, confirmation modal

### Notifications
**Flash Messages**:
- Success: Green-50 background, green-700 text, green-500 left border
- Info: Navy-50 background, navy-700 text, gold left border
- Error: Red-50 background, red-700 text, red-500 left border
- Position: Top-right toast style desktop, top banner mobile

## Responsive Strategy
**Breakpoints**:
- Mobile-first: Single column, full-width cards, stacked forms
- Tablet (md:): Two-column grids for team directory, side-by-side forms
- Desktop (lg:): Three-column team grids, sidebar + content layouts, data tables

**Mobile Priorities**:
- Bottom navigation bar for key actions (Home, My Team, Leaderboard, Submit)
- Collapsible sections for archives
- Touch-friendly targets (min 44px height for buttons)

## Images
**Hero Image**: Professional business team in casual collaboration, modern office setting with quiz/knowledge theme elements. Full-width, 70vh, navy gradient overlay.

**Team Directory Placeholder**: Generic team avatars using initials in gold circles on navy backgrounds (if no custom team logo uploaded).

**Empty States**: Illustrated graphics for "No submissions yet" (gold clipboard icon), "Join a team" (navy people icons), "No questions posted" (gold question mark).

## Iconography
**Library**: Heroicons (outline style)
- Use sparingly for clarity: navigation items, form labels, status indicators
- Size: w-5 h-5 for inline, w-6 h-6 for standalone
- Color: Inherit from parent (navy for headers, slate for body, gold for accents)
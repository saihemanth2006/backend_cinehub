# 🎨 CineHub Visual Design Reference

## Color Palette Visual Guide

### Primary Colors

```
┌─────────────────────────────────────────────┐
│ PRIMARY BRAND COLOR                         │
│ #7C3AED (Rich Purple)                       │
│ ████████████████████████████████████████░░░░│
│ Used: Buttons, Links, Highlights, Primary UI│
└─────────────────────────────────────────────┘

┌─────────────────────────────────────────────┐
│ PRIMARY LIGHT                               │
│ #EDE9FE (Soft Purple Background)            │
│ ████████████████████████████████████████░░░░│
│ Used: Badge backgrounds, Soft highlights    │
└─────────────────────────────────────────────┘

┌─────────────────────────────────────────────┐
│ PRIMARY DARK                                │
│ #5B21B6 (Deep Purple)                       │
│ ████████████████████████████████████████░░░░│
│ Used: Hover states, Pressed states, Depth   │
└─────────────────────────────────────────────┘

┌─────────────────────────────────────────────┐
│ SECONDARY (GOLD)                            │
│ #DCAA5C (Elegant Gold)                      │
│ ████████████████████████████████████████░░░░│
│ Used: Featured items, Awards, Premium UI    │
└─────────────────────────────────────────────┘
```

### Semantic Colors

```
SUCCESS - #10B981 ████████████████████████████████ (Green)
ERROR   - #EF4444 ████████████████████████████████ (Red)
WARNING - #F59E0B ████████████████████████████████ (Amber)
INFO    - #3B82F6 ████████████████████████████████ (Blue)
```

---

## Typography Scale

```
╔════════════════════════════════════════════════════╗
║         PROFESSIONAL TYPOGRAPHY HIERARCHY          ║
╠════════════════════════════════════════════════════╣
║                                                    ║
║  Headline 1 - 32px Bold                            ║
║  Large Page Titles & Hero Headlines                ║
║                                                    ║
║  Headline 2 - 28px Bold                            ║
║  Section Headers & Major Dividers                  ║
║                                                    ║
║  Headline 3 - 24px Bold                            ║
║  Card Titles & Subsections                         ║
║                                                    ║
║  Headline 4 - 20px Semibold                        ║
║  Important Content Headers                         ║
║                                                    ║
║  Body Large - 16px Medium                          ║
║  Main Narrative Text & Key Content                 ║
║                                                    ║
║  Body Medium - 14px Medium                         ║
║  Standard Body Text & Descriptions                 ║
║                                                    ║
║  Body Small - 12px Medium                          ║
║  Secondary Information & Support Text              ║
║                                                    ║
║  Label Medium - 12px Semibold                      ║
║  Badges, Chips, Labels                             ║
║                                                    ║
║  Caption - 12px Regular                            ║
║  Metadata, Timestamps, Help Text                   ║
║                                                    ║
╚════════════════════════════════════════════════════╝
```

---

## Spacing System (4px Grid)

```
╔═══════════════════════════════════════════╗
║      SPACING SCALE (Base: 4px)            ║
╠═══════════════════════════════════════════╣
║                                           ║
║  xs  = 4px  ░░░░                          ║
║  sm  = 8px  ░░░░░░░░                      ║
║  md  = 12px ░░░░░░░░░░░░                  ║
║  lg  = 16px ░░░░░░░░░░░░░░░░              ║
║  xl  = 20px ░░░░░░░░░░░░░░░░░░░░          ║
║  xxl = 24px ░░░░░░░░░░░░░░░░░░░░░░        ║
║  xxxl = 32px ░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
║                                           ║
╚═══════════════════════════════════════════╝
```

---

## Component Structure

### Professional Avatar

```
┌──────────────┐
│   👤        │  Online Status Indicator
│   (Gradient │  • Online: Green dot
│    Avatar)  │  • Offline: No indicator
└──────────────┘

Interactive:
• Hover: Slight scale increase (1.05x)
• Customizable size (24px to 128px)
• Name or custom image
• Accessibility: Alt text included
```

### Profile Card

```
┌────────────────────────────────────┐
│   [Gradient Cover Image (120px)]   │
├────────────────────────────────────┤
│      👤[Avatar -64px, Overlapping] │
│                                    │
│  Name                              │  ← Headline 4
│  Role or Title                     │  ← Body Medium
│                                    │
│  [2.4K Followers Badge]            │
│                                    │
│  [Skill Chips] [Skill Chips]       │
│  [Skill Chips] [Skill Chips]       │
│                                    │
│  [View Profile Button]             │
│  [Message Button]                  │
└────────────────────────────────────┘
```

### Portfolio Media Tile

```
┌──────────────────────────────┐
│  [         Image             │
│  Gradient Overlay ▼          │
│           ▶ Play Button      │ ← Interactive
│                              │
│  [FILM]                      │ ← Media Type
│  Project Title               │
│  Subtitle | 1.2K views      │
└──────────────────────────────┘

2-Column Grid Layout
```

### Job Opportunity Card

```
┌────────────────────────────────────┐
│  Job Title                [★]      │ ← Bookmark
│  Company Name                      │
│                                    │
│  📍 Location, State                │
│                                    │
│  [Role Tag] [Role Tag] [Role Tag]  │
│                                    │
│  42 applicants  [Apply Now Button] │
└────────────────────────────────────┘
```

---

## Screen Layouts

### Professional Profile Screen

```
╔════════════════════════════════════╗
║  ← Back  Profile  ⋮(Menu)          ║ Header
╠════════════════════════════════════╣
║                                    ║
║  [Gradient Cover Image]            ║ 160px
║                                    ║
║       👤 [Avatar -100px]           ║ Overlapping
║       [Name]                       ║
║       [Professional Title]         ║
║       📍 Location                  ║
║                                    ║
║  [2.4K] [12]  [8]                  ║ Stats Cards
║  Posts  Works  Awards              ║
║                                    ║
║  [Follow ✓] [Message 💬]           ║ Actions
║                                    ║
║  Bio                               ║ Section
║  Description text...               ║
║                                    ║
║  Skills & Expertise                ║
║  [Skill] [Skill] [Skill]           ║
║  [Skill] [Skill] [Skill]           ║
║                                    ║
║  ┌─ Portfolio ─┬─ Awards ─┬─ Exp ─┐│ Tabs
║  │                                │
║  │ [Media Grid - 2 columns]       │
║  │ [Media] [Media]                │
║  │ [Media] [Media]                │
│                                    │
└────────────────────────────────────┘
```

### Portfolio Showcase Screen

```
╔════════════════════════════════════╗
║  ← Back  Portfolio  ≡(Filter)      ║ Header
╠════════════════════════════════════╣
║  Portfolio                         ║
║  Showcase your best work           ║
║  [12 Projects] [48K Views] [2.1K]  ║ Stats
║                                    ║
║  [All] [Films] [Clips] [BTS]⟶      ║ Filters
║                                    ║
║  [Project] [Project]               ║
║  [Project] [Project]               ║
║  [Project] [Project]               ║ Media Grid
║  [Project] [Project]               ║
║                                    ║
║  ┌─ Upload New Work ─┐             ║
║  │  ☁️                │             ║
║  │  Upload           │             ║
║  │  [Add Content]    │             ║
║  └───────────────────┘             ║
│                                    │
└────────────────────────────────────┘
```

### Industry Networking Screen

```
╔════════════════════════════════════╗
║  ← Back  Network  Search…          ║ Header
╠════════════════════════════════════╣
║  [🔍 Search filmmakers...]         ║ Search
║                                    ║
║  [Connections] [Invites] [Msgs]    ║ Tabs
│                                    │
║  Suggested Connections              │
║  [👤 Card] [👤 Card]               │
║  [👤 Card] [👤 Card]               │ 2-Column Grid
║                                    │
║  Your Connections                  │
║  [👤 Name] [📨 Message]            │
║  [👤 Name] [📨 Message]            │ List
║  [👤 Name] [📨 Message]            │
│                                    │
└────────────────────────────────────┘
```

### Talent Discovery Screen

```
╔════════════════════════════════════╗
║  ← Back  Discover  🔍 Search      ║ Header
╠════════════════════════════════════╣
║  [Search by skill...]              ║ Search
║                                    ║
║  Skill                             ║
║  [All] [Director] [DP] [Editor]⟶   ║ Filters
║                                    ║ (Horiz)
║  Experience                        ║
║  [All] [0-2yr] [2-5yr] [5+yr]⟶    ║ Scroll
║                                    ║
║  Location                          ║
║  [All] [LA] [NYC] [London]⟶       ║
║                                    ║
║  More Filters     Sort ⇅           ║
║                                    ║
║  Results (24)                      ║
║  [👤 Name]  Rating: ★★★★ (4.8)    ║
║  Role/Title        📍 Location     ║
║  [Skills] [View] [Invite]          ║ Cards
║                                    ║
║  [👤 Name]  Rating: ★★★★ (4.7)    ║
║  Role/Title        📍 Location     ║
║  [Skills] [View] [Invite]          ║
│                                    │
└────────────────────────────────────┘
```

### Job & Casting Board Screen

```
╔════════════════════════════════════╗
║  ← Back  Jobs  🔍 Search  ≡       ║ Header
╠════════════════════════════════════╣
║  [All Jobs] [Bookmarks] [Applied]  ║ Tabs
│                                    │
║  ┌─ FEATURED ──────────────────┐  ║
║  │ Lead Director - Feature Film │  ║
║  │ Big Budget Studio            │  ║
║  │ 📍 Los Angeles, CA           │  ║
║  │ [Apply Now] [Save]           │  ║
║  └──────────────────────────────┘  ║
║                                    ║
║  All Job Listings                  ║
║                                    ║
║  Casting Call                      ║ Cards
║  Independent Production            ║
║  📍 New York | 245 applicants      ║
║  [Actor] [Extra] [Apply]          ║
║                                    ║
║  Film Crew Wanted                  ║
║  Production Studio XYZ             ║
║  📍 LA | 128 applicants            ║
║  [DP] [Gaffer] [Apply]            ║
│                                    │
└────────────────────────────────────┘
```

---

## Interactive States

### Button States

```
Normal:   [Button Text]              ← Default, clickable
Hover:   ═[Button Text]╗             ← Elevated shadow
Active:  ╚[Button Text]╔             ← Pressed effect
Disabled: ░[Button Text]░            ← Muted color, not clickable
```

### Card States

```
Default:
┌──────────────────┐
│ Card             │ ← Subtle shadow
└──────────────────┘

Hover:
┌──────────────────┐
║ Card             ║ ← Elevated shadow
└──────────────────┘

Selected:
╔══════════════════╗
║ Card             ║ ← Purple highlight
╚══════════════════╝
```

---

## Elevation & Depth

```
SHADOW SYSTEM (Z-depth visualization)

┌─────────────────┐
│ xs (Elevation 1) │ 2px blur, minimal lift
└─────────────────┘

  ┌─────────────────┐
  │ sm (Elevation 2) │ 3px blur, subtle lift
  └─────────────────┘

    ┌─────────────────┐
    │ md (Elevation 3) │ 6px blur, moderate lift
    └─────────────────┘

      ┌─────────────────┐
      │ lg (Elevation 4) │ 12px blur, prominent lift
      └─────────────────┘

        ┌─────────────────┐
        │ xl (Elevation 5) │ 20px blur, maximum lift
        └─────────────────┘
```

---

## Border Radius Reference

```
Rounded Corners Guide:

━━━━━━━━━━━━━━━━━━━━  none (0px) - Sharp corners

╭──────────────────╮  sm (4px) - Subtle rounding
│ Slightly rounded │
╰──────────────────╯

╭────────────────╮    lg (12px) - Standard cards
│   Rounded      │
╰────────────────╯

╭──────────────╮      xl (16px) - Large buttons
│ More rounded │
╰──────────────╯

  ╭────────────╮      xxl (20px) - Hero sections
  │ Very round │
  ╰────────────╯

    ○                  full (9999px) - Circles/Badges
   /  \
  │    │
   \  /
    ○
```

---

## Component Anatomy

### Standard Card Structure

```
┌────────────────────────────────┐
│  [Icon/Image/Badge] (optional) │ ← Header: 12px lg
├────────────────────────────────┤
│  Headline 4 - Title             │ ← 20px Semibold
│  Body Medium - Description      │ ← 14px Medium
├────────────────────────────────┤
│  [Primary Button] [Action]      │ ← Footer: 16px lg
└────────────────────────────────┘
     Padding: lg (16px) on all sides
```

### Action Button Logic

```
Primary Action (CTA):     [Purple Button] ← High priority
Secondary Action:         [Outlined Btn]  ← Medium priority
Tertiary Action:         Link Text        ← Low priority
Destructive Action:      [Red Button]     ← Negative action
```

---

## Responsive Breakpoints

```
Mobile < 600px
█████

  Tablet 600px - 1200px
  ███████████████

      Desktop > 1200px
      █████████████████████
```

**Mobile First Design**:

- Single column at 375px+
- 2 columns at 600px+
- 3+ columns at 1200px+

---

## Animation & Micro-interactions

```
TRANSITION TIMINGS:

Fast:     150ms (Filter changes, icon toggles)
Standard: 200ms (Tab switches, card animations)
Slow:     300ms (Modal opens, transitions)

EASING FUNCTIONS:

Linear:        ─────────────────────── (constant)
EaseInOut:     ╱────────────╲         (smooth)
EaseOut:       ╱─────────────═        (quick settle)
```

---

## Accessibility Checklist

```
☑ Color contrast ratios (4.5:1 for text)
☑ Touch targets minimum 48x48px
☑ Keyboard navigation support
☑ Screen reader friendly (labels, roles)
☑ Focus indicators visible
☑ WCAG AA compliance
☑ Motion preferences respected
☑ Text legibility (line-height, letter-spacing)
```

---

## Design System Tokens Quick Reference

```
COLORS
Primary:        #7C3AED
Secondary:      #DCAA5C
Success:        #10B981
Error:          #EF4444
Text Primary:   #1A1A1A
Text Secondary: #666666
Divider:        #E5E7EB

SPACING (4px grid)
xs: 4px   | sm: 8px   | md: 12px | lg: 16px
xl: 20px  | xxl: 24px | xxxl: 32px

TYPOGRAPHY
Font: Inter
Weights: 400, 500, 600, 700
Sizes: 10px - 32px (6 levels)

RADIUS
sm: 4px | md: 8px | lg: 12px | xl: 16px | full: 9999px

SHADOWS
5 elevation levels (xs to xl)
```

---

This visual reference guide helps developers and designers understand:

- Color relationships and usage
- Typography hierarchy
- Spacing and alignment
- Component structures
- Layout patterns
- Interactive states
- Accessibility considerations

Refer to this guide when building new screens or components to maintain consistency! 🎨

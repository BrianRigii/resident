# Resident Design System

A modern, minimal design system for the Resident property management application.

## Design Philosophy

The Resident design system follows these core principles:

- **Modern Minimalism**: Clean lines, generous spacing, and a focus on content
- **Spacious Layout**: Breathing room between elements for better readability
- **Intuitive Navigation**: Clear visual hierarchy and predictable interactions
- **Professional Aesthetic**: Subtle shadows, rounded corners, and elegant typography
- **Calm Color Palette**: Emerald green primary color with neutral grays

---

## Color Palette

### Primary Colors
- **Primary**: `#10B981` - Emerald green (fresh, professional)
- **Primary Light**: `#34D399`
- **Primary Dark**: `#059669`

### Secondary Colors
- **Secondary**: `#64748B` - Slate
- **Secondary Light**: `#94A3B8`
- **Secondary Dark**: `#475569`

### Neutral Colors
- **Background**: `#FAFAFA` - Light neutral background
- **Surface**: `#FFFFFF` - Pure white for cards/containers
- **Surface Variant**: `#F5F5F5`

### Border & Dividers
- **Border**: `#E5E7EB`
- **Border Light**: `#F3F4F6`

### Text Colors
- **Text Primary**: `#111827` - Dark gray for main content
- **Text Secondary**: `#6B7280` - Medium gray for secondary text
- **Text Tertiary**: `#9CA3AF` - Light gray for hints/captions

### Semantic Colors
- **Success**: `#10B981` - Green
- **Warning**: `#F59E0B` - Amber
- **Error**: `#EF4444` - Red
- **Info**: `#3B82F6` - Blue

### Status Colors (Property Management)
- **Occupied**: `#10B981` - Green
- **Vacant**: `#3B82F6` - Blue
- **Maintenance**: `#F59E0B` - Amber
- **Reserved**: `#8B5CF6` - Purple

---

## Typography

### Font Family
**Custom fonts for professional, modern appearance:**

- **Montserrat**: Headings (H1-H6), Display text, Buttons - Geometric, modern, professional
- **Inter**: Body text, Inputs, Labels, Captions - Clean, highly legible, optimized for UI

> **Note**: See [FONTS.md](FONTS.md) for detailed font configuration and usage guidelines.

### Text Styles

#### Display (Montserrat Bold)
- **Display 1**: 48px, Bold (700), -0.5 letter-spacing
- **Display 2**: 40px, Bold (700), -0.5 letter-spacing

#### Headings (Montserrat SemiBold)
- **H1**: 36px, SemiBold (600)
- **H2**: 32px, SemiBold (600)
- **H3**: 28px, SemiBold (600)
- **H4**: 24px, SemiBold (600)
- **H5**: 20px, SemiBold (600)
- **H6**: 18px, SemiBold (600)

#### Body (Inter Regular)
- **Body 1**: 16px, Regular (400), 1.5 line-height
- **Body 2**: 14px, Regular (400), 1.5 line-height

#### Subtitles (Inter Medium)
- **Subtitle 1**: 16px, Medium (500)
- **Subtitle 2**: 14px, Medium (500)

#### Labels
- **Button**: 16px, SemiBold (600), Montserrat, 0.5 letter-spacing
- **Caption**: 12px, Regular (400), Inter
- **Overline**: 10px, Medium (500), Inter, 1.5 letter-spacing

---

## Spacing System

Based on a **4px unit system** for consistent spacing:

- **XS**: 4px
- **SM**: 8px
- **MD**: 16px
- **LG**: 24px
- **XL**: 32px
- **XXL**: 48px
- **XXXL**: 64px

### Common Usage
- **Page Padding**: 16px horizontal, 24px vertical
- **Card Padding**: 16px
- **Section Spacing**: 32px

---

## Border Radius

- **XS**: 4px - Small elements
- **SM**: 8px - Badges, chips
- **MD**: 12px - Buttons, inputs
- **LG**: 16px - Cards
- **XL**: 24px - Large containers
- **Full**: 9999px - Circular elements

---

## Elevation (Shadows)

- **None**: 0 - Flat elements
- **SM**: 2 - Subtle lift
- **MD**: 4 - Standard cards
- **LG**: 8 - Modals, dialogs
- **XL**: 16 - Floating elements

---

## Components

### Buttons

#### Primary Button
- Background: Primary color
- Text: White
- Height: 52px
- Padding: 24px horizontal
- Border Radius: 12px
- Font: Button style (16px, SemiBold)

#### Secondary Button
- Outlined style
- Border: Primary color
- Text: Primary color
- Same dimensions as primary

#### Tertiary Button
- Text-only style
- No background/border
- Text: Primary color

#### Icon Button Circular
- Circular background
- 48px default size
- Icon centered

### Input Fields

#### Text Field
- Height: Auto (min 52px)
- Padding: 16px horizontal, 16px vertical
- Border: 1px solid border color
- Border Radius: 12px
- Focus Border: 2px solid primary
- Label above field (14px, SemiBold, text-primary)

#### Search Field
- Same styling as text field
- Prefix search icon
- Suffix clear button (when text present)

### Cards

#### App Card
- Background: White
- Border: 1px solid border color
- Border Radius: 16px
- Padding: 16px
- Optional shadow for elevated variant

#### Info Card
- Icon in colored container (10% opacity background)
- Title and value text
- Optional chevron for navigation
- Full card is tappable

#### Stats Card
- Large value display
- Icon in colored container
- Optional trend indicator
- Colored background (5% opacity)

### Status & Feedback

#### Status Badge
- Small pill-shaped indicator
- Icon + text or text only
- Colored background (10% opacity) or outlined
- Border Radius: 8px

#### Loading Indicator
- Circular progress (40px default)
- Optional message below
- Primary color

#### Empty State
- Large icon in circular background
- Title and description
- Optional action button
- Centered layout

### Navigation

#### App Bar
- Background: Same as page background
- No elevation
- Title: H5 style
- Actions: Icon buttons

#### Bottom Navigation
- 4 items maximum
- Icon + label
- Selected: Primary color
- Unselected: Tertiary text color
- Background: White surface
- Top shadow for elevation

#### FAB (Floating Action Button)
- Circular
- Primary color background
- White icon
- Medium elevation (4)

---

## Layout Guidelines

### Responsive Breakpoints
- **Mobile**: < 768px
- **Desktop**: >= 768px

### Page Structure
```
┌─────────────────────────┐
│     App Bar/Header      │
├─────────────────────────┤
│                         │
│   Content Area          │
│   (Scrollable)          │
│   - Max width: 480px    │
│     (for auth screens)  │
│   - Full width          │
│     (for dashboard)     │
│                         │
├─────────────────────────┤
│  Bottom Navigation      │
└─────────────────────────┘
```

### Grid System
- **Stats Cards**: 2 columns on all screens
- **Info Cards**: 2 columns, aspect ratio 1.8
- **Spacing**: 16px gap between grid items

---

## Usage Examples

### Importing Theme
```dart
import 'package:resident/core/theme/app_theme.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/theme/app_spacing.dart';
```

### Using Components
```dart
// Button
PrimaryButton(
  text: 'Sign In',
  onPressed: () {},
  icon: Icons.login,
  fullWidth: true,
)

// Input Field
AppTextField(
  label: 'Email',
  hint: 'you@example.com',
  prefixIcon: Icons.email,
  validator: (value) => ...,
)

// Card
AppCard(
  child: Text('Content'),
  onTap: () {},
)

// Stats
StatsCard(
  title: 'Total Units',
  value: '48',
  icon: Icons.meeting_room,
  color: AppColors.info,
  trend: '+5',
)
```

---

## File Structure

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_theme.dart       # Main theme configuration
│   │   ├── app_colors.dart      # Color definitions
│   │   ├── app_text_styles.dart # Typography styles
│   │   └── app_spacing.dart     # Spacing constants
│   └── widgets/
│       ├── buttons.dart         # Button components
│       ├── input_fields.dart    # Input components
│       ├── cards.dart           # Card components
│       ├── common_widgets.dart  # Misc widgets
│       └── navigation.dart      # Navigation components
```

---

## Best Practices

1. **Consistency**: Always use design system components and tokens
2. **Spacing**: Use AppSpacing constants, not hardcoded values
3. **Colors**: Reference AppColors, never use Color() directly
4. **Typography**: Use AppTextStyles for all text
5. **Accessibility**: Maintain proper contrast ratios
6. **Responsive**: Test on different screen sizes
7. **Reusability**: Create custom components for repeated patterns

---

## Future Enhancements

- [ ] Dark mode support
- [ ] Animation tokens and transitions
- [ ] Custom icon set
- [ ] Data tables and lists
- [ ] Form validation helpers
- [ ] Toast/Snackbar components
- [ ] Modal/Dialog components
- [ ] Date picker customization
- [ ] Chart/graph styling

# Font Configuration - Resident

This document describes the custom font setup for the Resident property management application.

## Font Families

### 1. **Inter** (Variable Font)
- **Usage**: Default font family for the entire application
- **Purpose**: Body text, inputs, buttons, labels, captions
- **Characteristics**: Clean, highly legible, optimized for UI
- **Files**: 
  - `assets/fonts/Inter/Inter-VariableFont_opsz,wght.ttf` (Regular)
  - `assets/fonts/Inter/Inter-Italic-VariableFont_opsz,wght.ttf` (Italic)
- **Weight Range**: 100-900 (Variable)
- **License**: Open Font License (OFL)

### 2. **Montserrat** (Variable Font)
- **Usage**: Headings and display text
- **Purpose**: All headings (H1-H6), display text, buttons (for emphasis)
- **Characteristics**: Geometric, modern, professional
- **Files**:
  - `assets/fonts/Montserrat/Montserrat-VariableFont_wght.ttf` (Regular)
  - `assets/fonts/Montserrat/Montserrat-Italic-VariableFont_wght.ttf` (Italic)
- **Weight Range**: 100-900 (Variable)
- **License**: Open Font License (OFL)

---

## Typography Hierarchy

### Display Text (Montserrat Bold)
```dart
display1: 48px, weight 700  // Large hero text
display2: 40px, weight 700  // Secondary hero text
```

### Headings (Montserrat SemiBold)
```dart
h1: 36px, weight 600  // Page titles
h2: 32px, weight 600  // Section headers
h3: 28px, weight 600  // Subsection headers
h4: 24px, weight 600  // Card titles
h5: 20px, weight 600  // Small card titles, app bar
h6: 18px, weight 600  // Smallest headings
```

### Body Text (Inter Regular/Medium)
```dart
body1:     16px, weight 400  // Primary content
body2:     14px, weight 400  // Secondary content
subtitle1: 16px, weight 500  // Emphasized body text
subtitle2: 14px, weight 500  // Emphasized secondary text
```

### Labels & Small Text (Inter/Montserrat)
```dart
button:   16px, weight 600, Montserrat  // Button labels (emphasis)
caption:  12px, weight 400, Inter       // Help text, timestamps
overline: 10px, weight 500, Inter       // Labels, tags
```

---

## Configuration Files

### 1. Flutter Configuration (`pubspec.yaml`)

Fonts are declared in the `pubspec.yaml` file:

```yaml
flutter:
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter/Inter-VariableFont_opsz,wght.ttf
        - asset: assets/fonts/Inter/Inter-Italic-VariableFont_opsz,wght.ttf
          style: italic

    - family: Montserrat
      fonts:
        - asset: assets/fonts/Montserrat/Montserrat-VariableFont_wght.ttf
        - asset: assets/fonts/Montserrat/Montserrat-Italic-VariableFont_wght.ttf
          style: italic
```

### 2. Theme Configuration (`lib/core/theme/app_theme.dart`)

The theme is configured with:
- **Default Font Family**: Inter
- **Text Theme**: Complete mapping of all Material text styles to custom styles

```dart
ThemeData(
  fontFamily: 'Inter',  // Default for entire app
  textTheme: TextTheme(
    displayLarge: AppTextStyles.display1,
    headlineLarge: AppTextStyles.h1,
    bodyLarge: AppTextStyles.body1,
    // ... etc
  ),
)
```

### 3. Text Styles (`lib/core/theme/app_text_styles.dart`)

All text styles are defined with explicit font families:

```dart
class AppTextStyles {
  static const String _montserrat = 'Montserrat';
  static const String _inter = 'Inter';
  
  static const TextStyle h1 = TextStyle(
    fontFamily: _montserrat,  // Headings use Montserrat
    fontSize: 36,
    fontWeight: FontWeight.w600,
  );
  
  static const TextStyle body1 = TextStyle(
    fontFamily: _inter,  // Body text uses Inter
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}
```

### 4. Web Configuration (`web/css/fonts.css`)

For web builds, custom `@font-face` rules are defined:

```css
@font-face {
  font-family: 'Inter';
  font-weight: 100 900;
  src: url('../fonts/Inter/Inter-VariableFont_opsz,wght.ttf') format('truetype');
}

@font-face {
  font-family: 'Montserrat';
  font-weight: 100 900;
  src: url('../fonts/Montserrat/Montserrat-VariableFont_wght.ttf') format('truetype');
}
```

The CSS file is linked in `web/index.html`:
```html
<link rel="stylesheet" href="css/fonts.css">
```

---

## Usage Examples

### Using Text Styles

```dart
// Headings automatically use Montserrat
Text('Welcome', style: AppTextStyles.h1);
Text('Dashboard', style: AppTextStyles.h4);

// Body text automatically uses Inter
Text('This is body content', style: AppTextStyles.body1);
Text('Secondary information', style: AppTextStyles.body2);

// Buttons use Montserrat for emphasis
ElevatedButton(
  child: Text('Sign In'),  // Uses theme's button style
  onPressed: () {},
)

// Captions use Inter
Text('Updated 2 hours ago', style: AppTextStyles.caption);
```

### Theme Context

When using Material widgets, the theme automatically applies:

```dart
// AppBar titles use h5 (Montserrat)
AppBar(
  title: Text('Dashboard'),  // Uses Montserrat SemiBold 20px
)

// Text widgets default to body1 (Inter)
Text('Default text')  // Uses Inter Regular 16px

// ListTile titles/subtitles
ListTile(
  title: Text('Property Name'),     // Uses theme's titleMedium
  subtitle: Text('123 Main St'),    // Uses theme's bodyMedium
)
```

---

## Font Loading Performance

### Variable Fonts Benefits
- **Single File**: One file per style (regular/italic) instead of multiple weight files
- **Smaller Bundle**: Reduced app size compared to static fonts
- **Flexible Weights**: Any weight from 100-900 without additional files
- **Better Performance**: Fewer HTTP requests on web

### Web Optimization
- `font-display: swap` ensures text is visible during font loading
- Fonts are preloaded for better performance
- System font fallbacks prevent layout shift

---

## Testing Fonts

### 1. Run Flutter Application
```bash
flutter run
```

### 2. Web Build Test
```bash
flutter build web
flutter run -d chrome
```

### 3. Visual Verification
- Check the Design Showcase screen: `lib/design_showcase.dart`
- Verify headings use Montserrat (more geometric)
- Verify body text uses Inter (more rounded, legible)

### 4. Font Inspector (Web)
- Open DevTools > Elements
- Inspect text elements
- Check "Computed" tab for `font-family`

---

## Troubleshooting

### Fonts Not Loading

**Problem**: Fonts appear as system default

**Solution**:
1. Run `flutter clean`
2. Run `flutter pub get`
3. Restart the app
4. For web: Clear browser cache

### Font Files Missing

**Problem**: Build errors about missing font files

**Solution**:
1. Verify font files exist in `assets/fonts/`
2. Check `pubspec.yaml` paths match actual file locations
3. Run `flutter pub get`

### Web Fonts Not Working

**Problem**: Custom fonts not loading on web

**Solution**:
1. Verify `web/css/fonts.css` exists
2. Check font paths in CSS file (relative to CSS file location)
3. Verify `index.html` includes the CSS link
4. Check browser console for 404 errors

### Variable Font Not Working

**Problem**: Only one weight is showing

**Solution**:
- Variable fonts are supported in Flutter 3.0+
- For older versions, use static font files from `assets/fonts/*/static/`
- Update Flutter: `flutter upgrade`

---

## Best Practices

1. **Always Use AppTextStyles**: Don't create inline TextStyle with font families
2. **Consistent Hierarchy**: Use h1-h6 for headings, body1/body2 for content
3. **Theme Context**: Let the theme handle default styling when possible
4. **Avoid Font Mixing**: Don't mix font families within a single text element
5. **Performance**: Variable fonts are more efficient than multiple static files
6. **Accessibility**: Maintain minimum 12px font size for readability

---

## Font Customization

To add or change fonts:

1. **Add Font Files**: Place TTF/OTF files in `assets/fonts/[FontName]/`
2. **Update pubspec.yaml**: Add font family declaration
3. **Update AppTextStyles**: Define new text styles with the font
4. **Update Web CSS**: Add @font-face rules for web support
5. **Update Theme**: Map styles to Material text theme if needed
6. **Run flutter pub get**
7. **Restart the app**

---

## Resources

- [Inter Font](https://rsms.me/inter/)
- [Montserrat Font](https://fonts.google.com/specimen/Montserrat)
- [Flutter Custom Fonts Guide](https://docs.flutter.dev/cookbook/design/fonts)
- [Variable Fonts Guide](https://web.dev/variable-fonts/)
- [Open Font License](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL)

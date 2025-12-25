# StayZone Theme Design Guide

## 🎨 Color Philosophy

**Core Principle:** Dark, calming colors that reduce eye strain during long focus sessions.

---

## 🌙 Dark Theme (Default)

### Why Dark Theme?
- **Reduces eye strain** - Especially important for extended focus sessions
- **Less distracting** - Dark backgrounds help maintain focus
- **Better for low-light environments** - Users often focus in evening/night
- **Battery efficient** - On OLED screens, dark pixels use less power
- **Professional appearance** - Feels more serious and focused

---

## 🎨 Color Palette

### Primary Colors
- **Primary Dark:** `#1A1A2E` - Deep navy blue (main background)
- **Primary Light:** `#16213E` - Slightly lighter navy (surfaces)
- **Accent Color:** `#0F3460` - Medium blue (borders, dividers)
- **Highlight Color:** `#533483` - Purple accent (buttons, active states)

**Why these colors?**
- **Navy blue** - Calming, professional, reduces eye strain
- **Purple accent** - Associated with focus and creativity, not too bright
- **Deep tones** - Won't burn eyes during long sessions

### Surface Colors
- **Surface Dark:** `#0F0F1E` - Very dark background (scaffold)
- **Surface Light:** `#1E1E2E` - Slightly lighter (cards, app bars)
- **Card Color:** `#252538` - Card backgrounds

**Why layered surfaces?**
- Creates depth without being distracting
- Helps distinguish UI elements
- Maintains dark theme consistency

### Text Colors
- **Text Primary:** `#E4E4E4` - Soft white (main text)
- **Text Secondary:** `#B0B0B0` - Light gray (secondary text)
- **Text Tertiary:** `#808080` - Medium gray (hints, labels)

**Why soft whites?**
- Pure white (#FFFFFF) can be too bright and cause eye strain
- Soft whites provide good contrast without being harsh
- Gray scale helps create visual hierarchy

### Status Colors (Subtle)
- **Success:** `#4CAF50` - Soft green (not jarring)
- **Warning:** `#FFB74D` - Soft orange (gentle alert)
- **Error:** `#E57373` - Soft red (not alarming)
- **Info:** `#64B5F6` - Soft blue (calm information)

**Why soft status colors?**
- Focus app shouldn't have jarring alerts
- Soft colors maintain calm atmosphere
- Still clearly distinguishable

### Timer Colors
- **Timer Active:** `#533483` - Purple (focusing)
- **Timer Paused:** `#808080` - Gray (paused state)
- **Timer Break:** `#4CAF50` - Green (break time)

---

## 📐 Design Principles

### 1. **Minimal Contrast**
- Avoid high contrast that causes eye strain
- Use subtle differences for hierarchy
- Maintain readability without brightness

### 2. **Calm & Focused**
- No bright, distracting colors
- Muted palette throughout
- Professional appearance

### 3. **Consistent Dark Theme**
- All screens use dark theme
- No light mode (focus app needs consistency)
- Reduces cognitive load

### 4. **Accessibility**
- Good contrast ratios for readability
- Text sizes are comfortable
- Colors are distinguishable for colorblind users

---

## 🎯 Usage Guidelines

### Do's ✅
- Use dark backgrounds always
- Use soft whites for text
- Use purple accent for important actions
- Use subtle colors for status indicators
- Maintain consistent spacing and borders

### Don'ts ❌
- Don't use bright colors (yellow, bright blue, etc.)
- Don't use pure white (#FFFFFF) for text
- Don't use high contrast that strains eyes
- Don't mix light and dark themes
- Don't use distracting animations or colors

---

## 🔄 Future Considerations

### Optional Light Theme (Future)
- Can be added later if users request
- But dark should remain default
- Light theme should still be muted, not bright

### Custom Themes (Future)
- Users might want to customize
- But maintain dark, calm principles
- Allow accent color changes only

---

## 📱 Platform Considerations

### Android
- Dark theme works well with system dark mode
- Can integrate with system theme settings
- Material 3 design system

### iOS
- Dark theme aligns with iOS dark mode
- Native feel on iOS devices
- Respects system accessibility settings

---

## 🎨 Color Reference

```dart
// Primary
primaryDark: #1A1A2E
primaryLight: #16213E
accentColor: #0F3460
highlightColor: #533483

// Surfaces
surfaceDark: #0F0F1E
surfaceLight: #1E1E2E
cardColor: #252538

// Text
textPrimary: #E4E4E4
textSecondary: #B0B0B0
textTertiary: #808080

// Status
success: #4CAF50
warning: #FFB74D
error: #E57373
info: #64B5F6

// Timer
timerActive: #533483
timerPaused: #808080
timerBreak: #4CAF50
```

---

## 💡 Design Rationale Summary

**For a focus app that helps break social media addiction:**

1. **Dark theme reduces distractions** - Less visual noise
2. **Calming colors promote focus** - Navy and purple are associated with concentration
3. **Soft colors reduce eye strain** - Important for long sessions
4. **Professional appearance** - Makes app feel serious and trustworthy
5. **Consistent experience** - Dark theme throughout maintains focus state

**The theme supports the app's core mission:**
- Help users focus
- Reduce distractions
- Create calm, focused environment
- Make long sessions comfortable

---

## 🚀 Implementation

The theme is implemented in:
- `lib/core/theme/app_theme.dart` - Complete theme definition
- `lib/app/app.dart` - Theme applied to MaterialApp

**Current Status:**
- ✅ Dark theme implemented
- ✅ All colors defined
- ✅ Material 3 design system
- ✅ Consistent across app
- ✅ Eye-friendly color palette


# StayZone - Feature Roadmap

## Overview
This document outlines all features organized by development phases. Features are prioritized based on value, complexity, and user impact.

## 🎯 **Key Focus: Breaking Social Media Addiction**

**This app is designed to actively break social media addiction, not just track focus time.**

### Critical Changes for Addiction-Breaking:
- ✅ **Distraction Blocker moved to Phase 1** (was Phase 5) - Real-time app blocking is essential
- ✅ **Addiction-Breaking Mode added** - Specialized mode for social media addiction
- ✅ **Usage Monitoring added** - Track social media usage to create awareness
- ✅ **Withdrawal Support added** - Help users through difficult first days
- ✅ **Enhanced Accountability** - Strong consequences and accountability partners

**The app focuses on:**
- **60% Prevention** (active blocking, real-time intervention)
- **30% Support** (withdrawal help, replacement activities)
- **10% Tracking** (awareness, progress visualization)

**Not just a timer app - an addiction-breaking tool.**

---

## 🚀 Phase 1: Core MVP (Essential Features)

### 1.1 Deep Focus Timer ⭐ **CRITICAL**
**Priority:** Highest  
**Complexity:** Medium  
**Description:**
- Core focus session timer with leave-app detection
- If user leaves app → show reminder notification
- If screen locks → allowed (user is still focused)
- If break ends → reminder to return to focus
- Session history tracking
- Auto-save progress

**Why it's essential:** This is the core value proposition of the app.

---

### 1.2 Distraction Blocker ⭐ **CRITICAL FOR ADDICTION-BREAKING**
**Priority:** Highest  
**Complexity:** High  
**Description:**
**Real-time app blocking system** (moved from Phase 5 - this is essential for breaking social media addiction)

**Android (Full Blocking):**
- Using Accessibility Service to detect and block apps
- Instant redirect when user tries to open blocked app
- Show "Blocked during focus session" screen with motivational message
- Vibrate or warn user
- Emergency bypass (3-5 second hold with reason prompt)

**iOS (Limited but Effective):**
- Use Screen Time API to detect usage
- Strong interventions and alerts
- Focus Modes integration
- Track and alert on usage

**Features:**
- Customizable blocked app list (Instagram, TikTok, Snapchat, Twitter, Facebook, YouTube Shorts, etc.)
- Block attempts counter ("You tried to open Instagram 5 times - stay strong!")
- Escalating interventions (1st attempt = gentle, 3rd = stronger message)
- Pre-session app selection
- Block attempt tracking and reporting

**Why it's essential:** Without active blocking, users with addiction will ignore reminders. This is THE core differentiator for breaking social media addiction.

---

### 1.3 Addiction-Breaking Mode ⭐ **NEW - CRITICAL**
**Priority:** Highest  
**Complexity:** Medium  
**Description:**
Specialized mode specifically designed for social media addiction:

**Pre-Session Setup:**
- User selects which apps to block
- Sets session duration (start with 25 min, build up)
- Chooses intervention level (gentle → strict)

**During Session:**
- All selected apps are blocked
- If user tries to open blocked app → instant redirect to StayZone
- Shows motivational message: "You're stronger than this urge. Keep going!"
- Tracks number of block attempts
- Shows progress: "5 minutes focused, 20 to go!"

**Post-Session:**
- Shows success stats: "You resisted 8 attempts to check social media!"
- Celebrates small wins
- Suggests next session time

**Why it's essential:** This is the core differentiator. Without this, you're just another timer app.

---

### 1.4 Smart Session Types
**Priority:** High  
**Complexity:** Low  
**Description:**
User selects from predefined modes:
- Study Mode
- Work Mode
- Gym Mode
- Exam Revision
- Prayer / Quran Reading
- Writing Mode
- Reading Mode
- Custom Mode (user-defined)

Each mode can have:
- Custom duration defaults
- Mode-specific rules (e.g., Reading Mode = auto-dimming)
- Mode-specific sounds/themes

**Why it's essential:** Personalization increases user engagement and makes the app feel tailored.

---

### 1.5 Break Mode
**Priority:** High  
**Complexity:** Low  
**Description:**
- User can take scheduled or manual breaks
- Break timer displayed on screen
- During break: no reminders, relaxed mode
- Optional breathing animation
- When break ends: gentle reminder to return

**Why it's essential:** Prevents burnout and improves long-term usage.

---

### 1.6 Session History & Statistics
**Priority:** High  
**Complexity:** Medium  
**Description:**
- Track all focus sessions
- Daily, weekly, monthly totals
- Average session length
- Best focus day
- Total focused time

**Why it's essential:** Users need to see their progress to stay motivated.

---

### 1.7 Basic Usage Monitoring ⭐ **NEW**
**Priority:** High  
**Complexity:** Medium  
**Description:**
Track social media usage even outside focus sessions:

- **Daily Usage Tracker:**
  - Shows: "You spent 3 hours on Instagram today"
  - Compares to previous days
  - "You reduced usage by 40% this week!"
  
- **Usage Alerts:**
  - "You've been on TikTok for 30 minutes - time to focus?"
  - "You opened Instagram 15 times today - start a focus session?"
  
- **Usage Heatmap:**
  - Shows when user is most likely to use social media
  - Helps identify triggers (boredom, stress, specific times)

**Why it's essential:** Awareness is the first step. Users often don't realize how much they use social media.

---

### 1.8 Basic Heatmap (Daily/Weekly)
**Priority:** Medium  
**Complexity:** Medium  
**Description:**
- Visual heatmap showing focus hours
- Daily view: hours of the day
- Weekly view: days of the week
- Color intensity based on focus duration

**Why it's essential:** Visual data is highly engaging and helps users identify patterns.

---

### 1.9 Minimal Mode
**Priority:** Medium  
**Complexity:** Low  
**Description:**
- Dark screen with large timer
- Subtle breathing animation
- No buttons or distractions
- Pure focus interface

**Why it's essential:** Creates premium, distraction-free experience.

---

## 🎮 Phase 2: Engagement & Gamification

### 2.1 Withdrawal Support System ⭐ **NEW - CRITICAL FOR ADDICTION**
**Priority:** High  
**Complexity:** Medium  
**Description:**
Help users through the difficult first days of breaking addiction:

- **Day 1-3:** Extra encouragement, frequent check-ins
- **Urge Journal:** When user feels urge → quick log button
  - "I want to check Instagram because I'm bored"
  - App suggests: "Try 5 deep breaths instead"
- **Replacement Activities:**
  - When urge detected → suggest alternatives
  - "Instead of scrolling, try: Read 1 page, Do 10 push-ups, Meditate 2 min"
- **Withdrawal Progress:**
  - "Day 3 of breaking the habit - you're doing great!"
  - "Your brain is rewiring - this gets easier!"

**Why it's essential:** First 3-7 days are hardest. Support here = higher success rate.

---

### 2.2 Enhanced Accountability ⭐ **ENHANCED**
**Priority:** High  
**Complexity:** Medium  
**Description:**
Stronger accountability beyond basic streaks:

- **Accountability Partner:**
  - Share progress with friend/family
  - They get notified if you break streak
  - Optional: They can send encouragement
  
- **Public Commitment:**
  - "I commit to 7 days without Instagram"
  - Share on social media (ironic but effective)
  - Public tracking
  
- **Consequences System:**
  - User sets own consequences: "If I break session, I donate $5 to charity"
  - Or: "If I break, I do 50 push-ups"
  - App tracks and reminds

- **Break Attempt Penalties:**
  - Each blocked app attempt extends session by 1 minute
  - Or: Loses streak if too many attempts
  - Creates real cost for giving in

**Why it's essential:** Weak accountability = users give up. Strong accountability = behavior change.

---

### 2.3 Smart Intervention System ⭐ **NEW**
**Priority:** High  
**Complexity:** Medium  
**Description:**
Proactive interventions based on behavior:

- **Trigger Detection:**
  - "You always check Instagram at 3 PM - start a focus session then?"
  - "You use TikTok when stressed - try breathing exercise instead?"
  
- **Preventive Blocking:**
  - Auto-start focus session at high-risk times
  - "Based on your patterns, you usually scroll now. Start focus mode?"
  
- **Contextual Messages:**
  - If user tries to open Instagram at 2 AM: "It's late, you'll regret this tomorrow"
  - If user tries during work hours: "Focus on work - social media can wait"
  - If user tries after just closing it: "You just checked 2 minutes ago - resist the urge!"

**Why it's valuable:** Proactive assistance prevents relapses before they happen.

---

### 2.4 Streaks System
**Priority:** High  
**Complexity:** Low  
**Description:**
- Track consecutive days with focus sessions
- Display current streak prominently
- Streak milestones: 3, 7, 14, 30, 60, 100 days
- Streak recovery (grace period for missed days)

**Why it's valuable:** Streaks create habit formation and daily engagement.

---

### 2.5 Achievements & Badges
**Priority:** High  
**Complexity:** Low  
**Description:**
Achievement examples:
- "First Focus" - Complete first session
- "3-Day Warrior" - 3-day streak
- "7-Day Champion" - 7-day streak
- "30 Days No-Distract King" - 30-day streak
- "Hour Master" - Complete 1-hour session
- "100 Sessions" - Complete 100 sessions
- "Ramadan Focus Challenge" - Special event badge
- "No Distraction" - Complete session without leaving app

**Why it's valuable:** Gamification increases long-term retention.

---

### 2.6 Goals & Tasks
**Priority:** Medium  
**Complexity:** Medium  
**Description:**
Simple goal tracking (not full to-do list):
- "Study 2 hours today"
- "Finish 5 sessions this week"
- "Read 30 minutes daily"
- Auto-track progress
- Goal completion notifications

**Why it's valuable:** Gives users clear targets and sense of accomplishment.

---

### 2.7 Quotes & Motivational Cards
**Priority:** Low  
**Complexity:** Low  
**Description:**
- Show motivational quotes at session start/end
- Examples:
  - "One focused hour beats 10 distracted hours."
  - "Discipline beats motivation."
  - "Stay in the zone."
- Can be curated or AI-generated
- User can favorite quotes

**Why it's valuable:** Low effort, positive emotional impact.

---

### 2.8 Vibration Warnings
**Priority:** Medium  
**Complexity:** Low  
**Description:**
- If user leaves app → short vibration
- If distraction detected → gentle buzz
- If streak broken → subtle alert
- Customizable vibration patterns

**Why it's valuable:** Non-intrusive way to keep users focused.

---

## 🎨 Phase 3: Enhanced Experience

### 3.1 Ambient Focus Sounds
**Priority:** High  
**Complexity:** Medium  
**Description:**
Background sound options:
- Rain
- Lo-fi beats
- Deep bass hum
- Nature sounds
- Café ambience
- White noise
- Brown noise
- Quran recitation (optional)
- Custom sound upload

Features:
- Volume control
- Fade in/out
- Mix multiple sounds
- Timer-based auto-stop

**Why it's valuable:** Soundscapes significantly improve focus for many users.

---

### 3.2 Advanced Heatmap (Monthly + Patterns)
**Priority:** Medium  
**Complexity:** Medium  
**Description:**
Expand heatmap to include:
- Monthly view
- Distraction heatmap (hours user left app)
- Break usage patterns
- Best focus hours analysis
- Worst hours identification
- Pattern recognition (e.g., "You focus best on Tuesdays")

**Why it's valuable:** Deeper insights help users optimize their schedule.

---

### 3.3 Micro Journaling
**Priority:** Low  
**Complexity:** Low  
**Description:**
- At end of session: prompt to write one line
- "What did you accomplish?"
- Simple text input
- View journal entries in history
- Optional: export journal

**Why it's valuable:** Helps users reflect and track mental progress.

---

### 3.4 Screen-Shield Mode
**Priority:** Medium  
**Complexity:** Low  
**Description:**
- Dim screen significantly
- Lock navigation buttons
- Prevent accidental exits
- Useful for study, reading, meditation
- Emergency exit (long press)

**Why it's valuable:** Creates deeper focus state for specific use cases.

---

### 3.5 Rewards Store (Points System)
**Priority:** Medium  
**Complexity:** Medium  
**Description:**
Earn points for:
- Completing sessions
- Finishing long sessions
- Avoiding distractions
- Keeping streaks
- Daily check-ins

Spend points on:
- Custom themes
- Sound packs
- App icons
- Achievement badges
- Unlock premium features

**Why it's valuable:** Creates engagement loop and monetization opportunity.

---

## 🤖 Phase 4: Advanced Features

### 4.1 AI Focus Assistant (Simplified)
**Priority:** Medium  
**Complexity:** High  
**Description:**
Simple, rule-based insights (not full AI):
- "You lose focus at 7 pm, avoid working then."
- "Your best productivity hour is 11 am."
- "You got distracted 12 times this week."
- "Try shorter sessions on weekends."
- "Your focus improved 20% this month."

**Implementation:** Pattern analysis based on session data, not ML.

**Why it's valuable:** Makes app feel intelligent and personalized.

---

### 4.2 Smart Auto Mode
**Priority:** Medium  
**Complexity:** Medium  
**Description:**
App suggests focus mode when:
- User opened phone 10+ times in 5 minutes
- Screen time is high
- Late night detected (study time)
- Exam week detected (calendar integration)
- User's typical focus time approaches

**Why it's valuable:** Proactive assistance increases usage.

---

### 4.3 Cloud Sync
**Priority:** High  
**Complexity:** High  
**Description:**
If user logs in (Supabase):
- Focus sessions sync across devices
- Heatmaps stored online
- Streaks carry over
- Achievements saved
- Restores on new phone
- Guest mode: local storage only

**Why it's valuable:** Essential for user retention and multi-device usage.

---

## 📱 Phase 5: Platform-Specific Features

### 5.1 Home Screen Widget
**Priority:** High  
**Complexity:** Medium  
**Description:**
Widget shows:
- Quick start button
- Last session length
- Today's focus stats
- Current streak
- Motivational quote

**Platforms:** iOS and Android

**Why it's valuable:** Increases daily engagement and visibility.

---

### 5.2 Lock-Screen Timer (iOS 16+ / Android)
**Priority:** High  
**Complexity:** Medium  
**Description:**
- Beautiful lock screen widget
- Large timer display
- Minimal design
- Session progress ring
- Quick pause/resume

**Why it's valuable:** Users love seeing progress without unlocking phone.

---

### 5.3 Social Media Detox Challenges ⭐ **NEW**
**Priority:** Medium  
**Complexity:** Medium  
**Description:**
Structured challenges to break addiction:

- **7-Day Detox Challenge:**
  - No social media for 7 days
  - Daily check-ins
  - Progress tracking
  - Community support
  
- **30-Day Reset:**
  - Gradual reduction (Week 1: 2 hours/day, Week 2: 1 hour/day, etc.)
  - Milestone rewards
  - Final celebration
  
- **App-Specific Challenges:**
  - "No Instagram for 1 week"
  - "TikTok-free month"
  - Custom challenges

**Why it's valuable:** Structured programs have higher success rates than self-directed attempts.

**Note:** Distraction Blocker moved to Phase 1 (Critical MVP feature)

---

## 👥 Phase 6: Social & Advanced

### 6.1 Focus Room (Group Sessions)
**Priority:** Low  
**Complexity:** High  
**Description:**
- Friends can join same focus session
- If one person leaves → everyone gets notified
- Group accountability
- Private rooms (invite-only)
- Public rooms (anyone can join)
- Leaderboard for group

**Why it's valuable:** Viral potential, but complex to implement. Consider for later phase.

---

## 📊 Feature Priority Summary

### Must-Have (Phase 1):
1. Deep Focus Timer
2. **Distraction Blocker** ⭐ (MOVED FROM PHASE 5 - CRITICAL)
3. **Addiction-Breaking Mode** ⭐ (NEW - CRITICAL)
4. Smart Session Types
5. Break Mode
6. Session History
7. **Basic Usage Monitoring** ⭐ (NEW)
8. Basic Heatmap
9. Minimal Mode

### Should-Have (Phase 2):
1. **Withdrawal Support System** ⭐ (NEW - CRITICAL)
2. **Enhanced Accountability** ⭐ (ENHANCED)
3. **Smart Intervention System** ⭐ (NEW)
4. Streaks System
5. Achievements
6. Goals & Tasks
7. Vibration Warnings

### Nice-to-Have (Phase 3):
1. Ambient Focus Sounds
2. Advanced Heatmap
3. Micro Journaling
4. Screen-Shield Mode
5. Rewards Store

### Advanced (Phase 4+):
1. AI Focus Assistant (Simplified)
2. Smart Auto Mode
3. Cloud Sync
4. Platform Widgets
5. Social Media Detox Challenges
6. Focus Room (Future)

---

## 🎯 MVP Definition

**Minimum Viable Product should include:**
- Deep Focus Timer with leave-app detection
- **Distraction Blocker** ⭐ (Real-time app blocking - CRITICAL)
- **Addiction-Breaking Mode** ⭐ (Specialized mode for social media addiction)
- 3-5 Session Types (Study, Work, Reading, Custom)
- Break Mode
- Basic Session History
- **Basic Usage Monitoring** ⭐ (Track social media usage)
- Simple Heatmap (Daily/Weekly)
- Streaks System
- Basic Achievements

**This MVP provides:**
- **Active prevention** (not just passive tracking)
- **Real-time intervention** (blocks apps immediately)
- Core value proposition for addiction-breaking
- User engagement
- Data tracking
- Gamification basics

**Key Difference:** This MVP actively prevents social media use, not just tracks it.

---

## 📝 Notes

- Features marked as "Low Priority" can be deprioritized if timeline is tight
- Platform-specific features (Android Distraction Blocker) should be clearly marked
- Cloud Sync is important but can come after MVP
- Focus Room is ambitious and should be considered for v2.0+
- All features should respect user privacy and permissions

---

## 🔄 Iteration Plan

1. **Week 1-2:** Phase 1 Core MVP
2. **Week 3-4:** Phase 2 Engagement Features
3. **Week 5-6:** Phase 3 Enhanced Experience
4. **Week 7-8:** Phase 4 Advanced Features
5. **Week 9-10:** Phase 5 Platform Features
6. **Future:** Phase 6 Social Features

*Timeline is flexible based on team size and priorities.*


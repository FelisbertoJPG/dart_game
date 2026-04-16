# Dev Log #01: MVP Foundation & Core Mechanics

**Date**: 2026-04-16
**Status**: Completed

## Overview
This log covers the initial implementation of DashLingo, establishing the architecture, design system, and core learning mechanics.

## Implementation Details

### 1. Architecture & state Management
- **Framework**: Flutter (Dart).
- **Riverpod**: Chosen for its robust provider-based state management. I implemented `userStateProvider` to track:
  - `completedModules`: For path progression.
  - `hearts`: For the gamification "health" system.
  - `xp`: For user engagement.
- **Provider Family**: `quizProvider` uses `.family` to maintain independent state for different module sessions.

### 2. Design System
- **Theme**: Created `AppColors` based on Duolingo's vibrant palette (Blue, Green, Red).
- **Typography**: Integrated `Google Fonts` (Outfit) for a modern, clean look.
- **Components**:
  - `ModuleNode`: Custom container with zigzag logic and bottom-border shadow for a 3D effect.
  - `OptionCard`: Interactive card with multi-state feedback (Selected, Correct, Incorrect).

### 3. Feature: Module Path Map
- Implemented a scrollable vertical list in `ModulePathScreen`.
- Navigation logic handles "Locking" based on the previous module's completion status.

### 4. Feature: Quiz Engine
- Functional quiz flow: Question -> Option Selection -> Verification -> Feedback -> Next Question.
- Support for **Code Snippets** using a monospace font and dark background container to mimic an IDE.
- Integration with the Heart system: Incorrect answers trigger `loseHeart()`.

## Files Created/Modified
- `lib/main.dart`: App entry point.
- `lib/core/theme.dart`: Design tokens.
- `lib/features/modules/`: Domain models, curriculum data, and Path Map UI.
- `lib/features/quiz/`: Quiz logic and interactive Quiz UI.
- `lib/features/profile/`: User progress state.

## Lessons & Adjustments
- **Relative Imports**: Encountered URI errors during build. Resolved by standardizing all imports to use Package-based absolute paths (`package:dash_lingo/...`).
- **Build Fixes**: Fixed `widget_test.dart` to match the new app class name `DashLingoApp`.

## Next Steps
- Implement Success Celebrations (Confetti).
- Add Mascot (Dash) animations with Lottie.
- Persist progress using `shared_preferences`.

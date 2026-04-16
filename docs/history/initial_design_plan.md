# DashLingo: Learning Dart & Flutter Gamified

DashLingo is a gamified learning platform inspired by Duolingo, designed to teach Dart and Flutter fundamentals through interactive challenges, modules, and a progression system.

## User Review Required

> [!IMPORTANT]
> **Curriculum Focus**: The initial version will focus on "Foundations of Dart" (Module 1) and "Introduction to Flutter" (Module 2). Does this sequence align with your vision, or should we jump into Flutter layout sooner?

> [!NOTE]
> **Art Style**: I propose a "Dash the Bird" centric design with a vibrant color palette (Electric Blue, Cyan, and Deep Purple). I will use Lottie animations for the mascot.

## Proposed Changes

### 1. Project Initialization & Architecture
We will initialize a new Flutter project and set up a robust, scalable architecture using Riverpod for state management. This ensures the app can grow with many modules.

#### [NEW] [Project Files](file:///c:/Users/suporteti2/StudioProjects/dart_game/)
- `pubspec.yaml`: Add dependencies like `flutter_riverpod`, `google_fonts`, `lottie`, and `go_router`.
- `lib/core/`: Application themes, constants, and routing.
- `lib/features/modules/`: Logic and UI for the module path/map.
- `lib/features/quiz/`: Logic and UI for interactive learning tasks.
- `lib/features/profile/`: User progress and XP tracking.

---

### 2. Module System & Path UI
The home screen will feature a scrollable path of "Levels" (interactive icons) that unlock sequentially as the user advances.

#### [NEW] [module_path_screen.dart](file:///c:/Users/suporteti2/StudioProjects/dart_game/lib/features/modules/presentation/module_path_screen.dart)
- Vertical path with animated nodes using a zigzag layout.
- Status indicators (Locked, Current, Completed).
- Module locking/unlocking logic based on user state.

---

### 3. Quiz Interface
The core learning experience, designed to be fast and interactive.

#### [NEW] [quiz_screen.dart](file:///c:/Users/suporteti2/StudioProjects/dart_game/lib/features/quiz/presentation/quiz_screen.dart)
- Progress bar at the top with a heart system.
- Multiple choice cards with feedback sound/visuals.
- "Code Snippet" fill-in-the-blanks using custom text field widgets.
- Interactive Feedback (Pop-ups for Correct/Incorrect with Mascot animations).

---

### 4. Curriculum Data
A seed file containing the initial modules and questions structured for easy expansion.

#### [NEW] [curriculum_data.dart](file:///c:/Users/suporteti2/StudioProjects/dart_game/lib/features/modules/domain/curriculum_data.dart)
- **Module 1: The Dart Way**: Variables, `final`, `const`, Basic Types (`int`, `String`, `bool`).
- **Module 2: Flow Control**: `if/else`, `switch`, `for` loops.
- **Module 3: Flutter Foundations**: The `Widget` tree, `MaterialApp`, `Scaffold`.

## Open Questions

1. **Gamification Specifics**: Should we implement a "Hearts" system (limited mistakes before waiting for recharge) right away, or keep it simple (unlimited attempts) for the MVP?
2. **Persistence**: Do you want user progress to persist between app restarts (using `shared_preferences`)?
3. **Mascot**: Are you happy with using Dash (the official mascot) or should we create a custom character?

## Verification Plan

### Automated Tests
- `flutter test`: Unit tests for module unlocking logic.
- Widget tests for the Quiz Screen state transitions.

### Manual Verification
- Verify the "Lock" mechanism: Module 2 should be unclickable until Module 1 is finished.
- Check cross-device responsiveness (tablet vs phone).
- Ensure animations (Lottie) trigger correctly on quiz completion.

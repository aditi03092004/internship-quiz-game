# Quiz Master – Interactive Flutter Quiz Application

A polished, production-ready interactive mobile quiz application developed with Flutter and Dart for an internship technical assessment. **Quiz Master** provides an engaging educational trivia experience with immediate visual feedback, detailed explanations, live progress tracking, and performance analysis.

---

## 🎯 Internship Project Objective

The primary objective is to build a robust, responsive, and maintainable multiple-choice quiz application adhering to clean architecture principles and Material 3 design standards:
- Present 10 curated questions spanning core Computer Science and Software Engineering disciplines.
- Provide real-time answer verification with intuitive color feedback and educational explanations.
- Prevent duplicate scoring and disallow changing answers after submission.
- Provide comprehensive performance metrics upon quiz completion.
- Allow seamless quiz restarts with full state reset.

---

## ✨ Features

- **Material 3 Design**: Clean sapphire-blue and crisp white aesthetics, rounded cards, soft drop shadows, and modern typography.
- **10 Curated Technical Questions**: Covers Flutter fundamentals, Dart language mechanics, Object-Oriented Programming (OOP), Data Structures & Algorithms, CI/CD, and mobile architecture.
- **Immediate Answer Feedback**:
  - ✅ **Correct Answer**: Highlighted in vibrant green with a checkmark badge and affirmative confirmation.
  - ❌ **Incorrect Answer**: Highlighted in red with a cancel icon, while simultaneously highlighting the correct answer in green for transparent learning.
  - 💡 **Explanations**: Clear, contextual explanations displayed for every question.
- **Single-Answer Enforcement**: Once an option is tapped, answers are locked to prevent multiple selections or score manipulation.
- **Dynamic Progress Tracking**:
  - Live progress bar with numerical indicators (`Question X of 10`) and percentage metrics.
  - Real-time score counter updated in the app bar.
- **Comprehensive Results Screen**:
  - Performance tier feedback with dynamic badges and icons:
    - **9–10 Correct**: *Excellent! Outstanding performance.* (Gold Trophy)
    - **7–8 Correct**: *Great job! Keep it up.* (Blue Star)
    - **5–6 Correct**: *Good effort! Keep practicing.* (Orange Thumbs-Up)
    - **0–4 Correct**: *Don't give up! Practice makes perfect.* (Crimson Refresh)
  - Detailed score breakdown (Correct vs. Incorrect cards, accuracy percentage).
- **One-Tap Quiz Restart**: Full state reset directly from the results screen without reloading or restarting the app.
- **Responsive Layout**: Designed with `SafeArea` and `SingleChildScrollView` to prevent screen overflows on compact mobile devices or landscape mode.

---

## 🛠️ Technologies & Dependencies

- **Framework**: [Flutter 3.x](https://flutter.dev/)
- **Language**: [Dart 3.x](https://dart.dev/)
- **UI Design System**: Material 3 Design
- **State Management**: Clean `StatefulWidget` and `setState()`
- **Navigation**: `Navigator.push()`, `Navigator.pushReplacement()`, and `Navigator.pop()`
- **Icons**: Built-in Material Icons (no unnecessary external dependencies)

---

## 📊 Scoring System

| Correct Answers | Percentage | Tier | Feedback Message |
|:---:|:---:|:---:|:---|
| 9 – 10 | 90% – 100% | Master | *Excellent! Outstanding performance.* |
| 7 – 8 | 70% – 80% | Proficient | *Great job! Keep it up.* |
| 5 – 6 | 50% – 60% | Intermediate | *Good effort! Keep practicing.* |
| 0 – 4 | 0% – 40% | Novice | *Don't give up! Practice makes perfect.* |

---

## 📁 Project Folder Structure

```
lib/
├── main.dart                   # Application entry point & ThemeData setup
├── data/
│   └── quiz_questions.dart     # 10 curated multiple-choice questions & explanations
├── models/
│   └── question.dart           # Immutable Question model
├── screens/
│   ├── home_screen.dart        # Welcome screen with start action
│   ├── quiz_screen.dart        # Quiz interface, answer selection & feedback logic
│   └── result_screen.dart      # Results summary, score breakdown & restart
└── widgets/
    ├── answer_option.dart      # Interactive 4-choice selectable option card
    ├── question_card.dart      # Rounded card displaying the question prompt
    └── quiz_progress.dart      # Dynamic LinearProgressIndicator and score badges
test/
└── widget_test.dart            # Comprehensive widget and logic test suite (13 tests)
```

---

## 📱 Screenshots

| Home Screen | Quiz Screen (Active) | Immediate Feedback | Results Screen |
|:---:|:---:|:---:|:---:|
| *(Welcome & Start)* | *(Questions & Options)* | *(Correct/Wrong Feedback)* | *(Score & Performance)* |

---

## 🚀 Getting Started & Installation

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version `>=3.12.0`)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- Android Studio / VS Code / IntelliJ IDEA with Flutter extensions installed
- Connected mobile device, emulator, or desktop browser

### 1. Clone the Repository
```bash
git clone https://github.com/aditi03092004/internship-quiz-game.git
cd internship-quiz-game
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Verify Code Analysis
```bash
flutter analyze
```
*(Expected: No issues found!)*

### 4. Run the Widget Tests
```bash
flutter test
```
*(Expected: All 13 tests passed!)*

### 5. Run the Application
Launch on your connected device or Chrome:
```bash
# Run on default connected device
flutter run

# Or run in Chrome (web)
flutter run -d chrome

# Or run on Windows desktop
flutter run -d windows
```

---

## 🧪 Testing Verification

The project includes thorough unit and widget tests in `test/widget_test.dart` covering:
1. **Data Integrity**: Exactly 10 questions, 4 options each, valid answer indexes, no duplicate IDs.
2. **Home Screen**: Verification of title, subtitle, badges, and navigation to the quiz screen.
3. **Quiz Interface**: Question rendering, 4 option tiles, initial disabled state for Next button.
4. **Scoring Logic**: Score increments only upon selecting the correct option; incorrect answers do not increase score.
5. **Feedback Visuals**: Display of green / red cards and contextual explanations.
6. **Selection Immutability**: Enforcing one answer selection per question.
7. **Question Navigation**: Transition between questions and state reset.
8. **Results Screen & Restart**: Verification of final score, percentage, performance tiers, and clean quiz restart.

---

## 📄 License
This project is submitted for the internship evaluation and is available under the MIT License.

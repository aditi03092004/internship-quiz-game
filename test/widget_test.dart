import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/data/quiz_questions.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/result_screen.dart';

void main() {
  group('Quiz Questions Data Integrity Tests', () {
    test('Quiz questions list has exactly 10 questions', () {
      expect(quizQuestions.length, 10);
    });

    test('Every question has exactly 4 options and valid correct index', () {
      for (final q in quizQuestions) {
        expect(q.options.length, 4,
            reason: 'Question ${q.questionId} must have 4 options');
        expect(q.correctAnswerIndex >= 0 && q.correctAnswerIndex < 4, true,
            reason:
                'Question ${q.questionId} must have correct index between 0 and 3');
        expect(q.questionText.isNotEmpty, true);
        expect(q.explanation != null && q.explanation!.isNotEmpty, true);
      }
    });

    test('There are no duplicate questions or question IDs', () {
      final ids = quizQuestions.map((q) => q.questionId).toSet();
      expect(ids.length, 10);
      final texts = quizQuestions.map((q) => q.questionText).toSet();
      expect(texts.length, 10);
    });
  });

  group('Home Screen Tests', () {
    testWidgets('Home screen renders all essential UI elements',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      // Verify Title, Subtitle, and Description
      expect(find.text('Quiz Master'), findsOneWidget);
      expect(find.text('Test Your Knowledge'), findsOneWidget);
      expect(
        find.text(
            'Challenge yourself with 10 exciting questions and see how much you know.'),
        findsOneWidget,
      );

      // Verify Feature badges
      expect(find.text('10 Questions'), findsOneWidget);
      expect(find.text('No Rush'), findsOneWidget);
      expect(find.text('Feedback'), findsOneWidget);

      // Verify Start Quiz Button
      expect(find.byKey(const Key('start_quiz_button')), findsOneWidget);
      expect(find.text('Start Quiz'), findsOneWidget);
    });

    testWidgets('Tapping Start Quiz navigates to Quiz Screen',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const QuizApp());

      final startButton = find.byKey(const Key('start_quiz_button'));
      expect(startButton, findsOneWidget);

      await tester.ensureVisible(startButton);
      await tester.tap(startButton);
      await tester.pumpAndSettle();

      // Should now be on Quiz Time screen
      expect(find.text('Quiz Time'), findsOneWidget);
      expect(find.text('Question 1 of 10'), findsOneWidget);
    });
  });

  group('Quiz Screen Interactive Flow Tests', () {
    const testSampleQuestions = [
      Question(
        questionId: 1,
        questionText: 'Test Question 1?',
        options: ['Opt A', 'Opt B', 'Opt C', 'Opt D'],
        correctAnswerIndex: 1, // Opt B
        explanation: 'Opt B is correct.',
      ),
      Question(
        questionId: 2,
        questionText: 'Test Question 2?',
        options: ['Choice 1', 'Choice 2', 'Choice 3', 'Choice 4'],
        correctAnswerIndex: 0, // Choice 1
        explanation: 'Choice 1 is correct.',
      ),
    ];

    testWidgets('Displays question text and 4 selectable options',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: QuizScreen(customQuestions: testSampleQuestions),
        ),
      );

      expect(find.text('Quiz Time'), findsOneWidget);
      expect(find.text('Question 1 of 2'), findsOneWidget);
      expect(find.text('Test Question 1?'), findsOneWidget);

      expect(find.byKey(const Key('option_0')), findsOneWidget);
      expect(find.byKey(const Key('option_1')), findsOneWidget);
      expect(find.byKey(const Key('option_2')), findsOneWidget);
      expect(find.byKey(const Key('option_3')), findsOneWidget);

      // Next button should be disabled initially
      final nextButtonFinder = find.byKey(const Key('next_button'));
      final ElevatedButton nextButton = tester.widget(nextButtonFinder);
      expect(nextButton.onPressed, isNull);
    });

    testWidgets(
        'Selecting correct answer displays green feedback, explanation, and increments score',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: QuizScreen(customQuestions: testSampleQuestions),
        ),
      );

      // Option 1 is correct for Question 1
      await tester.tap(find.byKey(const Key('option_1')));
      await tester.pumpAndSettle();

      // Check feedback
      expect(find.text('Correct Answer!'), findsOneWidget);
      expect(find.text('Opt B is correct.'), findsOneWidget);

      // Score should be 1
      expect(find.text('Score: 1'), findsOneWidget);

      // Next button should now be enabled
      final ElevatedButton nextButton =
          tester.widget(find.byKey(const Key('next_button')));
      expect(nextButton.onPressed, isNotNull);
    });

    testWidgets(
        'Selecting incorrect answer displays red feedback, highlights correct answer, and does not increment score',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: QuizScreen(customQuestions: testSampleQuestions),
        ),
      );

      // Option 0 is wrong for Question 1 (correct is 1)
      await tester.tap(find.byKey(const Key('option_0')));
      await tester.pumpAndSettle();

      // Check feedback
      expect(find.text('Incorrect Answer!'), findsOneWidget);
      expect(find.text('Opt B is correct.'), findsOneWidget);

      // Score should remain 0
      expect(find.text('Score: 0'), findsOneWidget);
    });

    testWidgets(
        'User cannot change answer after selecting one (single answer enforcement)',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: QuizScreen(customQuestions: testSampleQuestions),
        ),
      );

      // Select Option 1 (Correct)
      await tester.tap(find.byKey(const Key('option_1')));
      await tester.pumpAndSettle();
      expect(find.text('Score: 1'), findsOneWidget);

      // Try tapping another option (Option 2)
      await tester.tap(find.byKey(const Key('option_2')));
      await tester.pumpAndSettle();

      // Score should still be 1, feedback still says Correct Answer!
      expect(find.text('Score: 1'), findsOneWidget);
      expect(find.text('Correct Answer!'), findsOneWidget);
    });

    testWidgets('Tapping Next navigates to next question and resets state',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: QuizScreen(customQuestions: testSampleQuestions),
        ),
      );

      // Answer question 1
      await tester.tap(find.byKey(const Key('option_1')));
      await tester.pumpAndSettle();

      // Tap Next button
      await tester.tap(find.byKey(const Key('next_button')));
      await tester.pumpAndSettle();

      // Should now be Question 2 of 2
      expect(find.text('Question 2 of 2'), findsOneWidget);
      expect(find.text('Test Question 2?'), findsOneWidget);
      expect(find.text('Choice 1'), findsOneWidget);

      // Feedback should be cleared
      expect(find.text('Correct Answer!'), findsNothing);
      expect(find.text('Incorrect Answer!'), findsNothing);

      // Next button should be disabled again
      final ElevatedButton nextButton =
          tester.widget(find.byKey(const Key('next_button')));
      expect(nextButton.onPressed, isNull);
    });

    testWidgets('Completing quiz navigates to Results Screen',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: QuizScreen(customQuestions: testSampleQuestions),
        ),
      );

      // Q1: Answer correctly (Option 1)
      await tester.tap(find.byKey(const Key('option_1')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('next_button')));
      await tester.pumpAndSettle();

      // Q2: Answer correctly (Option 0)
      await tester.tap(find.byKey(const Key('option_0')));
      await tester.pumpAndSettle();

      // Button should say 'View Results'
      expect(find.text('View Results'), findsOneWidget);
      await tester.tap(find.byKey(const Key('next_button')));
      await tester.pumpAndSettle();

      // Should be on Results Screen
      expect(find.text('Quiz Completed!'), findsOneWidget);
      expect(find.text('2'), findsWidgets); // Score
      expect(find.text('100% Score'), findsOneWidget);
      expect(find.byKey(const Key('restart_quiz_button')), findsOneWidget);
    });
  });

  group('Results Screen and Restart Tests', () {
    testWidgets(
        'Displays score, percentage, correct/incorrect, performance message, and restart button',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ResultScreen(score: 8, totalQuestions: 10),
        ),
      );

      expect(find.text('Quiz Completed!'), findsOneWidget);
      expect(find.text('8'), findsWidgets); // Score & Correct stat
      expect(find.text(' / 10'), findsOneWidget);
      expect(find.text('80% Score'), findsOneWidget);
      expect(find.text('Great job! Keep it up.'), findsOneWidget);
      expect(find.text('Correct'), findsOneWidget);
      expect(find.text('Incorrect'), findsOneWidget);
      expect(find.text('2'), findsOneWidget); // 10 - 8 = 2

      expect(find.byKey(const Key('restart_quiz_button')), findsOneWidget);
      expect(find.byKey(const Key('back_to_home_button')), findsOneWidget);
    });

    testWidgets('Tapping Restart Quiz resets and loads Question 1',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ResultScreen(score: 7, totalQuestions: 10),
        ),
      );

      final restartButton = find.byKey(const Key('restart_quiz_button'));
      await tester.ensureVisible(restartButton);
      await tester.tap(restartButton);
      await tester.pumpAndSettle();

      // Verify fresh QuizScreen loaded
      expect(find.text('Quiz Time'), findsOneWidget);
      expect(find.text('Question 1 of 10'), findsOneWidget);
      expect(find.text('Score: 0'), findsOneWidget);
    });
  });
}

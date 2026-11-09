import 'package:flutter/material.dart';
import '../data/quiz_questions.dart';
import '../models/question.dart';
import '../widgets/answer_option.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_progress.dart';
import 'result_screen.dart';

/// Interactive Quiz screen displaying questions, selectable options, and immediate feedback.
class QuizScreen extends StatefulWidget {
  final List<Question>? customQuestions;

  const QuizScreen({super.key, this.customQuestions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<Question> _questions;
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _isAnswered = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _questions = widget.customQuestions ?? quizQuestions;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _selectOption(int optionIndex) {
    if (_isAnswered) return; // Prevent changing answer once selected

    final currentQuestion = _questions[_currentIndex];
    final bool isCorrect = optionIndex == currentQuestion.correctAnswerIndex;

    setState(() {
      _selectedOptionIndex = optionIndex;
      _isAnswered = true;
      if (isCorrect) {
        _score++;
      }
    });

    // Smoothly scroll down so feedback and next button are easily visible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _nextQuestion() {
    if (!_isAnswered) return;

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOptionIndex = null;
        _isAnswered = false;
      });
      // Scroll back to top for next question
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0.0);
      }
    } else {
      // Reached the end of quiz -> Navigate to Results Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            totalQuestions: _questions.length,
          ),
        ),
      );
    }
  }

  Future<void> _handleExitAttempt() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Color(0xFFFB8C00)),
            SizedBox(width: 8),
            Text('Leave Quiz?'),
          ],
        ),
        content: const Text(
          'Your current quiz progress and score will be lost. Are you sure you want to exit?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Stay'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
              foregroundColor: Colors.white,
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    );

    if (shouldExit == true && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No questions available')),
      );
    }

    final currentQuestion = _questions[_currentIndex];
    final isLastQuestion = _currentIndex == _questions.length - 1;
    final bool isAnswerCorrect =
        _isAnswered && _selectedOptionIndex == currentQuestion.correctAnswerIndex;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleExitAttempt();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          scrolledUnderElevation: 1.0,
          leading: IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: Color(0xFF334155),
            ),
            onPressed: _handleExitAttempt,
            tooltip: 'Exit Quiz',
          ),
          title: const Text(
            'Quiz Time',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          actions: [
            // Score indicator chip in AppBar
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E88E5).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.emoji_events_rounded,
                        size: 16,
                        color: Color(0xFF1E88E5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$_score',
                        style: const TextStyle(
                          color: Color(0xFF1E88E5),
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16.0,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 550),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Progress Bar
                          QuizProgressBar(
                            currentQuestionIndex: _currentIndex + 1,
                            totalQuestions: _questions.length,
                            currentScore: _score,
                          ),
                          const SizedBox(height: 18),

                          // Question Card
                          QuestionCard(
                            questionNumber: _currentIndex + 1,
                            questionText: currentQuestion.questionText,
                          ),
                          const SizedBox(height: 20),

                          // Options List (4 options)
                          ...List.generate(
                            currentQuestion.options.length,
                            (index) {
                              final isSelected = _selectedOptionIndex == index;
                              final isOptionCorrect =
                                  index == currentQuestion.correctAnswerIndex;

                              return AnswerOptionTile(
                                key: Key('option_$index'),
                                optionIndex: index,
                                optionText: currentQuestion.options[index],
                                isSelected: isSelected,
                                isCorrect: isOptionCorrect,
                                isAnswered: _isAnswered,
                                onTap: () => _selectOption(index),
                              );
                            },
                          ),

                          // Feedback and Explanation Card
                          if (_isAnswered) ...[
                            const SizedBox(height: 12),
                            _buildFeedbackBanner(
                              isCorrect: isAnswerCorrect,
                              explanation: currentQuestion.explanation,
                            ),
                          ],

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom Bar with Next Button
              _buildBottomActionBar(isLastQuestion: isLastQuestion),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackBanner({
    required bool isCorrect,
    required String? explanation,
  }) {
    final Color primaryColor =
        isCorrect ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    final Color bgColor =
        isCorrect ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE);
    final IconData icon =
        isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded;
    final String title = isCorrect ? 'Correct Answer!' : 'Incorrect Answer!';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: primaryColor.withValues(alpha: 0.3), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          if (explanation != null && explanation.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb_outline_rounded,
                    size: 18,
                    color: Color(0xFFE65100),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      explanation,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.4,
                        color: Color(0xFF334155),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomActionBar({required bool isLastQuestion}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 550),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              key: const Key('next_button'),
              onPressed: _isAnswered ? _nextQuestion : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFFE2E8F0),
                disabledForegroundColor: const Color(0xFF94A3B8),
                elevation: _isAnswered ? 3 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLastQuestion ? 'View Results' : 'Next Question',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isLastQuestion
                        ? Icons.emoji_events_rounded
                        : Icons.arrow_forward_rounded,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

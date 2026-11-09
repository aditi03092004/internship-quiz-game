/// Model class representing a single quiz question.
class Question {
  final int questionId;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String? explanation;

  const Question({
    required this.questionId,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.explanation,
  });
}

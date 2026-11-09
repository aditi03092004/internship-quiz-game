import '../models/question.dart';

/// Exactly 10 curated questions spanning Flutter, Dart, OOP, and Software Engineering.
final List<Question> quizQuestions = [
  const Question(
    questionId: 1,
    questionText:
        'Which Flutter widget is best suited for creating a user interface element that does not depend on any mutable state?',
    options: [
      'StatefulWidget',
      'StatelessWidget',
      'InheritedWidget',
      'StreamBuilder',
    ],
    correctAnswerIndex: 1,
    explanation:
        'StatelessWidget is an immutable widget that describes part of the user interface which does not depend on any state information beyond its initial configuration.',
  ),
  const Question(
    questionId: 2,
    questionText:
        'In Dart, which keyword is used to declare a compile-time constant variable?',
    options: ['final', 'const', 'static', 'var'],
    correctAnswerIndex: 1,
    explanation:
        'The "const" keyword in Dart creates a compile-time constant, whereas "final" creates a variable that can be assigned only once at runtime.',
  ),
  const Question(
    questionId: 3,
    questionText:
        'Which core OOP principle refers to bundling data and the methods that operate on that data into a single unit while restricting direct access?',
    options: ['Polymorphism', 'Inheritance', 'Encapsulation', 'Abstraction'],
    correctAnswerIndex: 2,
    explanation:
        'Encapsulation binds data and functions together into a single unit (class) and restricts direct external access to an object’s internal components.',
  ),
  const Question(
    questionId: 4,
    questionText:
        'What is the average time complexity for searching an element in a balanced Binary Search Tree (BST)?',
    options: ['O(1)', 'O(log n)', 'O(n)', 'O(n log n)'],
    correctAnswerIndex: 1,
    explanation:
        'Searching in a balanced BST halves the search space with each comparison, resulting in an average time complexity of O(log n).',
  ),
  const Question(
    questionId: 5,
    questionText:
        'What programming technique involves a function calling itself to solve smaller subproblems until reaching a base condition?',
    options: ['Iteration', 'Concurrency', 'Recursion', 'Memoization'],
    correctAnswerIndex: 2,
    explanation:
        'Recursion is a programming technique where a function calls itself to solve smaller instances of the same problem until reaching a termination condition.',
  ),
  const Question(
    questionId: 6,
    questionText:
        'What does the acronym "CI/CD" stand for in modern software engineering practices?',
    options: [
      'Code Inspection and Code Delivery',
      'Continuous Integration and Continuous Deployment',
      'Central Interface and Central Database',
      'Concurrent Installation and Cloud Distribution',
    ],
    correctAnswerIndex: 1,
    explanation:
        'CI/CD stands for Continuous Integration and Continuous Deployment (or Delivery), which automates building, testing, and deploying software updates.',
  ),
  const Question(
    questionId: 7,
    questionText:
        'Which Flutter feature allows developers to quickly inject updated source code into the running Dart VM without losing app state?',
    options: ['Hot Restart', 'Hot Reload', 'AOT Compilation', 'Code Push'],
    correctAnswerIndex: 1,
    explanation:
        'Hot Reload injects updated source code files into the running Dart VM and quickly rebuilds the widget tree while preserving the app’s active state.',
  ),
  const Question(
    questionId: 8,
    questionText:
        'In Flutter architecture, which layer is directly responsible for computing layout sizes, positions, and painting pixels?',
    options: [
      'Widget Tree',
      'Element Tree',
      'RenderObject Tree',
      'Platform View',
    ],
    correctAnswerIndex: 2,
    explanation:
        'The RenderObject tree handles layout geometry, constraints, hit-testing, and physical rendering to paint the interface on screen.',
  ),
  const Question(
    questionId: 9,
    questionText:
        'Which collection type in Dart is an unordered collection that cannot contain duplicate elements?',
    options: ['List', 'Map', 'Set', 'Queue'],
    correctAnswerIndex: 2,
    explanation:
        'A Set in Dart is an unordered collection of unique items. Attempting to add an element already present in the Set is ignored.',
  ),
  const Question(
    questionId: 10,
    questionText:
        'In a Flutter StatefulWidget, which method must be invoked to inform the framework that internal state has changed and schedule a rebuild?',
    options: [
      'rebuild()',
      'setState()',
      'updateState()',
      'notifyListeners()',
    ],
    correctAnswerIndex: 1,
    explanation:
        'Calling setState() tells the Flutter framework that the internal state of the State object has changed, triggering a call to the build() method.',
  ),
];

import 'package:flutter/material.dart';

/// A selectable option card representing one of the four quiz answers.
class AnswerOptionTile extends StatelessWidget {
  final int optionIndex;
  final String optionText;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswered;
  final VoidCallback? onTap;

  const AnswerOptionTile({
    super.key,
    required this.optionIndex,
    required this.optionText,
    required this.isSelected,
    required this.isCorrect,
    required this.isAnswered,
    this.onTap,
  });

  static const List<String> optionLetters = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    // Determine state colors
    Color backgroundColor = Colors.white;
    Color borderColor = const Color(0xFFE2E8F0);
    double borderWidth = 1.2;
    Color letterBgColor = const Color(0xFFF1F5F9);
    Color letterTextColor = const Color(0xFF1E88E5);
    Color textColor = const Color(0xFF1E293B);
    Widget? trailingIcon;
    double opacity = 1.0;

    if (isAnswered) {
      if (isSelected) {
        if (isCorrect) {
          backgroundColor = const Color(0xFFE8F5E9);
          borderColor = const Color(0xFF2E7D32);
          borderWidth = 2.0;
          letterBgColor = const Color(0xFF2E7D32);
          letterTextColor = Colors.white;
          textColor = const Color(0xFF1B5E20);
          trailingIcon = const Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF2E7D32),
            size: 24,
          );
        } else {
          backgroundColor = const Color(0xFFFFEBEE);
          borderColor = const Color(0xFFC62828);
          borderWidth = 2.0;
          letterBgColor = const Color(0xFFC62828);
          letterTextColor = Colors.white;
          textColor = const Color(0xFFB71C1C);
          trailingIcon = const Icon(
            Icons.cancel_rounded,
            color: Color(0xFFC62828),
            size: 24,
          );
        }
      } else if (isCorrect) {
        // Highlight correct option if the user chose incorrectly
        backgroundColor = const Color(0xFFE8F5E9);
        borderColor = const Color(0xFF2E7D32);
        borderWidth = 2.0;
        letterBgColor = const Color(0xFF2E7D32);
        letterTextColor = Colors.white;
        textColor = const Color(0xFF1B5E20);
        trailingIcon = const Icon(
          Icons.check_circle_outline_rounded,
          color: Color(0xFF2E7D32),
          size: 24,
        );
      } else {
        // Dim unselected wrong options
        opacity = 0.55;
        backgroundColor = const Color(0xFFF8FAFC);
        borderColor = const Color(0xFFE2E8F0);
        textColor = const Color(0xFF64748B);
      }
    }

    final letter = optionIndex >= 0 && optionIndex < optionLetters.length
        ? optionLetters[optionIndex]
        : '${optionIndex + 1}';

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: opacity,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isAnswered ? null : onTap,
            borderRadius: BorderRadius.circular(16),
            splashColor: const Color(0xFF1E88E5).withValues(alpha: 0.12),
            highlightColor: const Color(0xFF1E88E5).withValues(alpha: 0.06),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor, width: borderWidth),
                boxShadow: isAnswered && isSelected
                    ? [
                        BoxShadow(
                          color: (isCorrect
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFC62828))
                              .withValues(alpha: 0.18),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: letterBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      letter,
                      style: TextStyle(
                        color: letterTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      optionText,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: textColor,
                        height: 1.35,
                      ),
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: 8),
                    trailingIcon,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

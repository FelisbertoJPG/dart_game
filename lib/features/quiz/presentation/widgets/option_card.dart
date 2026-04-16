import 'package:flutter/material.dart';
import 'package:dash_lingo/core/theme.dart';

class OptionCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final bool isChecked;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.text,
    required this.isSelected,
    this.isCorrect = false,
    this.isWrong = false,
    this.isChecked = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.border;
    Color bgColor = Colors.white;
    Color textColor = AppColors.textBody;

    if (isSelected && !isChecked) {
      borderColor = AppColors.primary;
      bgColor = AppColors.primary.withOpacity(0.1);
      textColor = AppColors.primary;
    } else if (isChecked) {
      if (isCorrect) {
        borderColor = AppColors.secondary;
        bgColor = AppColors.secondary.withOpacity(0.1);
        textColor = AppColors.secondary;
      } else if (isWrong) {
        borderColor = AppColors.accent;
        bgColor = AppColors.accent.withOpacity(0.1);
        textColor = AppColors.accent;
      }
    }

    return GestureDetector(
      onTap: isChecked ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            if (isSelected && !isChecked)
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                offset: const Offset(0, 4),
              ),
            if (!isSelected && !isChecked)
              const BoxShadow(
                color: AppColors.border,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:dash_lingo/core/theme.dart';

class ModuleNode extends StatelessWidget {
  final String title;
  final bool isLocked;
  final bool isCompleted;
  final VoidCallback onTap;
  final int index;

  const ModuleNode({
    super.key,
    required this.title,
    required this.isLocked,
    required this.isCompleted,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Zigzag alignment logic
    final double horizontalOffset = (index % 2 == 0) ? -40 : 40;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Transform.translate(
        offset: Offset(horizontalOffset, 0),
        child: Column(
          children: [
            GestureDetector(
              onTap: isLocked ? null : onTap,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: isLocked ? Colors.grey[300] : (isCompleted ? AppColors.secondary : AppColors.primary),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: isLocked 
                        ? Colors.grey[400]! 
                        : (isCompleted ? const Color(0xFF58A700) : const Color(0xFF1899D6)),
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    isLocked ? Icons.lock : (isCompleted ? Icons.check : Icons.star),
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isLocked ? Colors.grey : AppColors.textTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dash_lingo/core/theme.dart';
import 'package:dash_lingo/features/modules/domain/models.dart';
import 'package:dash_lingo/features/profile/domain/progress_provider.dart';
import 'package:dash_lingo/features/quiz/domain/quiz_provider.dart';
import 'widgets/option_card.dart';

class QuizScreen extends ConsumerWidget {
  final Module module;

  const QuizScreen({super.key, required this.module});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = module.quizzes;
    final quizState = ref.watch(quizProvider(quizzes));
    final quizNotifier = ref.read(quizProvider(quizzes).notifier);
    
    final currentQuiz = quizState.sessionQuizzes[quizState.currentQuestionIndex];
    final progress = (quizState.currentQuestionIndex + 1) / quizState.sessionQuizzes.length;

    // Handle completion
    if (quizState.isComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(userStateProvider.notifier).completeModule(module.id);
        Navigator.pop(context);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.progressBackground,
          color: AppColors.secondary,
          minHeight: 12,
          borderRadius: BorderRadius.circular(10),
        ),
        actions: [
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.red),
              const SizedBox(width: 4),
              Text(
                ref.watch(userStateProvider).hearts.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  currentQuiz.question,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                  ),
                ),
                if (currentQuiz.codeSnippet != null) ...[
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2B2B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      currentQuiz.codeSnippet!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.greenAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.builder(
                    itemCount: currentQuiz.options.length,
                    itemBuilder: (context, index) {
                      final option = currentQuiz.options[index];
                      return OptionCard(
                        text: option,
                        isSelected: quizState.selectedAnswer == option,
                        isChecked: quizState.isAnswerChecked,
                        isCorrect: option == currentQuiz.correctAnswer,
                        isWrong: option == quizState.selectedAnswer && option != currentQuiz.correctAnswer,
                        onTap: () => quizNotifier.selectAnswer(option),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100), // Space for bottom button
              ],
            ),
          ),
          
          // Bottom Controller / Feedback
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _QuizFooter(
              isAnswerSelected: quizState.selectedAnswer != null,
              isAnswerChecked: quizState.isAnswerChecked,
              isCorrect: quizState.isCorrect,
              explanation: currentQuiz.explanation,
              onCheck: () {
                final correct = quizNotifier.checkAnswer();
                if (!correct) {
                  ref.read(userStateProvider.notifier).loseHeart();
                }
              },
              onContinue: () => quizNotifier.nextQuestion(),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizFooter extends StatelessWidget {
  final bool isAnswerSelected;
  final bool isAnswerChecked;
  final bool isCorrect;
  final String? explanation;
  final VoidCallback onCheck;
  final VoidCallback onContinue;

  const _QuizFooter({
    required this.isAnswerSelected,
    required this.isAnswerChecked,
    required this.isCorrect,
    this.explanation,
    required this.onCheck,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    Color footerColor = Colors.white;
    if (isAnswerChecked) {
      footerColor = isCorrect ? const Color(0xFFD7FFB8) : const Color(0xFFFFDFE0);
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: footerColor,
        border: const Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isAnswerChecked) ...[
              Row(
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.error,
                    color: isCorrect ? AppColors.secondary : AppColors.accent,
                    size: 40,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isCorrect ? 'Excelente!' : 'Ops, quase lá!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isCorrect ? const Color(0xFF58A700) : AppColors.accent,
                    ),
                  ),
                ],
              ),
              if (!isCorrect && explanation != null) ...[
                const SizedBox(height: 12),
                Text(
                  explanation!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: isAnswerSelected ? (isAnswerChecked ? onContinue : onCheck) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isAnswerChecked 
                  ? (isCorrect ? AppColors.secondary : AppColors.accent) 
                  : AppColors.primary,
                disabledBackgroundColor: AppColors.border,
              ),
              child: Text(isAnswerChecked ? 'CONTINUAR' : 'VERIFICAR'),
            ),
          ],
        ),
      ),
    );
  }
}

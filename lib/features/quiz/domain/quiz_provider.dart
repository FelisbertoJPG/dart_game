import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modules/domain/models.dart';

class QuizState {
  final List<Quiz> sessionQuizzes;
  final int currentQuestionIndex;
  final String? selectedAnswer;
  final bool isAnswerChecked;
  final bool isCorrect;
  final bool isComplete;

  QuizState({
    required this.sessionQuizzes,
    this.currentQuestionIndex = 0,
    this.selectedAnswer,
    this.isAnswerChecked = false,
    this.isCorrect = false,
    this.isComplete = false,
  });

  QuizState copyWith({
    List<Quiz>? sessionQuizzes,
    int? currentQuestionIndex,
    String? selectedAnswer,
    bool? isAnswerChecked,
    bool? isCorrect,
    bool? isComplete,
  }) {
    return QuizState(
      sessionQuizzes: sessionQuizzes ?? this.sessionQuizzes,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      isAnswerChecked: isAnswerChecked ?? this.isAnswerChecked,
      isCorrect: isCorrect ?? this.isCorrect,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier(List<Quiz> initialQuizzes) 
    : super(QuizState(sessionQuizzes: [...initialQuizzes]));

  void selectAnswer(String answer) {
    if (!state.isAnswerChecked) {
      state = state.copyWith(selectedAnswer: answer);
    }
  }

  bool checkAnswer() {
    final currentQuiz = state.sessionQuizzes[state.currentQuestionIndex];
    final isCorrect = state.selectedAnswer == currentQuiz.correctAnswer;
    
    List<Quiz> updatedSession = [...state.sessionQuizzes];
    if (!isCorrect) {
      // Repeat this question at the end
      updatedSession.add(currentQuiz);
    }

    state = state.copyWith(
      isAnswerChecked: true,
      isCorrect: isCorrect,
      sessionQuizzes: updatedSession,
    );
    
    return isCorrect;
  }

  void nextQuestion() {
    if (state.currentQuestionIndex < state.sessionQuizzes.length - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        selectedAnswer: null,
        isAnswerChecked: false,
        isCorrect: false,
      );
    } else {
      state = state.copyWith(isComplete: true);
    }
  }
}

final quizProvider = StateNotifierProvider.family<QuizNotifier, QuizState, List<Quiz>>((ref, quizzes) {
  return QuizNotifier(quizzes);
});

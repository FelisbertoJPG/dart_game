enum QuizType {
  multipleChoice,
  fillInBlank,
  ordering,
  match,
}

class Quiz {
  final String id;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final QuizType type;
  final String? codeSnippet;
  final String? explanation;

  Quiz({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.type,
    this.codeSnippet,
    this.explanation,
  });
}

class Module {
  final String id;
  final String title;
  final String description;
  final int order;
  final List<Quiz> quizzes;

  Module({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.quizzes,
  });
}

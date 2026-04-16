import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../domain/models.dart';
import '../../quiz/presentation/quiz_screen.dart';

class LessonSlidesScreen extends StatefulWidget {
  final Module module;
  final bool isReviewMode;

  const LessonSlidesScreen({
    super.key,
    required this.module,
    this.isReviewMode = false,
  });

  @override
  State<LessonSlidesScreen> createState() => _LessonSlidesScreenState();
}

class _LessonSlidesScreenState extends State<LessonSlidesScreen> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    // Total pages = lessons + 1 final slide (if not review mode)
    final totalPages = widget.module.lessons.length + (widget.isReviewMode ? 0 : 1);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            scrollDirection: Axis.vertical,
            itemCount: totalPages,
            itemBuilder: (context, index) {
              if (index < widget.module.lessons.length) {
                return _LessonSlide(
                  lesson: widget.module.lessons[index],
                  index: index,
                  isReviewMode: widget.isReviewMode,
                  allQuizzes: widget.module.quizzes,
                );
              } else {
                return _FinalSlide(
                  onStart: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(module: widget.module),
                      ),
                    );
                  },
                );
              }
            },
          ),
          
          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          
          // Indicator
          Positioned(
            right: 20,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalPages, (index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    double selected = 0;
                    if (_controller.hasClients) {
                      selected = (_controller.page ?? 0);
                    }
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      width: 4,
                      height: (index == selected.round()) ? 24 : 8,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity((index == selected.round()) ? 1 : 0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonSlide extends StatelessWidget {
  final Lesson lesson;
  final int index;
  final bool isReviewMode;
  final List<Quiz> allQuizzes;

  const _LessonSlide({
    required this.lesson,
    required this.index,
    required this.isReviewMode,
    required this.allQuizzes,
  });

  @override
  Widget build(BuildContext context) {
    // Elegant background gradients for each slide
    final List<Gradient> gradients = [
      const LinearGradient(colors: [Color(0xFF1CB0F6), Color(0xFF1899D6)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      const LinearGradient(colors: [Color(0xFF78C800), Color(0xFF58A700)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      const LinearGradient(colors: [Color(0xFFFF4B4B), Color(0xFFD33131)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      const LinearGradient(colors: [Color(0xFFCE82FF), Color(0xFF8B36FF)], begin: Alignment.topLeft, end: Alignment.bottomRight),
    ];

    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: gradients[index % gradients.length],
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  lesson.content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                if (lesson.codeExample != null) ...[
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CÓDIGO',
                          style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          lesson.codeExample!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                
                if (isReviewMode && lesson.relatedQuizIds.isNotEmpty) ...[
                  const SizedBox(height: 30),
                  const Text(
                    'DESAFIOS SUPERADOS:',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  ...allQuizzes.where((q) => lesson.relatedQuizIds.contains(q.id)).map((q) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '✓ ${q.question}',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  )),
                ],
                const SizedBox(height: 100), // Extra space to scroll past the indicator
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FinalSlide extends StatelessWidget {
  final VoidCallback onStart;

  const _FinalSlide({required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.rocket_launch, color: AppColors.primary, size: 100),
          const SizedBox(height: 40),
          const Text(
            'Pronto para o desafio?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textTitle,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Você aprendeu o básico. Agora é hora de testar seus conhecimentos em Dart!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: AppColors.textBody),
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: onStart,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 70),
              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            child: const Text('COMEÇAR ATIVIDADE'),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {}, // Swipe back handled by PageView
            child: const Text('Revisar lições', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

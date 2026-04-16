import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme.dart';
import '../../profile/domain/progress_provider.dart';
import '../domain/curriculum_data.dart';
import 'lesson_slides_screen.dart';

class KnowledgeBookScreen extends ConsumerWidget {
  const KnowledgeBookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateProvider);
    final completedModules = curriculum.where((m) => userState.completedModules.contains(m.id)).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Biblioteca de Estudos', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: completedModules.isEmpty
          ? _EmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: completedModules.length,
              itemBuilder: (context, index) {
                final module = completedModules[index];
                return _BookItem(
                  title: module.title,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonSlidesScreen(
                          module: module,
                          isReviewMode: true,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class _BookItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _BookItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), offset: Offset(0, 4), blurRadius: 10),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const Icon(Icons.book, color: AppColors.primary, size: 40),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: const Text('Revisar lições e desafios'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories_outlined, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 20),
            const Text(
              'Sua biblioteca está vazia!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Text(
              'Complete seu primeiro módulo para liberar as lições aqui.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

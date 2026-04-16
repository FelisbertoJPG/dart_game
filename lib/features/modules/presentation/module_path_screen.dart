import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dash_lingo/core/theme.dart';
import 'package:dash_lingo/features/profile/domain/progress_provider.dart';
import 'package:dash_lingo/features/modules/presentation/lesson_slides_screen.dart';
import 'package:dash_lingo/features/modules/presentation/knowledge_book_screen.dart';
import 'package:dash_lingo/features/modules/domain/curriculum_data.dart';
import 'widgets/module_node.dart';

class ModulePathScreen extends ConsumerWidget {
  const ModulePathScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _StatItem(
              icon: Icons.favorite,
              value: userState.hearts.toString(),
              color: Colors.red,
            ),
            _StatItem(
              icon: Icons.bolt,
              value: userState.xp.toString(),
              color: Colors.orange,
            ),
            IconButton(
              icon: Icon(
                Icons.menu_book, 
                color: userState.completedModules.isNotEmpty ? AppColors.primary : Colors.grey[300],
              ),
              onPressed: userState.completedModules.isNotEmpty 
                ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => const KnowledgeBookScreen()))
                : null,
            ),
            const Icon(Icons.person_outline, color: Colors.grey),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 40),
        itemCount: curriculum.length,
        itemBuilder: (context, index) {
          final module = curriculum[index];
          
          // A module is locked if it's not the first one AND the previous one isn't completed
          bool isLocked = false;
          if (index > 0) {
            final prevModuleId = curriculum[index - 1].id;
            isLocked = !userState.completedModules.contains(prevModuleId);
          }
          
          final isCompleted = userState.completedModules.contains(module.id);

          return ModuleNode(
            index: index,
            title: module.title,
            isLocked: isLocked,
            isCompleted: isCompleted,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonSlidesScreen(module: module),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

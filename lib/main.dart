import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';
import 'features/modules/presentation/module_path_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: DashLingoApp(),
    ),
  );
}

class DashLingoApp extends StatelessWidget {
  const DashLingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DashLingo',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const ModulePathScreen(),
    );
  }
}

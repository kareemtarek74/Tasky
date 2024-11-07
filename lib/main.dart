import 'package:flutter/material.dart';
import 'package:tasky/Features/intro/presentation/views/intro_view.dart';
import 'package:tasky/core/helper_functions/onGenerate_function.dart';

void main() {
  runApp(const TaskyApp());
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: IntroView.routeName,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tasky/Features/intro/presentation/views/intro_view.dart';
import 'package:tasky/core/helper_functions/onGenerate_function.dart';
import 'package:tasky/core/services/shared_preferences_singleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(const TaskyApp());
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'DM Sans'),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: IntroView.routeName,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = 'Home';
  @override
  Widget build(BuildContext context) {
    return const HomeViewBody();
  }
}

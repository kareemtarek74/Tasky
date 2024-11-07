import 'package:flutter/material.dart';

import 'widgets/intro_view_body.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});
  static const routeName = "IntroView";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: IntroViewBody(),
    );
  }
}

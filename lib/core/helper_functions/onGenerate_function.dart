import 'package:flutter/material.dart';
import 'package:tasky/Features/intro/presentation/views/intro_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case IntroView.routeName:
      return MaterialPageRoute(builder: (context) => const IntroView());
    default:
      return MaterialPageRoute(builder: (context) => const IntroView());
  }
}

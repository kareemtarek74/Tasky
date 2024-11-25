import 'package:flutter/material.dart';
import 'package:tasky/Features/Auth/presentation/views/profile_info_view.dart';
import 'package:tasky/Features/Auth/presentation/views/sign_in_view.dart';
import 'package:tasky/Features/Auth/presentation/views/sign_up_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/add_task_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/home_view.dart';
import 'package:tasky/Features/intro/presentation/views/intro_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case IntroView.routeName:
      return MaterialPageRoute(builder: (context) => const IntroView());
    case SignInView.routeName:
      return MaterialPageRoute(builder: (context) => const SignInView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case ProfileInfoView.routeName:
      return MaterialPageRoute(builder: (context) => const ProfileInfoView());
    case AddTaskView.routeName:
      return MaterialPageRoute(builder: (context) => const AddTaskView());
    default:
      return MaterialPageRoute(builder: (context) => const IntroView());
  }
}

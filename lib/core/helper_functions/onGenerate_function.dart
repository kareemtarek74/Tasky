import 'package:flutter/material.dart';
import 'package:tasky/Features/Auth/presentation/views/profile_info_view.dart';
import 'package:tasky/Features/Auth/presentation/views/sign_in_view.dart';
import 'package:tasky/Features/Auth/presentation/views/sign_up_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/add_task_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/home_view.dart';
import 'package:tasky/Features/intro/presentation/views/intro_view.dart';

import '../../Features/Tasks/presentation/view/edit_task_view.dart';
import '../../Features/Tasks/presentation/view/qr_scanner_view.dart';
import '../../Features/Tasks/presentation/view/widgets/task_details_view.dart';

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
    case TaskDetailsView.routeName:
      return MaterialPageRoute(
          builder: (context) => TaskDetailsView(
                id: settings.arguments.toString(),
              ));

    case QRScannerPage.routeName:
      return MaterialPageRoute(builder: (context) => const QRScannerPage());
    case EditTaskView.routeName:
      return MaterialPageRoute(
          builder: (context) => EditTaskView(
                id: settings.arguments.toString(),
              ));
    default:
      return MaterialPageRoute(builder: (context) => const IntroView());
  }
}

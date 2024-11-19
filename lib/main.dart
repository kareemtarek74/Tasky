import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Auth/Domain/repos/login_repo.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/Features/Auth/presentation/views/sign_in_view.dart';
import 'package:tasky/Features/intro/presentation/views/intro_view.dart';
import 'package:tasky/constants.dart';
import 'package:tasky/core/helper_functions/onGenerate_function.dart';
import 'package:tasky/core/services/get_it_service.dart';
import 'package:tasky/core/services/shared_preferences_singleton.dart';
import 'package:tasky/core/utils/app_colors.dart';

import 'Features/Auth/Domain/repos/register_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  setup();
  runApp(const TaskyApp());
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubitCubit(
              registerRepo: getIt<RegisterRepo>(),
              loginRepo: getIt<LoginRepo>()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'DM Sans',
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        initialRoute: Prefs.getBool(kIsIntroViewSeen)
            ? SignInView.routeName
            : IntroView.routeName,
      ),
    );
  }
}

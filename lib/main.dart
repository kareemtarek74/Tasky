import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/core/helper_functions/onGenerate_function.dart';
import 'package:tasky/core/services/cubit_provider.dart';
import 'package:tasky/core/services/get_it_service.dart';
import 'package:tasky/core/services/initial_route_service.dart';
import 'package:tasky/core/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initialRoute = await determineInitialRoute();
  runApp(TaskyApp(initialRoute: initialRoute));
}

class TaskyApp extends StatelessWidget {
  final String initialRoute;
  const TaskyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubitCubit>(),
      child: TaskCubitProvider(
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'DM Sans',
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: onGenerateRoute,
          initialRoute: initialRoute,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/core/services/get_it_service.dart';

class AuthCubitProvider extends StatelessWidget {
  final Widget child;

  const AuthCubitProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubitCubit>(),
      child: child,
    );
  }
}

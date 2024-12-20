import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/text_styles.dart';

import '../../Features/Auth/presentation/view_model/auth_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Logout',
      icon: const Icon(
        Icons.logout,
        size: 27,
        color: Color(0xff5F33E1),
      ),
      onPressed: () async {
        final bool? confirmLogout =
            await _showLogoutConfirmationDialog(context);
        if (confirmLogout == true) {
          BlocProvider.of<AuthCubitCubit>(context).logoutUser();
        }
      },
    );
  }

  Future<bool?> _showLogoutConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Logout',
            style: Styles.styleBold24(context),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: Styles.styleMedium16(context).copyWith(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xff5F33E1)),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff5F33E1),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

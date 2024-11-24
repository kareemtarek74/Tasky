import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_home_appbar.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_home_body.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 22, right: 16),
              child: CustomHomeAppBar(),
            ),
            CustomHomeBody(),
          ],
        ),
      ),
    );
  }
}

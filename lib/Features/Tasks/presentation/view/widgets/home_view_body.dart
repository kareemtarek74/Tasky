import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_floating_action_buttons.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_home_appbar.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_home_body.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 22, right: 16),
                        child: CustomHomeAppBar(),
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height,
                          child: const CustomHomeBody()),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
            const Positioned(
                bottom: 32, right: 0, child: CustomFloatingButtons())
          ],
        ),
      ),
    );
  }
}

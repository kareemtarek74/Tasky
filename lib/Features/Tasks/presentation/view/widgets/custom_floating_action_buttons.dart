import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/add_task_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/qr_scanner_view.dart';

class CustomFloatingButtons extends StatelessWidget {
  const CustomFloatingButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 31),
              child: SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, QRScannerPage.routeName);
                  },
                  backgroundColor: const Color(0xFFEAE5FF),
                  heroTag: 'qrCodeButton',
                  elevation: 1,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.qr_code_rounded,
                    color: Color(0xFF5F33E1), // Icon color
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: SizedBox(
                width: 64,
                height: 64,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AddTaskView.routeName);
                  },
                  backgroundColor: const Color(0xFF5F33E1),
                  heroTag: 'addTaskButton',
                  elevation: 10,
                  shape: const CircleBorder(),
                  child: const Icon(
                    size: 32,
                    Icons.add,
                    color: Colors.white, // Icon color
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

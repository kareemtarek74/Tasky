import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/task_details_view.dart';
import 'package:tasky/core/text_styles.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});
  static const String routeName = 'qr_scanner';

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String? lastScannedTaskId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(FontAwesomeIcons.chevronLeft)),
          centerTitle: true,
          title: Text(
            "Scan your task Code",
            style: Styles.styleBold24(context),
          )),
      body: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            if (barcode.rawValue != null) {
              final String code = barcode.rawValue!;
              if (code.startsWith("task/")) {
                final String taskId = code.split("/")[1];

                if (taskId != lastScannedTaskId) {
                  setState(() {
                    lastScannedTaskId = taskId;
                  });
                  Navigator.pushNamed(
                    context,
                    TaskDetailsView.routeName,
                    arguments: taskId,
                  );
                }
              }
            }
          }
        },
      ),
    );
  }
}

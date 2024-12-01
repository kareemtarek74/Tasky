import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasky/core/text_styles.dart';

class CustomPriorityContainer extends StatelessWidget {
  final String priority;
  const CustomPriorityContainer({
    super.key,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: priorFieldColors[priority],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13, bottom: 13, right: 10),
            child: Icon(
              FontAwesomeIcons.flag,
              color: priorColors[priority],
              size: 22,
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                apiToDisplay[priority].toString(),
                style: Styles.styleBold16(context)
                    .copyWith(color: priorColors[priority]),
              )),
          const Spacer(),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Icon(
              FontAwesomeIcons.caretDown,
              color: priorColors[priority],
              size: 24,
            ),
          ),
          const SizedBox(
            width: 13,
          )
        ],
      ),
    );
  }
}

final Map<String, Color> priorFieldColors = {
  "high": const Color(0xFFFFE4F2),
  "medium": const Color(0xFFF0ECFF),
  "low": const Color(0xFFE3F2FF),
};
final Map<String, Color> priorColors = {
  "low": const Color(0xFF0087FF),
  "medium": const Color(0xFF5F33E1),
  "high": const Color(0xFFFF7D53),
};

final Map<String, String> apiToDisplay = {
  "low": "Low Priority",
  "medium": "Medium Priority",
  "high": "High Priority",
};

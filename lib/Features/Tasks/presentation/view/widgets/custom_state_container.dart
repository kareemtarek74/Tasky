import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasky/core/text_styles.dart';

class CustomStateContainer extends StatelessWidget {
  final String state;
  const CustomStateContainer({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: statusFieldColors[state],
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
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                statusApiToDisplay[state].toString(),
                style: Styles.styleBold16(context)
                    .copyWith(color: statusColors[state]),
              )),
          const Spacer(),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Icon(
              FontAwesomeIcons.caretDown,
              color: statusColors[state],
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

final Map<String, Color> statusFieldColors = {
  "waiting": const Color(0xFFFFE4F2),
  "inProgress": const Color(0xFFF0ECFF),
  "finished": const Color(0xFFE3F2FF),
};
final Map<String, Color> statusColors = {
  "finished": const Color(0xFF0087FF),
  "inProgress": const Color(0xFF5F33E1),
  "waiting": const Color(0xFFFF7D53),
};

final Map<String, String> statusApiToDisplay = {
  "waiting": "Waiting",
  "inProgress": "In Progress",
  "finished": "Finished",
};

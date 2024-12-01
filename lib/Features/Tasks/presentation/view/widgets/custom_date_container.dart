import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasky/core/text_styles.dart';

class CustomDateContainer extends StatelessWidget {
  final String date;
  const CustomDateContainer({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xffF0ECFF),
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'End Date',
                  style: Styles.styleRegular9(context)
                      .copyWith(color: const Color(0xff6E6A7C)),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  date,
                  style: Styles.styleRegular14(context).copyWith(
                    color: const Color(0xff24252C),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(
            width: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Icon(
              FontAwesomeIcons.solidCalendarDays,
              color: Color(0xff5F33E1),
              size: 20,
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

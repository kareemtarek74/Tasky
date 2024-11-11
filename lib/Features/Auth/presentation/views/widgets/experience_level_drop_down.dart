import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasky/core/text_styles.dart';

class ExperienceLevelDropdown extends StatefulWidget {
  const ExperienceLevelDropdown({super.key});

  @override
  ExperienceLevelDropdownState createState() => ExperienceLevelDropdownState();
}

class ExperienceLevelDropdownState extends State<ExperienceLevelDropdown> {
  // List of experience levels
  final List<String> experienceLevels = [
    'Fresh',
    'Junior',
    'Mid Level',
    'Senior'
  ];

  String? selectedLevel;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: const Icon(
        FontAwesomeIcons.chevronDown,
        size: 16,
        color: Color(0xff7F7F7F),
      ),
      decoration: InputDecoration(
        labelText: 'Choose experience Level',
        labelStyle: Styles.styleMedium14(context)
            .copyWith(color: const Color(0xff2F2F2F)),
        contentPadding: const EdgeInsets.all(15),
        border: buildBorder(),
        focusedBorder: buildBorder(),
        enabledBorder: buildBorder(),
      ),
      value: selectedLevel,
      items: experienceLevels.map((String level) {
        return DropdownMenuItem<String>(
          value: level,
          child: Text(level),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedLevel = newValue;
        });
      },
      validator: (value) =>
          value == null ? 'Please choose an experience level' : null,
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1, color: Color(0xffBABABA)));
  }
}

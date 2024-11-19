import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_state.dart';
import 'package:tasky/core/text_styles.dart';

class ExperienceLevelDropdown extends StatelessWidget {
  ExperienceLevelDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current state of the cubit
    return BlocBuilder<AuthCubitCubit, AuthCubitState>(
      builder: (context, state) {
        String? selectedLevel;
        if (state is ExperienceLevelSelected) {
          selectedLevel = state.selectedLevel;
        }

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
            if (newValue != null) {
              // Call the cubit to update the state
              context.read<AuthCubitCubit>().selectExperienceLevel(newValue);
            }
          },
          validator: (value) =>
              value == null ? 'Please choose an experience level' : null,
        );
      },
    );
  }

  // List of experience levels
  final List<String> experienceLevels = [
    'fresh',
    'junior',
    'midLevel',
    'senior',
  ];

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1, color: Color(0xffBABABA)));
  }
}

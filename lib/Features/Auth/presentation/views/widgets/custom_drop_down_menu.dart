import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Tasks/presentation/view/edit_task_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/core/text_styles.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({super.key, this.iconSize = 24, required this.id});
  final double iconSize;
  final String id;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: TooltipShape(),
      color: Colors.white,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            onTap: () async {
              Navigator.pushNamed(context, EditTaskView.routeName,
                  arguments: id);
              await BlocProvider.of<TaskCubit>(context).getTaskDetails(iD: id);
            },
            value: 'edit',
            padding: EdgeInsets.zero,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 20.5, bottom: 12.5),
              child: Text(
                'Edit',
                style: Styles.styleMedium16(context).copyWith(
                  color: const Color(0xff00060D),
                  height: 0.09,
                ),
              ),
            ),
          ),
          const PopupMenuItem(
              height: 0,
              padding: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  thickness: .4,
                ),
              )),
          PopupMenuItem<String>(
            value: 'delete',
            padding: EdgeInsets.zero,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 12.5, bottom: 20.5),
              child: Text(
                'Delete',
                textAlign: TextAlign.center,
                style: Styles.styleMedium16(context).copyWith(
                  color: const Color(0xFFFF7D53),
                  height: 0.09,
                ),
              ),
            ),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert),
      iconSize: iconSize,
      elevation: 8,
      padding: EdgeInsets.zero,
      offset: const Offset(-11, 48),
    );
  }
}

class TooltipShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const double arrowWidth = 16;
    const double arrowHeight = 12;
    const double radius = 12;

    final Path path = Path();

    path.moveTo(rect.right - radius - arrowWidth / 2, rect.top);
    path.lineTo(rect.right - radius, rect.top - arrowHeight);
    path.lineTo(rect.right - radius + arrowWidth / 2, rect.top);

    path.lineTo(rect.right - radius, rect.top);
    path.arcToPoint(Offset(rect.right, rect.top + radius),
        radius: const Radius.circular(radius));

    path.lineTo(rect.right, rect.bottom - radius);
    path.arcToPoint(Offset(rect.right - radius, rect.bottom),
        radius: const Radius.circular(radius));

    path.lineTo(rect.left + radius, rect.bottom);
    path.arcToPoint(Offset(rect.left, rect.bottom - radius),
        radius: const Radius.circular(radius));

    path.lineTo(rect.left, rect.top + radius);
    path.arcToPoint(Offset(rect.left + radius, rect.top),
        radius: const Radius.circular(radius));

    path.lineTo(rect.right - radius - arrowWidth / 2, rect.top);

    path.close();
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}

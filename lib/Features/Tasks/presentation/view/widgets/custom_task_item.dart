import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/custom_drop_down_menu.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/task_details_view.dart';
import 'package:tasky/core/helper_functions/formatted_date.dart';
import 'package:tasky/core/text_styles.dart';

class CustomTaskItem extends StatelessWidget {
  final CreateTaskEntity task;
  const CustomTaskItem({super.key, required this.task});

  static final Map<String, String> statusApiToDisplay = {
    "waiting": "Waiting",
    "inProgress": "In Progress",
    "finished": "Finished",
  };
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<TaskCubit>(context)
            .getTaskDetails(iD: task.taskId.toString());
        Navigator.pushNamed(context, TaskDetailsView.routeName,
            arguments: task.taskId.toString());
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 22, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 20),
              child: SizedBox(
                width: 64,
                height: 64,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(63.37),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://todo.iraqsapp.com/images/${task.imge.toString()}",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            task.tiTle.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.styleBold16(context),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: ShapeDecoration(
                            color: statusFieldColors[task.statue],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Text(
                            statusApiToDisplay[task.statue.toString()]
                                .toString(),
                            style: Styles.styleMedium12(context)
                                .copyWith(color: statusColors[task.statue]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      task.decription.toString(),
                      style: Styles.styleRegular14(context).copyWith(
                        color: const Color(0x9924252C),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.flag,
                          color: priorColors[task.prior.toString()],
                          size: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          priorApiToDisplay[task.prior.toString()].toString(),
                          style: Styles.styleMedium12(context).copyWith(
                              color: priorColors[task.prior.toString()]),
                        ),
                        const Spacer(),
                        Text(
                          formatDate(task.createAt.toString().split(' ').first),
                          style: Styles.styleRegular12(context).copyWith(
                            color: const Color(0x9924252C),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            CustomDropdown(
              id: task.taskId.toString(),
            )
          ],
        ),
      ),
    );
  }
}

final Map<String, Color> priorColors = {
  "low": const Color(0xFF0087FF),
  "medium": const Color(0xFF5F33E1),
  "high": const Color(0xFFFF7D53),
};

final Map<String, String> priorApiToDisplay = {
  "low": "Low",
  "medium": "Medium",
  "high": "High",
};

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

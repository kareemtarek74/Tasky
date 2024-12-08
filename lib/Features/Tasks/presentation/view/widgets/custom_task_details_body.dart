import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_date_container.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_priority_container.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_state_container.dart';
import 'package:tasky/core/helper_functions/format_text.dart';
import 'package:tasky/core/text_styles.dart';

class CustomTaskDetailsBody extends StatelessWidget {
  const CustomTaskDetailsBody({super.key, required this.task});
  final CreateTaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.fill,
            imageUrl: "https://todo.iraqsapp.com/images/${task.imge}",
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(Icons.error, size: 40, color: Colors.red),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.tiTle.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.styleBold24(context)
                          .copyWith(color: const Color(0xff24252C)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      formatText(task.decription.toString(), 60),
                      style: Styles.styleRegular14(context).copyWith(
                        color: const Color(0x9924252C),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.5),
          child: Column(
            children: [
              CustomDateContainer(
                date: formatTaskDate(task.updateAt.toString().split(' ').first),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomStateContainer(state: task.statue.toString()),
              const SizedBox(
                height: 8,
              ),
              CustomPriorityContainer(priority: task.prior.toString()),
            ],
          ),
        )
      ],
    );
  }
}

String formatTaskDate(String apiDate) {
  DateTime parsedDate = DateTime.parse(apiDate);

  String formattedDate = DateFormat('d MMMM, yyyy').format(parsedDate);

  return formattedDate;
}

import 'package:flutter/material.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/custom_drop_down_menu.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
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
      onTap: () {},
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
                  child: Container(
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://todo.iraqsapp.com/images/${task.imge.toString()}"),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(63.37),
                      ),
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
                            color: const Color(0xFFFFE4F2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Text(
                            statusApiToDisplay[task.statue.toString()]
                                .toString(),
                            style: Styles.styleMedium12(context)
                                .copyWith(color: const Color(0xFFFF7D53)),
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
                        const Icon(
                          Icons.flag,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          task.prior.toString(),
                          style: Styles.styleMedium12(context),
                        ),
                        const Spacer(),
                        Text(
                          task.createAt.toString(),
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
            const CustomDropdown()
          ],
        ),
      ),
    );
  }
}

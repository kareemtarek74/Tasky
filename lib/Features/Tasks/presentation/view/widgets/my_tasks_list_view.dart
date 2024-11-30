import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/my_tasks_item.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/my_tasks_model.dart';

class MyTasksListView extends StatefulWidget {
  const MyTasksListView({super.key});

  @override
  State<MyTasksListView> createState() => _MyTasksListViewState();
}

final items = [
  MyTasksModel(title: 'All'),
  MyTasksModel(title: 'Inprogress'),
  MyTasksModel(title: 'Waiting'),
  MyTasksModel(title: 'Finished'),
];
int indexNum = 0;

class _MyTasksListViewState extends State<MyTasksListView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return Row(
              children: List.generate(items.length, (index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          indexNum = index;
                          final cubit = BlocProvider.of<TaskCubit>(context);
                          cubit.updateIndexSelected(index);
                          cubit.emit(GetTasksListSuccessState());
                        });
                      },
                      child: MyTasksItem(
                        isActive: indexNum == index,
                        model: items[index],
                      ),
                    ),
                    if (index != items.length - 1) const SizedBox(width: 8),
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

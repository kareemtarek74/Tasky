import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/my_tasks_item.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/my_tasks_model.dart';

class MyTasksListView extends StatefulWidget {
  const MyTasksListView({super.key});

  @override
  State<MyTasksListView> createState() => _MyTasksListViewState();
}

final items = [
  MyTasksModel(title: 'All'),
  MyTasksModel(title: 'Inpogress'),
  MyTasksModel(title: 'Waiting'),
  MyTasksModel(title: 'Finished')
];
int indexNum = 0;

class _MyTasksListViewState extends State<MyTasksListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  indexNum = 0;
                });
              },
              child: MyTasksItem(isActive: indexNum == 0, model: items[0])),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  indexNum = 1;
                });
              },
              child: MyTasksItem(isActive: indexNum == 1, model: items[1])),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  indexNum = 2;
                });
              },
              child: MyTasksItem(isActive: indexNum == 2, model: items[2])),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  indexNum = 3;
                });
              },
              child: MyTasksItem(isActive: indexNum == 3, model: items[3]))
        ],
      ),
    );
  }
}

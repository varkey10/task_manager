import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/core_ui.dart';
import 'package:task_manager/cubit/task/task_cubit.dart';
import 'package:task_manager/cubit/task/task_state_cubit.dart';
import 'package:task_manager/screen/Task/add_task.dart';
import 'package:task_manager/widgets/pagination/pagenation.dart';

class TaskListingScreen extends StatelessWidget {
  const TaskListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: InnerPageStyles().heading,
        ),
        actions: [
          Tooltip(
            message: "Add Task",
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const NewTaskSheet(),
                    );
                  }, // ← your custom widget
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Pagination(
          dropDownValue: 5,
          dropOnChanged: (p0) {},
          isLoadingNxtPage: false,
          isLoadingPrvPage: false,
          isShowTotalCount: true,
          isjumpPage: false,
          totalIteamCount: 10,
          onTapNxtBtn: () {},
          onTapPrvBtn: () {},
          currentPage: 0,
          isShowRowperpage: true,
          shouldShowDecoration: true),
      body: BlocListener<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Search Field
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search tasks',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Task List
              Expanded(
                child: ListView.builder(
                  itemCount: context.read<TaskCubit>().taskList.length,
                  itemBuilder: (context, index) {
                    final task = context.read<TaskCubit>().taskList;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(task[index]["title"].toString()),
                          subtitle:
                              Text("Completed: ${task[index]['completed']}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              context.read<TaskCubit>().deleteTask(index);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

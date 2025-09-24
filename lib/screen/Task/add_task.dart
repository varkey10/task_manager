import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/core/core_ui.dart';
import 'package:task_manager/cubit/task/task_cubit.dart';
import 'package:task_manager/cubit/task/task_state_cubit.dart';
import 'package:task_manager/widgets/common_drop.dart';

class NewTaskSheet extends StatefulWidget {
  const NewTaskSheet({Key? key}) : super(key: key);

  @override
  State<NewTaskSheet> createState() => _NewTaskSheetState();
}

class _NewTaskSheetState extends State<NewTaskSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _priority = 'Medium';
  final Set<String> _tags = {};

  void _toggleTag(String tag) {
    setState(() {
      if (_tags.contains(tag)) {
        _tags.remove(tag);
      } else {
        _tags.add(tag);
      }
    });
  }

  Widget _priorityButton(String text) {
    final bool selected = _priority == text;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: selected ? Colors.blue.shade100 : Colors.white,
        side: BorderSide(color: selected ? Colors.blue : Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => setState(() => _priority = text),
      child: Text(text,
          style: TextStyle(
            color: selected ? Colors.blue : Colors.black,
            fontWeight: FontWeight.w500,
          )),
    );
  }

  Widget _tagChip(String text) {
    final bool selected = _tags.contains(text);
    return FilterChip(
      label: Text(text),
      selected: selected,
      onSelected: (_) => _toggleTag(text),
      selectedColor: Colors.blue.shade100,
      checkmarkColor: Colors.blue,
      backgroundColor: Colors.grey.shade100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        final taskCubit = context.read<TaskCubit>();

        return Container(
          color: Colors.grey.shade200,
          child: Center(
            child: Container(
              width: 320,
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 6)
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('New Task', style: InnerPageStyles().heading),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Title
                    CommonDropforUsers(
                      onUserSelected: (p0) {
                        taskCubit.selectUser(p0);
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Task Title',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Due Date Label
                    Text(
                      'Due Date',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selected, focused) {
                        setState(() {
                          _selectedDay = selected;
                          _focusedDay = focused;
                        });
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Priority
                    const Text('Priority',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        CommonDropDown(
                          value: taskCubit.selectedTaskStatus,
                          items: taskCubit.taskStatus,
                          onChanged: (value) {
                            if (value != null) {
                              context
                                  .read<TaskCubit>()
                                  .dropDownChanges(value, "status");
                            }
                          },
                        ),
                        CommonDropDown(
                          value: taskCubit.selectedTaskPriority,
                          items: taskCubit.taskPriority,
                          onChanged: (value) {
                            if (value != null) {
                              context
                                  .read<TaskCubit>()
                                  .dropDownChanges(value, "priority");
                            }
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    // Description
                    TextField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Description/Notes',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Category Tags
                    const Text('Category/Tags',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _tagChip('Work'),
                        _tagChip('Personal'),
                        _tagChip('Errands'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () async {
                            await taskCubit.addTask(_titleController.text,
                                _descriptionController.text);
                            // Navigator.pop(context);
                          },
                          child: const Text('Save Task'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

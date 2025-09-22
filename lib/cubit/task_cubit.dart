import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/models/task_model.dart';

class TaskCubit extends Cubit<List<Task>> {
  TaskCubit()
      : super([
          Task(
            title: "Grocery Shopping",
            dueDate: "Today",
          ),
          Task(
            title: "Project Presentation",
            dueDate: "Tomorrow",
          ),
          Task(
              title: "Book Appointment",
              dueDate: "Yesterday",
              isCompleted: true),
        ]);
  int? selectedUSerID;

  void addTask(Task task) {
    emit([...state, task]);
  }

  void toggleTask(int index) {
    final updatedTask =
        state[index].copyWith(isCompleted: !state[index].isCompleted);
    final newList = [...state];
    newList[index] = updatedTask;
    emit(newList);
  }

  void removeTask(int index) {
    final newList = [...state]..removeAt(index);
    emit(newList);
  }

  void selectUser(Map<String, dynamic> value) {
    selectedUSerID = value['id'];
    print(selectedUSerID);
  }

  
}

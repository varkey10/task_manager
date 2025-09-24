import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/api/api_calls';
import 'package:task_manager/cubit/task/task_state_cubit.dart';
import 'package:task_manager/api/models/task_model.dart';

class TaskCubit extends Cubit<TaskState> {
  final NetworkRepository _network = NetworkRepository();

  TaskCubit() : super(TaskInitial()) {
    // loadInitialTasks();
  }

  // final List<Task> _tasks = [
  //   Task(title: "Grocery Shopping", dueDate: "Today"),
  //   Task(title: "Project Presentation", dueDate: "Tomorrow"),
  //   Task(
  //     title: "Book Appointment",
  //     dueDate: "Yesterday",
  //     isCompleted: true,
  //   ),
  // ];
  final List<Task> tasks = [];

  List<String> taskStatus = ["To-do", "In-progress", "Done"];
  List<String> taskPriority = ["High", "Medium", "Low"];

  String selectedTaskStatus = "To-do";

  String selectedTaskPriority = "High";

  List<Map<String, dynamic>> taskList = [];

  int? selectedUSerID;

  dropDownChanges(val, String isfor) {
    if (isfor == "status") {
      selectedTaskStatus = val;
    } else {
      selectedTaskPriority = val;
    }
    emit(TaskFilterUpdated(
        status: selectedTaskStatus, priority: selectedTaskPriority));
  }

  void selectUser(Map<String, dynamic> value) {
    selectedUSerID = value['id'];
  }

  Future<void> addTask(String taskTitle, String taskDescription) async {
    emit(TaskLoading());
    try {
      var param = {
        "user": selectedUSerID,
        "title": taskTitle,
        "description": taskDescription,
      };
      final response = await _network.addTask(param);
      if (response != null) {
        emit(TaskLoaded(tasks));
      } else {
        emit(TaskError("Failed to add task"));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> loadTasks() async {
    emit(TaskLoading());
    try {
      final response = await _network.taskList();
      if (response != null) {
        taskList.clear();
        taskList = List<Map<String, dynamic>>.from(response["data"]);
        print(taskList);
        emit(TaskLoaded(tasks));
      } else {
        emit(TaskError("Failed to load tasks"));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> deleteTask(int taskId) async {
    emit(TaskLoading());
    try {
      final response = await _network.deleteTask(taskId);
      if (response != null) {
        await loadTasks();
        emit(TaskDeleted());
      } else {
        emit(TaskError("Failed to delete task"));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}

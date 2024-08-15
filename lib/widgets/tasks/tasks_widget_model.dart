import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/entity/group.dart';
import 'package:todo_app/domain/entity/task.dart';

class TasksWidgetModel extends ChangeNotifier {
  int groupKey;
  late final Future<Box<Group>> _groupBox;

  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  Group? _group;
  Group? get group => _group;

  TasksWidgetModel({required this.groupKey}) {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/groups/tasks/form', arguments: groupKey);
  }

  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }
  void _readTasks() {
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }
  void _setupListen()async {
    final box = await _groupBox;
    _readTasks();
    box.listenable(keys: <dynamic> [groupKey]).addListener(_readTasks);
    
  }

  void deleteTask(int groupIndex) {
    _group?.tasks?.deleteFromHive(groupIndex);
    
  }

  void _setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('group_box');
    _loadGroup();
    _setupListen();
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;
  const TasksWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static TasksWidgetModel of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
    return provider!.model;
  }

  static TasksWidgetModel watch(BuildContext context) {
    final provider = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()!
        .widget as TasksWidgetModelProvider;
    return provider.model;
  }
}

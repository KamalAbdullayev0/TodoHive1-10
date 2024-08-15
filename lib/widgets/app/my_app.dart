import 'package:flutter/material.dart';
import 'package:todo_app/widgets/group_from/group_form_widget.dart';
import 'package:todo_app/widgets/groups/groups_widget.dart';
import 'package:todo_app/widgets/task_from/task_form_widget.dart';
import 'package:todo_app/widgets/tasks/tasks_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      routes: {
        '/groups': (context) => const GroupsWidget(),
        '/groups/form': (context) => const GroupFormWidget(),
        '/groups/tasks': (context) => const TaskWidget(),
        '/groups/tasks/form': (context) => const TaskFormWidget(),

      },
      initialRoute: '/groups',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
    );
  }
}

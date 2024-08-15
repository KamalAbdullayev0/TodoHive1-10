import 'package:flutter/material.dart';
// import 'package:todo_app/domain/entity/task.dart';
import 'package:todo_app/widgets/task_from/task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TaskFormWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskFormWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(
      model: _model!,
      child: const _TextFormWidgetBody(),
    );
  }
}

class _TextFormWidgetBody extends StatelessWidget {
  const _TextFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 110, 135, 155),
        centerTitle: true,
        title: const Text('Yeni taspsiri əlavə et',
            style: TextStyle(
                color: Color.fromARGB(255, 7, 6, 6),
                fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Container(
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: TaskTextWidget(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TaskFormWidgetModelProvider.read(context)?.model.saveTask(context);
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}

class TaskTextWidget extends StatelessWidget {
  const TaskTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.read(context)!.model;
    return TextField(
      autofocus: true,
      maxLines: null,
      minLines: null,
      expands: true,
      decoration: InputDecoration(
        labelText: 'Məqsədin adı',
        border: InputBorder.none,
        hintText: 'mesele yazisi',
      ),
      onChanged: (value) => model.taskText = value,
      onEditingComplete: () => model.saveTask(context),
    );
  }
}

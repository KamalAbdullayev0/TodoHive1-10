import 'package:flutter/material.dart';
import 'package:todo_app/widgets/group_from/group_form_widget_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({super.key});

  @override
  State<GroupFormWidget> createState() => _GroupFormWidgetState();
}

class _GroupFormWidgetState extends State<GroupFormWidget> {
  final _model = GroupFormWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvider(
      model: _model,
      child: _GroupFormWidgetBody(),
    );
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 110, 135, 155),
        centerTitle: true,
        title: const Text('Yeni Məqsədlərim',
            style: TextStyle(
                color: Color.fromARGB(255, 7, 6, 6),
                fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Container(
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: _GroupNameWidget(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GroupFormWidgetModelProvider.read(context)?.model.saveGroup(context);
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.read(context)!.model;
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Məqsədin adı',
        border: OutlineInputBorder(),
        hintText: 'Məqsədi yaz kral',
      ),
      onChanged: (value) => model.groupName = value,
      onEditingComplete: () => model.saveGroup(context),
    );
  }
}

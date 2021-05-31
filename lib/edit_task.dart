import 'package:flutter/material.dart';

import 'add_list.dart';

import 'db/tasks_db.dart';
import 'models/task_model.dart';

class EditTask extends StatefulWidget {
  final TaskModel? task;

  const EditTask({
    Key? key,
    this.task,
    //this.task,
  }) : super(key: key);
  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    isImportant = widget.task?.isImportant ?? false;
    number = widget.task?.number ?? 0;
    title = widget.task?.title ?? '';
    description = widget.task?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xff072736),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: AddFormWidget(
            isImportant: isImportant,
            number: number,
            title: title,
            description: description,
            onChangedImportant: (isImportant) =>
                setState(() => this.isImportant = isImportant),
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.yellow.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.task != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.task!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await TasksDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = TaskModel(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await TasksDatabase.instance.create(note);
  }
}

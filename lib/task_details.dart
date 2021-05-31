import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'db/tasks_db.dart';
import 'edit_task.dart';
import 'models/task_model.dart';

class TaskDetailsPage extends StatefulWidget {
  final int taskId;
  TaskDetailsPage({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  bool isLoading = false;
  late TaskModel task;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    this.task = (await TasksDatabase.instance.readNote(widget.taskId))!;
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff072736),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [editButton(), deleteButton()],
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(12),
              child: ListView(
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                  SizedBox(height: 15),
                  Text(
                    DateFormat.yMMMd().format(task.createdTime),
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(height: 15),
                  Text(
                    task.description,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
    );
  }

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditTask(task: task),
        ));

        refreshNotes();
      });

  Widget deleteButton() => IconButton(
        onPressed: () async {
          await TasksDatabase.instance.delete(widget.taskId);
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.delete),
      );
}

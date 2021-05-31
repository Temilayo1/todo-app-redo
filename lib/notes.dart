import 'package:fam_church/edit_task.dart';
import 'package:fam_church/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'db/tasks_db.dart';
import 'task_card.dart';
import 'task_details.dart';

// ignore: use_key_in_widget_constructors
class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late List<TaskModel> tasks;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    TasksDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.tasks = await TasksDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff072736),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: Text(
          'My Doings',
        ),
        backgroundColor: Colors.transparent,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 30),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditTask()),
          );

          refreshNotes();
        },
      ),
      body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : tasks.isEmpty
                  ? Text(
                      'No Tasks',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : SizedBox(
                      height: size.height / 1.5,
                      child: StaggeredGridView.countBuilder(
                        padding: EdgeInsets.all(8),
                        itemCount: tasks.length,
                        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        itemBuilder: (context, index) {
                          final task = tasks[index];

                          return GestureDetector(
                            onTap: () async {
                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) =>
                                    TaskDetailsPage(taskId: task.id!),
                              ));

                              refreshNotes();
                            },
                            child: TaskCardWidget(task: task, index: index),
                          );
                        },
                      ),
                    )),
    );

    // ignore: dead_code
    // Widget buildNotes() => StaggeredGridView.countBuilder(
    //       padding: EdgeInsets.all(8),
    //       itemCount: tasks.length,
    //       staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    //       crossAxisCount: 4,
    //       mainAxisSpacing: 4,
    //       crossAxisSpacing: 4,
    //       itemBuilder: (context, index) {
    //         final task = tasks[index];

    //         return GestureDetector(
    //           onTap: () async {
    //             await Navigator.of(context).push(MaterialPageRoute(
    //               builder: (context) => TaskDetailsPage(taskId: task.id!),
    //             ));

    //             refreshNotes();
    //           },
    //           child: TaskCardWidget(task: task, index: index),
    //         );
    //       },
    //     );
  }
}

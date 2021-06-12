import 'package:fam_church/db/tasks_db.dart';
import 'package:fam_church/log%20ouT/modal.dart';
import 'package:fam_church/models/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'edit_task.dart';
import 'task_card.dart';
import 'task_details.dart';

class Tasks extends StatefulWidget {
  static String routeName = "/tasks";
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  String user = FirebaseAuth.instance.currentUser.email == null
      ? FirebaseAuth.instance.currentUser.phoneNumber
      : FirebaseAuth.instance.currentUser.email;

  late List<TaskModel> tasks;
  bool isLoading = false;
  bool darkTheme = false;

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
        title: Text(
          'My Doings',
          style: TextStyle(
            color: Colors.yellow,
          ),
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
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: ListView(
            children: [
              InkWell(
                onTap: () {},
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.grey),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/1.jpg'),
                    // child: Text("LA"),
                  ),
                  accountName: Text(
                    'Layon',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  accountEmail: Text('$user'),
                ),
              ),
              ListTile(
                title: Text(
                  "Light theme",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                trailing: Switch(
                  value: darkTheme,
                  onChanged: (changed) {
                    setState(() {
                      darkTheme = changed;
                    });
                  },
                ),
              ),
              Divider(
                color: Colors.yellow,
              ),
              // ignore: prefer_const_constructors
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ModalBot(),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  trailing: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.yellow,
        ),
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
                    style: TextStyle(color: Colors.yellow, fontSize: 24),
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
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    TaskDetailsPage(taskId: task.id!),
                              ),
                            );

                            refreshNotes();
                          },
                          child: TaskCardWidget(task: task, index: index),
                        );
                      },
                    ),
                  ),
      ),
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

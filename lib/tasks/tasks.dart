import 'package:fam_church/db/tasks_db.dart';
import 'package:fam_church/log%20ouT/modal.dart';
import 'package:fam_church/models/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'edit_task.dart';
import 'task_card.dart';
import 'task_details.dart';

// ignore: use_key_in_widget_constructors
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        // backgroundColor: Color(0xff072736),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'My Doings',
            style: darkTheme
                ? TextStyle(color: Colors.red)
                : TextStyle(color: Colors.yellow),
          ),
          backgroundColor: Colors.transparent,
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 30,
                color: darkTheme ? Color(0xff121421) : Colors.white,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
                color: darkTheme ? Colors.white : Color(0xff202124)),
            child: ListView(
              children: [
                InkWell(
                  onTap: () {},
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        color: darkTheme ? Colors.grey : Color(0xff12142)),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('assets/1.jpg'),
                      // child: Text("LA"),
                    ),
                    accountName: Text(
                      'Layon',
                      style: TextStyle(
                        color: darkTheme ? Colors.black : Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    accountEmail: Text(
                      '1313@gmail.com',
                      style: TextStyle(
                        color: darkTheme ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Light theme",
                    style: TextStyle(
                      color: darkTheme ? Colors.black : Colors.white,
                      fontSize: 17,
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
                        color: darkTheme ? Colors.black : Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    trailing: Icon(
                      Icons.logout,
                      color: darkTheme ? Colors.black : Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: darkTheme ? Colors.grey : Color(0xff121421),
          child: Icon(
            Icons.add,
            color: darkTheme ? Colors.red : Colors.yellow,
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
                      style: darkTheme
                          ? TextStyle(color: Colors.red, fontSize: 20)
                          : TextStyle(color: Colors.yellow),
                    )
                  : SizedBox(
                      height: size.height / 1.22,
                      child: AnimationLimiter(
                        child: StaggeredGridView.countBuilder(
                          padding: EdgeInsets.all(8),
                          itemCount: tasks.length,
                          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 3,
                              duration: Duration(seconds: 2),
                              child: FlipAnimation(
                                child: FadeInAnimation(
                                  child: GestureDetector(
                                      onTap: () async {
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TaskDetailsPage(
                                                    taskId: task.id!),
                                          ),
                                        );

                                        refreshNotes();
                                      },
                                      child: TaskCardWidget(
                                          task: task, index: index)),
                                ),
                              ),
                            );

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

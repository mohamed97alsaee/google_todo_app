import 'package:flutter/material.dart';
import 'package:google_todo_app/helpers/consts.dart';
import 'package:google_todo_app/providers/auth_provider.dart';
import 'package:google_todo_app/providers/tasks_provider.dart';
import 'package:google_todo_app/widgets/task_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<TasksProvider>(context, listen: false).getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<TasksProvider>(builder: (context, tasksConsumer, child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
          appBar: AppBar(title: Text("GDG Teamz"), actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Logout"),
                          content: Text("Are you sure you want to logout?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("No")),
                            TextButton(
                                onPressed: () {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .logOut()
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text("Yes")),
                          ],
                        ));
              },
              icon: Icon(Icons.logout),
            )
          ]),
          body: AnimatedSwitcher(
            duration: animationDuration,
            child: tasksConsumer.isLoading
                ? ListView.builder(itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.1),
                      highlightColor: Colors.grey.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: double.infinity,
                              height: size.height * 0.1,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                            ),
                            // Container(
                            //   width: double.infinity,
                            //   height: 8.0,
                            //   color: Colors.white,
                            // ),
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(vertical: 8.0),
                            // ),
                            // Container(
                            //   width: 40.0,
                            //   height: 8.0,
                            //   color: Colors.white,
                            // ),
                          ],
                        ),
                      ),
                    );
                  })
                : tasksConsumer.tasks.isEmpty
                    ? Center(
                        child: Text("you dont have any tasks!"),
                      )
                    : ListView.builder(
                        itemCount: tasksConsumer.tasks.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            task: tasksConsumer.tasks[index],
                          );
                        }),
          ));
    });
  }
}

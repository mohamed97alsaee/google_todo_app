import 'package:flutter/material.dart';
import 'package:google_todo_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              Provider.of<AuthProvider>(context, listen: false)
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
      body: Center(
        child: Text("HOME SCREEN"),
      ),
    );
  }
}

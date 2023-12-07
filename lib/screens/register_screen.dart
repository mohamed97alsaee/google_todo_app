import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_todo_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController teamCodeController = TextEditingController();

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: registerFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  Image.asset("assets/gdg.png",
                      width: size.width * 0.5, height: size.width * 0.5),
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  Text(
                    "Welcome, to GDG Teamz",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                      "Create Account to continue and use the GDG Teamz app and all its features."),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Enter your Name",
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your name";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Phone",
                      hintText: "Enter your phone",
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your phone number";
                      }
                      if (value.length < 10) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Please enter a valid password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    controller: teamCodeController,
                    decoration: InputDecoration(
                      labelText: "Team Code",
                      hintText: "Enter your team code",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your team code";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(size.width, size.height * 0.06),
                      ),
                      onPressed: () {
                        if (registerFormKey.currentState!.validate()) {
                          print("VALIDATED");
                          Provider.of<AuthProvider>(context, listen: false)
                              .register({
                            "name": nameController.text,
                            "team_code": teamCodeController.text,
                            "phone": phoneController.text,
                            "password": passwordController.text
                          }).then((loginData) {
                            if (loginData.first) {
                              SnackBar snackBar =
                                  SnackBar(content: Text(loginData.last));
                              if (mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Timer(Duration(seconds: 2), () {
                                  Navigator.pop(context);
                                });
                              }
                            } else {
                              SnackBar snackBar =
                                  SnackBar(content: Text(loginData.last));
                              if (mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          });
                        } else {
                          print("NOT VALIDATED");
                          SnackBar snackBar = SnackBar(
                              content: Text("Please enter valid data"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text("Craete")),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Text("Do you have account ?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Login"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

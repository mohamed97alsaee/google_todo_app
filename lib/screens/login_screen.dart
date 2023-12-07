import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_todo_app/providers/auth_provider.dart';
import 'package:google_todo_app/screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: loginFormKey,
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
                      "Login to continue and use the GDG Teamz app and all its features."),
                  SizedBox(
                    height: size.height * 0.05,
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
                    height: size.height * 0.09,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(size.width, size.height * 0.06),
                      ),
                      onPressed: () {
                        if (loginFormKey.currentState!.validate()) {
                          print("VALIDATED");

                          Provider.of<AuthProvider>(context, listen: false)
                              .login({
                            "phone": phoneController.text,
                            "password": passwordController.text
                          }).then((loginData) {
                            if (loginData.first) {
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
                      child: Text("Login")),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Text("Dont have account ?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                          child: Text("Create Account"))
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

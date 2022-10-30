import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../HomePage/homepage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();

  InputDecoration inputDecorate(String text) {
    return InputDecoration(
      hintText: "$text を入力してください",
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      labelStyle: TextStyle(
        fontSize: 12,
        color: Colors.grey[300],
      ),
      labelText: text,
      floatingLabelStyle: const TextStyle(fontSize: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
      ),
    );
  }

  Widget forPadding(String text, double down, TextEditingController control) {
    return Padding(
      padding: EdgeInsets.only(bottom: down),
      child: TextFormField(
        decoration: inputDecorate(text),
        controller: control,
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100]!,
      appBar: AppBar(
        backgroundColor: Colors.grey[100]!,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(50),
              child: Text("新規アカウントの登録"),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  forPadding("Email Address", 30, _emailController),
                  forPadding("Password", 30, _passwordController),
                  forPadding("name", 30, _nameController),
                  forPadding("id", 0, _idController),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    await FirebaseChatCore.instance.createUserInFirestore(
                      types.User(
                        firstName: _idController.text,
                        lastName: _nameController.text,
                        id: credential.user!.uid,
                      ),
                    );
                    if (!mounted) return;
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HomePage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: const Text("Could not Sign Up"),
                            actions: [
                              TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          );
                        });
                  }
                },
                child: const SizedBox(
                  height: 40,
                  width: 100,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

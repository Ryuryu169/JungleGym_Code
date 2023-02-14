import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:universal_platform/universal_platform.dart';

import '../HomePage/Homepage.dart';
import 'SignUp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(left: 70, top: 50, right: 70, bottom: 25),
                  child: Text("Jungle Gym"),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 50, right: 50, top: 30, bottom: 30),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Text("Jungle Gym にログインする"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: TextFormField(
                              decoration: inputDecorate("Email Address"),
                              controller: _emailController,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: TextFormField(
                              decoration: inputDecorate("Password"),
                              controller: _passwordController,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 20),
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                  if (!mounted) return;
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const HomePage(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(0.0, 1.0);
                                        const end = Offset.zero;
                                        const curve = Curves.ease;

                                        var tween = Tween(
                                                begin: begin, end: end)
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
                                }
                              },
                              child: const SizedBox(
                                height: 40,
                                width: 100,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey[400]!,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              top: 10,
                              right: 30,
                              //bottom: 20,
                            ),
                            child: TextButton(
                              child: const Text("Sign Up"),
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const SignUp(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
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
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              // Google認証
                              try {
                                final user = await signInWithGoogle();
                                await FirebaseChatCore.instance
                                    .createUserInFirestore(
                                  types.User(
                                    firstName: user.user!.displayName,
                                    lastName: user.user!.displayName,
                                    id: user.user!.uid
                                        .toString()
                                        .replaceAll(' ', ''),
                                  ),
                                );
                                if (!mounted) return;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const HomePage(),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (kDebugMode) {
                                  print('FirebaseAuthException');
                                  print(e.code);
                                }
                              } on Exception catch (e) {
                                if (kDebugMode) {
                                  print('Other Exception');
                                  print(e.toString());
                                }
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                width: 270,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Image(
                                            image: AssetImage(
                                              "assets/images/google_logo.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Text(
                                            "Sign In with Google",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              //letterSpacing: 1,
                                              fontSize: chooseOS(),
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double? chooseOS() {
    if (UniversalPlatform.isAndroid) {
      return 11.0;
    } else if (UniversalPlatform.isWeb) {
      return 20.0;
    } else if(UniversalPlatform.isIOS){
      return 10.5;
    }else{
      return 20.0;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn(
            scopes: [
          'email',
        ],
            clientId:
                "858999482242-tp49dsiugjkuoch272b5e462565pc8ov.apps.googleusercontent.com")
        .signIn();
    if (kDebugMode) {
      print(googleUser);
    }
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return FirebaseAuth.instance.signInWithCredential(credential);
  }
}

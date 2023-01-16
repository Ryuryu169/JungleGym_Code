import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jungle_gym/src/Settings/AccountCheck.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../Constants/Util.dart';
import '../Login/LoginPage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("設定"),
      ),
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: FutureBuilder<Map<String, dynamic>>(
        future: checkInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text("Error Occured");
          } else if (!snapshot.hasData) {
            return const Text("No Data");
          }
          final data = snapshot.data;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SettingsList(
                sections: [
                  SettingsSection(
                    title: const Text("Account Info"),
                    tiles: <SettingsTile>[
                      SettingsTile(
                        leading: const Icon(Icons.email),
                        title: const Text("Email"),
                        value: Text("${user!.email}"),
                      ),
                      SettingsTile(
                        leading: const Icon(Icons.abc),
                        title: const Text("Name"),
                        value: Text("${data!["name"]}"),
                      ),
                      SettingsTile(
                        leading: const Icon(Icons.perm_identity),
                        title: const Text("Id"),
                        value: Text("${data["id"]}"),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: const Text('Language'),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.language),
                        title: const Text('Language'),
                        value: const Text('Japanese'),
                      ),
                      SettingsTile.switchTile(
                        onToggle: (value) {
                          value = !value;
                        },
                        initialValue: true,
                        leading: const Icon(Icons.format_paint),
                        title: const Text('Enable custom theme'),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: const Text("Account Settings"),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.password),
                        title: const Text("Change Password"),
                        onPressed: (BuildContext context) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Change Password"),
                                content: Text(
                                    "We will send a text to ${user!.email}"),
                                actions: [
                                  TextButton(
                                    child: const Text("Confirm"),
                                    onPressed: () async {
                                      await FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                              email: user!.email ?? "");
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.delete),
                        title: const Text("Delete Account"),
                        onPressed: (BuildContext context) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete Account"),
                                content: const Text("Are you sure?"),
                                actions: [
                                  TextButton(
                                    child: const Text("Sure"),
                                    onPressed: () async {
                                      await user?.delete();
                                      if (!mounted) return;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: const Text("Logout"),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.logout),
                        title: const Text("Logout"),
                        value: const Text("Switch to other account"),
                        onPressed: (BuildContext context) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Logout"),
                                content: const Text("Do you want to logout?"),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      final googleCurrentUser =
                                          GoogleSignIn().currentUser; //?? await GoogleSignIn().signIn();
                                      if (googleCurrentUser != null) {
                                        await GoogleSignIn().signOut();
                                      }
                                      await FirebaseAuth.instance.signOut();
                                      if(!mounted) return;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                    },
                                    child: const Text("Sure"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Canel"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> checkInfo() async {
    GeneralUse util = GeneralUse();
    final uid = user!.uid;
    final names = await util.findUser([uid]);
    final ids = await util.findId([uid]);
    return {"name": names[0], "id": ids[0]};
  }
}

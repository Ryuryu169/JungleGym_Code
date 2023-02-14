import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jungle_gym/src/Settings/AccountCheck.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../Constants/Util.dart';
import '../../Constants/debug.dart';
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
        title: Text("設定",style: GoogleFonts.kiwiMaru()),
      ),
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: FutureBuilder<Map<String, dynamic>>(
        future: checkInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text("エラー発生");
          } else if (!snapshot.hasData) {
            return const Text("データはありません");
          }
          final data = snapshot.data;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SettingsList(
                sections: [
                  SettingsSection(
                    title: const Text("アカウントの情報"),
                    tiles: <SettingsTile>[
                      SettingsTile(
                        leading: const Icon(Icons.email),
                        title: const Text("メールアカウント"),
                        value: Text("${user!.email}"),
                      ),
                      SettingsTile(
                        leading: const Icon(Icons.abc),
                        title: const Text("名前"),
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
                    title: const Text("言語"),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.language),
                        title: const Text('言語'),
                        value: const Text('日本語'),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: const Text("アカウント設定"),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.password),
                        title: const Text("パスワード変更"),
                        onPressed: (BuildContext context) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("パスワードの変更"),
                                content: Text(
                                    "${user!.email} にパスワードを変更するためのリンクを送信します"),
                                actions: [
                                  TextButton(
                                    child: const Text("了解"),
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
                        title: const Text("アカウント削除"),
                        onPressed: (BuildContext context) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("アカウントの削除"),
                                content: const Text("宜しいですか？"),
                                actions: [
                                  TextButton(
                                    child: const Text("確定"),
                                    onPressed: () async {
                                      //await user?.delete();
                                      if (!mounted) return;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              FootCount(),//const LoginPage(),
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
                    title: const Text("ログアウト"),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.logout),
                        title: const Text("ログアウト"),
                        value: const Text("アカウントの切り替え"),
                        onPressed: (BuildContext context) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("ログアウト"),
                                content: const Text("ログアウトしても宜しいですか？"),
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
                                    child: const Text("確定"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("キャンセル"),
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

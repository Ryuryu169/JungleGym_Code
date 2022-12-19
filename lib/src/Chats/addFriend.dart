import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({Key? key}) : super(key: key);

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  FocusNode? _focusNode;
  TextEditingController? _usernameController;

  Stream<Map<String, dynamic>> findUser(String? id) async* {
    final error = {"message": "Error"};
    final data = await FirebaseFirestore.instance
        .collection("users")
        .where("firstName", isEqualTo: id)
        .get();
    var thisData = data.docs[0]
        .data()
        .isNotEmpty ? data.docs[0].data() : error;
    if (data.docs[0]
        .data()
        .isNotEmpty) {
      final reference = data.docs[0].reference.toString();
      final uid = reference.substring(46, 74);
      thisData["uid"] = uid;
      thisData["message"] = "OK";
      if (kDebugMode) {
        print(uid);
      }
    }
    yield thisData;
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _usernameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("友達検索"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("名前で検索"),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                labelText: "Name",
                suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {});
                    }),
              ),
              onEditingComplete: () {
                _focusNode?.requestFocus();
              },
            ),
            StreamBuilder<Map<String, dynamic>>(
              stream: findUser(_usernameController?.text),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!snapshot.hasData || snapshot.data["message"] != "OK") {
                  return const Text("Found no Data");
                }
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(snapshot.data["firstName"]),
                    ),
                    TextButton(
                      onPressed: () async {
                        bool checkIfExists = false;

                        final data1 = await FirebaseFirestore.instance
                            .collection("rooms")
                            .where("userIds",
                            arrayContains: snapshot.data["uid"].toString())
                            .get();

                        // Check whether document "rooms" exists, and returns whether the user exists
                        if(data1.docs[0].data().isNotEmpty){
                          for (var i in data1.docs) {
                            List<dynamic> data = i.data()["userIds"];
                            final uid = FirebaseAuth.instance.currentUser?.uid;

                            for (var j in data) {
                              if (j == uid) checkIfExists = true;
                            }
                          }
                          // Depending on whether the user exists, you could add the user.
                          if (!checkIfExists) {
                            types.User user = types.User(id: snapshot.data["uid"]);
                            await FirebaseChatCore.instance
                                .createRoom(user);
                          } else {
                            showDialog<void>(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text('エラー'),
                                  content: const Text("既に友達として追加されています"),
                                  actions: <Widget>[
                                    GestureDetector(
                                      child: const Text('了解'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          const Text("No such room");
                        }
                      },
                      child: const Text("友達追加する"),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

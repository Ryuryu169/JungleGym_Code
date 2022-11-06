import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//import 'PlayingPage.dart';
import '../../Constants/kaigi.dart';
import '../HomePage/homepage.dart';

class OniRoomPage extends StatefulWidget {
  const OniRoomPage({Key? key, required this.roomNum}) : super(key: key);
  final int roomNum;

  @override
  State<OniRoomPage> createState() => _OniRoomPageState();
}

class _OniRoomPageState extends State<OniRoomPage> {
  final firebase = FirebaseFirestore.instance;
  final onigo = PlayOnigo.instance;

  List<String>? member;
  Map<String, dynamic>? info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () async {
            try {
              await onigo.deleteRoom(widget.roomNum.toString());
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }
            if (!mounted) return;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text("Room Number is ${widget.roomNum}")),
                  Container(
                    decoration: BoxDecoration(
                      //color: Colors.grey[300],
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: StreamBuilder<Map<String, dynamic>?>(
                        stream: firebase
                            .collection("Onigo")
                            .doc(widget.roomNum.toString())
                            .snapshots()
                            .map((doc) => doc.data()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else if (snapshot.hasData) {
                            var data = snapshot.data!;
                            var users = data['userIds'];
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  const Text("Players : "),
                                  FutureBuilder<List<String>>(
                                    future: findUser(users),
                                    builder: (context, snapshot2) {
                                      if (snapshot2.hasData) {
                                        if (kDebugMode) {
                                          print(snapshot2.data);
                                        }
                                        return Expanded(
                                          child: SizedBox(
                                            height: 200.0,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: snapshot2.data?.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Text(
                                                    snapshot2.data![index]);
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            //print(snapshot.data!.toString());
                            return const Text("No data");
                          }
                        },
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

  Future<List<String>> findUser(List<dynamic> uid) async {
    List<String> names = [];
    for (var d in uid) {
      final cu = await firebase.collection("users").doc(d.toString()).get();
      final data = cu.data();
      names.add(data!["firstName"].toString());
    }
    return names;
  }
}

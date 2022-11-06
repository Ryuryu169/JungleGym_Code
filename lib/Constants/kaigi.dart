import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlayOnigo {
  static final PlayOnigo instance = PlayOnigo._privateConstructor();
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  PlayOnigo._privateConstructor() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      firebaseUser = user;
    });
  }

  Future<Map<String, dynamic>> createGroupRoom({
    String? currentOni,
    String? currentTime,
    List<int>? code,
    Map<String, dynamic>? metadata,
    Map<String, dynamic>? info,
    required int roomNum,
    required int? isPlaying,
    required List<String> users,
    required Map<String, dynamic> rules,
  }) async {
    if (firebaseUser == null) return Future.error('User does not exist');


    await FirebaseFirestore.instance.collection("Onigo").doc(roomNum.toString()).set({
      'createdAt': FieldValue.serverTimestamp(),
      'currentOni' : currentOni,
      'currentTime' : currentTime,
      'code' : code,
      'info' : info,
      'isPlaying': isPlaying,
      'metadata': metadata,
      'rules': rules,
      'updatedAt': FieldValue.serverTimestamp(),
      'userIds': [firebaseUser?.uid.toString()],
    });
    return <String, dynamic> {
      'roomNum' : roomNum,
      'createdAt': FieldValue.serverTimestamp(),
      'currentOni' : currentOni,
      'currentTime' : currentTime,
      'code' : code,
      'info' : info,
      'isPlaying': isPlaying,
      'metadata': metadata,
      'rules': rules,
      'updatedAt': FieldValue.serverTimestamp(),
      'userIds': [firebaseUser?.uid.toString()],
    };
  }

  void updateRoom(Map<String, dynamic> room) async {
    if (firebaseUser == null) return;

    room.removeWhere((key, value) =>
    key == 'createdAt' ||
        key == 'roomNum' ||
        key == 'lastMessages');

    room['updatedAt'] = FieldValue.serverTimestamp();

    await FirebaseFirestore.instance
        .collection("Onigo")
        .doc(room['roomNum'])
        .update(room);
  }

  Future<void> deleteRoom(String roomId) async {
    await FirebaseFirestore.instance
        .collection("Onigo")
        .doc(roomId)
        .delete();
  }
}

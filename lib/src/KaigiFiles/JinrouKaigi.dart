import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlayJinrou {
  static final PlayJinrou instance = PlayJinrou._privateConstructor();
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  PlayJinrou._privateConstructor() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      firebaseUser = user;
    });
  }

  Future<Map<String, dynamic>> createGroupRoom({
    String? currentTime,
    List<int>? code,
    Map<String, dynamic>? metadata,
    Map<String, dynamic>? info,
    Map<String, dynamic>? items,
    Map<String, dynamic>? roles,
    required String host,
    required int roomNum,
    required int? isPlaying,
    required List<String> users,
    required Map<String, dynamic> ready,
    required Map<String, dynamic> rules,
  }) async {
    if (firebaseUser == null) return Future.error('User does not exist');


    await FirebaseFirestore.instance.collection("Jinrou").doc(roomNum.toString()).set({
      'createdAt': FieldValue.serverTimestamp(),
      'currentTime' : currentTime,
      'code' : code,
      'host' : host,
      'info' : info,
      'isPlaying': isPlaying,
      'metadata': metadata,
      'roles' : roles,
      'rules': rules,
      'ready' : ready,
      'items': items,
      'updatedAt': FieldValue.serverTimestamp(),
      'userIds': [firebaseUser?.uid.toString()],
    });
    return <String, dynamic> {
      'roomNum' : roomNum,
      'createdAt': FieldValue.serverTimestamp(),
      'currentTime' : currentTime,
      'code' : code,
      'host' : host,
      'info' : info,
      'isPlaying': isPlaying,
      'metadata': metadata,
      'roles' : roles,
      'ready' : ready,
      'rules': rules,
      'items' : items,
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
        .collection("Jinrou")
        .doc(room['roomNum'])
        .update(room);
  }

  Future<void> deleteRoom(String roomId) async {
    await FirebaseFirestore.instance
        .collection("Jinrou")
        .doc(roomId)
        .delete();
  }
}
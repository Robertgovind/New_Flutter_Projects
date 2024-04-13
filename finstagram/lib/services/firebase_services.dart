import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final String USER_COLLECTION = 'users';
final String POST_COLLECTION = 'posts';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _database = FirebaseFirestore.instance;
  Map? currentUser;

  FirebaseService();

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String _userId = _userCredential.user!.uid;
      String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask _task =
          _storage.ref('image/$_userId/$_fileName').putFile(image);
      return _task.then((snapshot) async {
        String _downloadUrl = await snapshot.ref.getDownloadURL();
        await _database.collection(USER_COLLECTION).doc(_userId).set({
          "name": name,
          "email": email,
          "image": _downloadUrl,
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (_userCredential.user != null) {
        currentUser = await getUserData(uid: _userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      print("!!!!An Exception caught!!!!");
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot _doc =
        await _database.collection(USER_COLLECTION).doc(uid).get();
    return _doc.data() as Map;
  }

  Future<bool> postImage(File image) async {
    try {
      String _userId = _auth.currentUser!.uid;
      String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);

      UploadTask task =
          _storage.ref('image/$_userId/$_fileName').putFile(image);
      return await task.then((snapshot) async {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await _database.collection(POST_COLLECTION).add({
          "userId": _userId,
          "timestamp": Timestamp.now(),
          "image": downloadUrl
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getPostForUser() {
    String _userId = _auth.currentUser!.uid;
    return _database
        .collection(POST_COLLECTION)
        .where('userId', isEqualTo: _userId)
        .snapshots();
  }

  Stream<QuerySnapshot> getLatestPost() {
    return _database
        .collection(POST_COLLECTION)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}

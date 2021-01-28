import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/Models/UserAuth.dart';
import 'package:flutter_firebase/Pages/Home.dart';

class CrudFireBuilder {
  static CrudFireBuilder _fireBuilder;

  // is used to create only one instance from this class >>>>
  static CrudFireBuilder getInstance() {
    if (_fireBuilder == null) {
      return _fireBuilder = CrudFireBuilder();
    }
    return _fireBuilder;
  }

  // is used to add user info in cloud fire store >>>>>
  Future<void> addUser(UserAuth user, BuildContext context) async {
    var data = _prepareUser(user);
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collectionRef = store.collection("Users");
    DocumentReference documentRef = collectionRef.doc(_getCurrentUserId());
    await documentRef.set(data).whenComplete(() {
      Navigator.of(context).pushReplacementNamed(Home.ID);
    }).catchError((e) => print(e));
  }

  // get all user from cloud fire store >>>>
  Stream<QuerySnapshot> getAllUser() {
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collectRef = store.collection("Users");
    return collectRef.snapshots();
  }

  // update user info >>>>
  updateUser(UserAuth user) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Users");
    DocumentReference docRef = collRef.doc(user.id);
    Map<String, dynamic> userMap = user.toMap();
    docRef
        .update(userMap)
        .then((value) => print("user is successfully updated"))
        .catchError((onError) => print("$onError"));
  }

  // delete user >>>>
  deleteUser(String id) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Users");
    DocumentReference docRef = collRef.doc(id);
    docRef
        .delete()
        .then((value) => print("user is successfully deleted"))
        .catchError((onError) => print("$onError"));
  }

  // get current user id >>>>>>>
  String _getCurrentUserId() {
    String userId = FirebaseAuth.instance.currentUser.uid;
    return userId;
  }

  // convert user object to map >>>>>>
  Map<String, dynamic> _prepareUser(UserAuth user) {
    UserAuth userAuth = UserAuth.userAllInfoObj(
        _getCurrentUserId(), user.email, user.name, user.phone);
    var data = userAuth.toMap();
    return data;
  }
}

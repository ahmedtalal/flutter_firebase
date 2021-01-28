import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firebase/CrudFireBuilder.dart';
import 'package:flutter_firebase/Models/UserAuth.dart';
import 'package:flutter_firebase/Pages/Home.dart';
import 'package:flutter_firebase/Pages/Register.dart';

class FirebaseAuthBuilder {
  static FirebaseAuthBuilder _builder;

  // create only one instance form this class >>>>
  static FirebaseAuthBuilder getInstance() {
    if (_builder == null) {
      return _builder = FirebaseAuthBuilder();
    }
    return _builder;
  }

  // this method is used to initialize firebase another word binding firebase with my project >>>
  Future<void> initializeFirebase() async {
    WidgetsFlutterBinding
        .ensureInitialized(); // is used to interact with the flutter engine >>
    await Firebase
        .initializeApp(); // need to call native code to initialize firebase >>>
  }

  // check if the user is authenticated or not >>>
  checkUserAuth(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User user) {
      if (user != null) {
        Navigator.of(context).pushReplacementNamed(Home.ID);
      }
    });
  }

  // this is registration method using firebase >>>>
  Future<void> registration(BuildContext context, UserAuth user) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      await CrudFireBuilder.getInstance().addUser(user, context);

    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        _createAlertDialog(context, "weak-password error", "this password is weak") ;
      } else if (e.code == "email-already-in-use") {

      } else if (e.code == "invalid-email") {
        _createAlertDialog(context, "invalid-email error", "this emial is invalid") ;

      }
    } catch (e) {
      _createAlertDialog(context, "registration error", e.toString()) ;
    }
  }

  // sign out method  >>>>
  Future<void> signOut(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.of(context).pushReplacementNamed(Register.ID);
  }

  // login method with email and password >>>>
  Future<void> login(BuildContext context , UserAuth user) async {
    try{
      FirebaseAuth auth = FirebaseAuth.instance ;
      await auth.signInWithEmailAndPassword(email: user.email, password: user.password) ;
      Navigator.of(context).pushReplacementNamed(Home.ID) ;

    }on FirebaseException catch(e){
      if(e.code == "invalid-email"){
        //print("email") ;
        _createAlertDialog(context, "email error", "this emails is invalid") ;
      }else if(e.code   == "wrong-password"){
        _createAlertDialog(context, "password error", "this password is wrong");
      }else if(e.code == "user-not-found") {
        _createAlertDialog(context, "user error", "this user is not found") ;
      }
    }catch(e){
      print("${e.toString()}") ;
      _createAlertDialog(context, "login error", e.toString()) ;
    }
  }

  // is used to create alert dialog >>>>>
  void _createAlertDialog(BuildContext context , String title , String content) {
    showDialog(
        context: context ,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          RaisedButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(context),
          )
        ],
      )
    );
  }
}

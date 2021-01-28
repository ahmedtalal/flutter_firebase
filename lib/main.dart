import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firebase/FirebaseAuthBuilder.dart';
import 'package:flutter_firebase/Pages/Register.dart';
import 'package:flutter_firebase/RoutingModel.dart';

main() async{
  await FirebaseAuthBuilder.getInstance().initializeFirebase() ;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red ,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Register.ID,
      routes: route ,
    );
  }
}

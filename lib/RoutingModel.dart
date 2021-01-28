import 'package:flutter/material.dart';
import 'package:flutter_firebase/Pages/Home.dart';
import 'package:flutter_firebase/Pages/Login.dart';
import 'package:flutter_firebase/Pages/Register.dart';

var route = <String,WidgetBuilder>{
  Home.ID : (context) => Home() ,
  Login.ID : (context) => Login() ,
  Register.ID : (context) => Register() ,
} ;
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firebase/FirebaseAuthBuilder.dart';
import 'package:flutter_firebase/Models/UserAuth.dart';
import 'package:flutter_firebase/Pages/Login.dart';

class Register extends StatefulWidget {
  static const String ID = "/register";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _formkey = GlobalKey<FormState>();
  String _email, _password, _name,_phone;

  @override
  void initState() {
    super.initState();
    FirebaseAuthBuilder().checkUserAuth(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90.0, horizontal: 16.0),
        child: ListView(
          children: [
            Text(
              "Register",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  // name text field >>>>
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(fontSize: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "you must enter your name ";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  // phone text field >>>>
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "phone",
                      labelStyle: TextStyle(fontSize: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "you must enter your phone ";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _phone = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // email text field >>>>
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(fontSize: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "you must enter your email ";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  // password text field >>>>
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "you must enter your password ";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  // submit button >>>>>>
                  Container(
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: FlatButton(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async{
                        if(_formkey.currentState.validate()){
                          UserAuth user = UserAuth.userObj(_email, _name, _password,_phone);
                          await FirebaseAuthBuilder.getInstance().registration(context, user);
                        }
                      },
                    ),
                  ),

                  SizedBox(
                    height: 15.0,
                  ),

                  // login link >>>>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account ?",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(Login.ID) ;
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

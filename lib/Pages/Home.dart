import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firebase/CrudFireBuilder.dart';
import 'package:flutter_firebase/Firebase/FirebaseAuthBuilder.dart';
import 'package:flutter_firebase/Models/UserAuth.dart';
import 'package:flutter_firebase/Pages/UserDetails.dart';

class Home extends StatefulWidget {
  static const String ID = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Firebase"),
          actions: [
            FlatButton(
              onPressed: () async =>
                  await FirebaseAuthBuilder.getInstance().signOut(context),
              child: Text(
                "LogOut",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: CrudFireBuilder.getInstance().getAllUser(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("No data at this time"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data.docs.map((doc) {
                UserAuth user = UserAuth.fromMap(doc.data());
                return Card(
                  margin: EdgeInsets.all(10.0),
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: Text(user.phone),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserDetails(
                        user: user,
                      ),
                    )),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}

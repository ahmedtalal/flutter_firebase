import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firebase/CrudFireBuilder.dart';
import 'package:flutter_firebase/Models/UserAuth.dart';

class UserDetails extends StatefulWidget {
  UserAuth user;
  UserDetails({this.user});
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String _name, _phone, _email, _id;
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _phone = widget.user.phone;
    _email = widget.user.email;
    _id = widget.user.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50,),
                //name text field >>>>
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) => _name = value,
                  validator: (value) {
                    if(value.isEmpty){
                      return "this emails is required" ;
                    }
                    return null ;
                  },
                  initialValue: _name,
                ),

                SizedBox(height: 20,),

                // phone text field >>>>
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "phone",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) => _phone=value,
                  validator: (value) {
                    if(value.isEmpty){
                      return "this phone is required" ;
                    }
                    return null ;
                  },
                  initialValue: _phone,
                ),
                SizedBox(height: 20,),
                // update button >>>
                RaisedButton(
                  child: Text("Update"),
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      UserAuth user = UserAuth.userAllInfoObj(_id, _email, _name, _phone);
                      CrudFireBuilder.getInstance().updateUser(user);
                      Navigator.of(context).pop(context) ;
                    }
                  },
                ) ,
                SizedBox(height: 20,),
                // delete button >>>
                RaisedButton(
                  child: Text("Delete"),
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      CrudFireBuilder.getInstance().deleteUser(_id);
                      Navigator.of(context).pop(context) ;
                    }
                  },
                ) ,
              ],
            )),
      ),
    );
  }
}

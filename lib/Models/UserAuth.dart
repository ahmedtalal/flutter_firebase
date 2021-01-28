class UserAuth {
  String _email , _password ,_name,_phone,_id;
  UserAuth(this._email,this._password) ; // unNamed constructor >>>
  UserAuth.userObj(this._email,this._name,this._password,this._phone) ; // named constructor >>>
  UserAuth.userAllInfoObj(this._id,this._email,this._name,this._phone) ;

  UserAuth.fromMap(Map<String,dynamic> data){
    _id = data["id"];
    _email = data["email"] ;
    _name = data["name"] ;
    _phone = data["phone"] ;
  }
  Map<String,dynamic> toMap() => {
    "id" : this._id ,
    "name": this._name ,
    "email" : this._email ,
    "phone" : this._phone,
  };

  String get email => _email ;

  set setEmail(String email){
    _email = email ;
  }

  String get password => _password ;

  set setPassword(String password){
    _password = password ;
  }

  get name => _name;

  set setName(name) {
    _name = name;
  }

  get phone => _phone;

  set setPhone(value) {
    _phone = value;
  }

  get id => _id;

  set setId(value) {
    _id = value;
  }
}
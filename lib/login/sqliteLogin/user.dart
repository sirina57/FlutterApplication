
class User {
  String _username;
  String _password;
   String _email;
   String _url;
   int intake;
   String sleep;
   String weight;
   String  track;
   int breakfastCalories;
   int lunchCalories;
   int dinnerCalories;
    int snackCalories;
   String heart ;

  User(this._username, this._password,this._email);
  User.Account(this._username, this._password,this._email,this.intake,this.sleep
  ,this.weight,this.breakfastCalories,this.lunchCalories,this.dinnerCalories,this.snackCalories);
  User.map(dynamic obj) {
    this._username = obj['username'];
    this._password = obj['password'];
     this._password = obj['email'];
  }
   User.accountMap(dynamic obj) {
    this._username = obj['username'];
    this._password = obj['password'];
     this._password = obj['email'];
      this.intake = obj['intake'];
    this.sleep = obj['sleep'];
     this.weight = obj['weight'];
     this.breakfastCalories= obj['Bcalories'];
      this.lunchCalories= obj['Lcalories'];
       this.dinnerCalories= obj['Dcalories'];
        this.snackCalories= obj['Scalories'];
  }

  String get username => _username;
  String get password => _password;
   String get email => _email;
    String get url => _url;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
     map["email"] = _email;
    return map;
  }
   Map<String, dynamic> accountToMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
     map["email"] = _email;
    map['intake']=intake;
    map['sleep']=sleep;
   map['weight']=weight;
   map['Bcalories']=breakfastCalories;
    map['Lcalories']=lunchCalories;
     map['Dcalories']=dinnerCalories;
      map['Scalories']=snackCalories;
    return map;
  }


  static User fromMap(Map<String, Object> list) {
    return User(
     list["username"]  as String,
    list["password"] as String,
     list["email"] as String,);
}
 static User accountFromMap(Map<String, Object> list) {
    return User.Account(
     list["username"]  as String,
    list["password"] as String,
     list["email"] as String,
     list['intake']as int,
    list['sleep'] as String,
   list['weight'] as String,
  list['Bcalories'] as int,
   list['Lcalories'] as int,
  list['Dcalories'] as int,
   list['Scalories'] as int);
}

  User.fromJsonMap(Map map)
      : _username =  map["username"] ,
   _password= map["password"],
     _email= map["email"] ;


 User.accountFromJsonMap(Map map)
      : _username =  map["username"] ,
   _password= map["password"],
     _email= map["email"] ,
     intake= map['intake'],
   sleep= map['sleep'],
  weight= map['weight'],
  breakfastCalories= map['Bcalories'],
  lunchCalories= map['Lcalories'],
  dinnerCalories= map['Dcalories'],
  snackCalories= map['Scalories'];
        
}

import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/daysdata/sqlitedays/pages/addContract.dart';
import 'package:appv1/daysdata/sqlitedays/pages/home.dart';
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/google_sign_in/homepage.dart';
import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/login/sqliteLogin/dbHelper.dart';
import 'package:appv1/login/sqliteLogin/loginModel.dart';
import 'package:appv1/login/sqliteLogin/restData.dart';
import 'package:appv1/login/sqliteLogin/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements AddPageContract, LoginPageContract {
  BuildContext _ctx;
  final formKey = new GlobalKey<FormState>();
  final useraddscaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password,_email;
 AddPagePresenter _daypresenter;
  LoginPagePresenter _presenter;

  _LoginPageState() {
    _daypresenter = new AddPagePresenter(this);
    _presenter = new LoginPagePresenter(this);
  }

String _validateEmail(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "Enter email address";
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return null;
  }

  // The pattern of the email didn't match the regex above.
  return 'Email is not valid';
}
  void _showSnackBar(String text) {
    useraddscaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    //delete db tn 
    var deletebtn= ScopedModelDescendant<LoginModel>(
            builder: (context, child, model) =>ScopedModelDescendant<UserModel>(
            builder: (context, child, userModel) => IconButton(
              iconSize: 20.0,
              color: Colors.red,
             icon: Icon(Icons.cancel),
             onPressed:()
             {
              model.delete();
              userModel.deleteItem(User.Account(_username, _password,_email,0,'__','__',0,0,0,0));
             }
      ),));
     // submit btn    
    var loginBtn = ScopedModelDescendant<LoginModel>(
            builder: (context, child, model) =>ScopedModelDescendant<UserModel>(
            builder: (context, child, userModel) =>ScopedModelDescendant<DayModel>(
            builder: (context, child, dayModel) => RaisedButton(
      onPressed:(){
        // validating and saving  the form 
       final form = formKey.currentState;
      if (form.validate()) {
        form.save();
           // adding my user to my models
           model.addItem(User(_username, _password,_email));
           print('1');
           userModel.addItem(User.Account(_username, _password,_email,0,'__','__',0,0,0,0));
            print('2');
            // my days 
            var db =AppDatabase();
           //db.save(DayDiary('Yesterday',0,0,0,0, 'water', 'weight'));
           print('3');
            db.save(DayDiary('Today',0,0,0,0,'water', 'weight'));
           // db.save(DayDiary('Tomorrow',0,0,0,0, 'water', 'weight'));
           
      _presenter.doLogin(_username, _password,_email);        
       }
      
      },
      child: new Text("Submit"),
      color: Colors.green,
     ),
            ) ));
  // body of my page
    var loginForm =  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            "",
            textScaleFactor: 2.0,
          ),
          new Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new TextFormField(
                    onSaved: (val) => _username = val,
                    decoration: new InputDecoration(
                      labelText: "  Username",
                       icon: Icon(Icons.person)
                       ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new TextFormField(
                    validator:_validateEmail ,
                    onSaved: (val) => _email = val,
                    decoration: new InputDecoration(
                      labelText: "  Email",
                       icon: Icon(Icons.email)
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new TextFormField(
                
                    onSaved: (val) => _password = val,
                    decoration: new InputDecoration(
                      labelText: "  Password",
                      icon: Icon(Icons.label_important)),
                  ),
                ),
              ],
            ),
          ),
        loginBtn,
       SignInBtns()
       //delete my db
        //deletebtn,
         ],
      );
// my login page 
    return ScopedModelDescendant<LoginModel>(
            builder: (context, child, model) =>ScopedModelDescendant<DayModel>(
            builder: (context, child, dayModel) => SafeArea(
            child: Scaffold(
       
        key: useraddscaffoldKey,
        body:  Center(
                child: loginForm,// form + btns
          ),
        ),
       ),
     ),
     );
  }
  // for the day model 
  @override
  void onAddError(String error) {
  print('error: $error');
  }
  @override
  void onAddSuccess(DayDiary day) async {
    var db = new AppDatabase();
    await db.save(day);
    await db.show();
  }

// for adding users /login model
  @override
  void onLoginError(String error) {
   _showSnackBar(error);
   
  }
 @override
  void onLoginSuccess(User user) async {
   _showSnackBar(user.toString());
    var db = new LoginDatabase();
    await db.saveUser(user);
    await db.show();
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Home()));
  }
}

// for adding users 
abstract class LoginPageContract {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginPagePresenter {
  LoginPageContract _view;
  RestData api = new RestData();
  LoginPagePresenter(this._view);

  doLogin(String username, String password, String email) {
    api
        .login(username, password,email)
        .then((user) => _view.onLoginSuccess(user))
        .catchError((onError) => _view.onLoginError(onError.toString()));
  }
}
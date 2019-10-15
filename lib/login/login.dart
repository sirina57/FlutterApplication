/**
import 'package:appv1/daysdata/sqlitedays/pages/home.dart';
import 'package:appv1/login/sqliteLogin/dbHelper.dart';
import 'package:appv1/login/sqliteLogin/loginModel.dart';
import 'package:appv1/login/sqliteLogin/pages/loginaddUser.dart';
import 'package:appv1/login/sqliteLogin/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class InputBox extends StatefulWidget {
  @override
  InputBoxState createState() => InputBoxState();
}

class InputBoxState extends State<InputBox> implements LoginPageContract {
LoginPagePresenter _presenter;

  InputBoxState() {
    _presenter = new LoginPagePresenter(this);
  }
  bool loggedIn = false;
  String name ='';
  String email ='';
  String _email, _username, _password;

  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();

  var nameKey;
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

  @override
  Widget build(BuildContext context) {
  
    return ScopedModelDescendant<LoginModel>(
       builder: (context, child, model) => Scaffold(
        backgroundColor: Colors.red ,
        key: mainKey,
       
       // appBar: AppBar(title: Text("Login")),
        body:loggedIn == false
                ?  SafeArea(
         child:  Card(
             margin: EdgeInsets.all(10.0),
             color: Colors.grey[850],
                    child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Form(
                          key: formKey,
                          child: ListView(
                            children: <Widget>[
                              Card(
                                 margin: EdgeInsets.all(10.0),
                                color: Colors.grey[650],
                             child: TextFormField(
                                 autocorrect: false,
                                  decoration: InputDecoration(
                                    labelText: "Email:",
                                  ),
                                  validator:_validateEmail,
                                  onSaved: (str) =>  _email = str,
                                ),
                              ),
                              Card(
                                 margin: EdgeInsets.all(10.0),
                                color: Colors.grey[650],
                             child: TextFormField(
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    labelText: "Username:",
                                  ),
                                  validator: (str) =>
                                      str.length <= 5 ? "Not a Valid Username!" : null,
                                  onSaved: (str) => _username = str,
                                ),
                              ),
                             Card(
                                margin: EdgeInsets.all(10.0),
                                color: Colors.grey[650],
                             child: TextFormField(
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    labelText: "Password:",
                                  ),
                                  validator: (str) =>
                                      str.length <= 7 ? "Not a Valid Password!" : null,
                                  onSaved: (str) => _password = str,
                                  obscureText: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:RaisedButton(
                                  color: Colors.green,
                                  child: Text("Submit"),
                                  onPressed:(){
                                     var form = formKey.currentState;
                             if (form.validate()) {
                               form.save();
                             if ( model.verifUser(User(_username,_password,_email))==true)
                               {
                                  _presenter.doLogin(_username, _password,_email);
                                  model.setCurrentUser(User(_username,_password,_email));

                               }

                               setState(() {
                                 loggedIn = true;
                                 name= '$_username';
                                   email=' $_email';
                                    form.setState((){

                                    });
                                    
                                    
                                    });
                             }})),
                              
                             
                            ],
                          ),
                        ),
                      ),
                    ),
                   
                   
                  
                )
                : Home( ),
                
      ),
    );
  }

 /** void onPressed() {
    var form = formKey.currentState;


    if (form.validate()) {
      form.save();
      
      setState(() {
        loggedIn = true;
        name= '$_username';
        email=' $_email';
        form.setState((){
         
        });
        
      });
     

      var snackbar = SnackBar(
        content:
            Text('Username: $_username, Email: $_email, Password: $_password'),
        duration: Duration(milliseconds: 5000),
      );

      mainKey.currentState.showSnackBar(snackbar);
     
    
    }
  } */

  @override
  void onLoginError(String error) {
  print('$error');
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
     var db = new LoginDatabase();
   
    await db.show();
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Home()));
 
  }
} */
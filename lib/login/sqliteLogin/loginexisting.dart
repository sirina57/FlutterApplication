import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/daysdata/sqlitedays/pages/addContract.dart';
import 'package:appv1/daysdata/sqlitedays/pages/home.dart';
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/login/sqliteLogin/dbHelper.dart';
import 'package:appv1/login/sqliteLogin/loginModel.dart';
import 'package:appv1/login/sqliteLogin/restData.dart';
import 'package:appv1/login/sqliteLogin/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
//firebase sign in with email and password ?
class LoginFBPage extends StatefulWidget {
  final String title;
  //final BaseAuth auth;
  final VoidCallback onSignIn;
  @override
  _LoginPageState createState() => new _LoginPageState();
}
enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginFBPage> implements AddPageContract, LoginPageContract {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final useraddscaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password,_email;
   FormType _formType = FormType.login;
  String _authHint = '';

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
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
 
 void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _authHint = '';
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _authHint = '';
    });
  }
void validateAndSubmit() async {
    try {
    if (validateAndSave()) {
    
        FirebaseUser user= await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email,password: _password);
print('signed in :${user.uid}');
      //  String userId = _formType == FormType.login
          //  ? await widget.auth.signIn(_email, _password)
           // : await widget.auth.createUser(_email, _password);
        setState(() {
        //  _authHint = 'Signed In\n\nUser id: $userId';
        }
        );
       // widget.onSignIn();
      }
     else {
    
        FirebaseUser user= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email,password: _password);
print( 'registered  ${user.uid}');
      
      setState(() {
        _authHint = '';
      });
    }
    }catch(e){

    }}

   List<Widget> submitWidgets() {
    switch (_formType) {
      case FormType.login:
        return [
          new RaisedButton(
            key: new Key('login'),
            child: Text('Login'),
            //text: 'Login',
          //  height: 44.0,
            onPressed: validateAndSubmit
          ),
          new FlatButton(
            key: new Key('need-account'),
            child: new Text("Need an account? Register"),
            onPressed: moveToRegister
          ),
        ];
      case FormType.register:
        return [
          new RaisedButton(
            key: new Key('register'),
           // text: 
           child: Text('Create an account',),
           // height: 44.0,
            onPressed: validateAndSubmit
          ),
          new FlatButton(
            key: new Key('need-login'),
            child: new Text("Have an account? Login"),
            onPressed: moveToLogin
          ),
        ];
    }
    return null;
  }
   Widget hintText() {
    return new Container(
        //height: 80.0,
        padding: const EdgeInsets.all(32.0),
        child: new Text(
            _authHint,
            key: new Key('hint'),
            style: new TextStyle(fontSize: 18.0, color: Colors.grey),
            textAlign: TextAlign.center)
    );
  }


  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var deletebtn= ScopedModelDescendant<LoginModel>(
            builder: (context, child, model) =>ScopedModelDescendant<UserModel>(
            builder: (context, child, userModel) => IconButton(
              iconSize: 20.0,
              color: Colors.red,
        icon: Icon(Icons.cancel),
         onPressed:(){
       
               model.delete();
               userModel.deleteItem(User.Account(_username, _password,_email,0,'__','__',0,0,0,0));

        //  _presenter.doLogin(_username, _password,_email);
          
         }
      ),));
         
    var loginBtn = ScopedModelDescendant<LoginModel>(
            builder: (context, child, model) =>ScopedModelDescendant<UserModel>(
            builder: (context, child, userModel) =>ScopedModelDescendant<DayModel>(
            builder: (context, child, dayModel) => RaisedButton(
      onPressed:(){
         final form = formKey.currentState;
      if (form.validate()) {
        form.save();
           model.addItem(User(_username, _password,_email));
           print('1');
           userModel.addItem(User.Account(_username, _password,_email,0,'__','__',0,0,0,0));
            print('2');
              var db =AppDatabase();
           db.save(DayDiary('Yesterday',0,0,0,0, 'water', 'weight'));
              print('3');
               db.save(DayDiary('Today',0,0,0,0,'water', 'weight'));
             db.save(DayDiary('Tomorrow',0,0,0,0, 'water', 'weight'));
           
      _presenter.doLogin(_username, _password,_email);
       /*  DayDiary  yesterday= DayDiary('Yesterday','breakfast', 'dinner', 'lunch', 'snack', 'water', 'weight');
                      dayModel.addItem(yesterday);
        _daypresenter.doAdd('','breakfast', 'dinner', 'lunch', 'snack', 'water', 'weight');
           
        DayDiary  today= DayDiary('','breakfast', 'dinner', 'lunch', 'snack', 'water', 'weight');
                      dayModel.addItem(today);
         _daypresenter.doAdd('Today','breakfast', 'dinner', 'lunch', 'snack', 'water', 'weight');             
         DayDiary  tomorrow= DayDiary('Tomorrow','breakfast', 'dinner', 'lunch', 'snack', 'water', 'weight');
                      dayModel.addItem(tomorrow);
       _daypresenter.doAdd('','breakfast', 'dinner', 'lunch', 'snack', 'water', 'weight');
       */           
       }
      
      },
      child: new Text("Submit"),
      color: Colors.green,
     ),
            ) ));

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
                 validator: (val) => val.isEmpty ? 'Password can\'t be empty.' : null,
                    onSaved: (val) => _password = val,
                    obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "  Password",
                      icon: Icon(Icons.label_important)),
                  ),
                ),
              ],
            ),
          ),
         Column(
           children: submitWidgets(),
         )
        //loginBtn,
        //deletebtn,
        
          /**  Card(  color: Colors.grey[750],
             margin: EdgeInsets.all(10.0),
              child:ListTile(
            onTap: () =>
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => LoginexistingPage())),
                        title: Text('Sign Up',
                        style: TextStyle(
                         color: Colors.grey,
                        ),
                        //
                       ),
                      )
                    ) */
        ],
      
    );

    return ScopedModelDescendant<LoginModel>(
            builder: (context, child, model) =>ScopedModelDescendant<DayModel>(
            builder: (context, child, dayModel) => SafeArea(
                            child: Scaffold(
       
        key: useraddscaffoldKey,
        body:  Center(
                child: loginForm,
          ),
        ),
              ),
            ),
      
    );
  }
  
  @override
  void onAddError(String error) {
    // TODO: implement onLoginError
  print('error: $error');
    
  }

  @override
  void onAddSuccess(DayDiary day) async {
   
    var db = new AppDatabase();
    await db.save(day);
    await db.show();
   // Navigator.of(context).pushNamed("/weight");
  }


  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    _showSnackBar(user.toString());
    setState(() {
      _isLoading = false;
    });
    var db = new LoginDatabase();
    await db.saveUser(user);
    await db.show();
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Home()));
  }
}


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
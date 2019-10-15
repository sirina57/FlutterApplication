import 'dart:async';

import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/daysdata/sqlitedays/pages/home.dart';
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/login/sqliteLogin/pages/loginaddUser.dart';
import 'package:appv1/login/sqliteLogin/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


//test my btns
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInBtns()
    );
  }
}
// sign in and out google account
class SignInBtns extends StatelessWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication= await googleSignInAccount.authentication;
    FirebaseUser user= await _auth.signInWithGoogle(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);
      print("User Name : ${user.displayName}");
      return user;
  }
  
  void _signOut(){
    googleSignIn.signOut();
     print("User signed out");


  }
  @override
  Widget build(BuildContext context) {
   
    return Column(
           children: <Widget>[
             // Text(''),
         //   Text('You have a Google Account ? Sign in'),
           Text(''),
          ScopedModelDescendant<UserModel>(
            builder: (context, child, userModel) =>ScopedModelDescendant<DayModel>(
            builder: (context, child, dayModel) => FlatButton(
           color: Colors.green[900],
          child:  Text('You have a Google Account ? Sign in'),
          onPressed: ()=>_signIn(context)
         .then((FirebaseUser user){
           print(user);
               userModel.addItem(User.Account(user.displayName, '',user.email,0,'__','__',0,0,0,0));
          var db =AppDatabase();
          // db.save(DayDiary('Yesterday',0,0,0,0, 'water', 'weight'));
           print('3');
              db.save(DayDiary('Today',0,0,0,0,'water', 'weight'));
             // db.save(DayDiary('Tomorrow',0,0,0,0, 'water', 'weight'));
           
         
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
           })
          .catchError((e)=>print(e)),
        ),
            ),
            ),
        
                ],
              );
  }    

}
class SignOutBtn extends StatelessWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication= await googleSignInAccount.authentication;
    FirebaseUser user= await _auth.signInWithGoogle(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);
      print("User Name : ${user.displayName}");
      return user;
  }
  
  void _signOut(){
    googleSignIn.signOut();
     print("User signed out");


  }
  @override
  Widget build(BuildContext context) {
   
    return Column(
           children: <Widget>[
             // Text(''),
         //   Text('You have a Google Account ? Sign in'),
           Text(''),
          ScopedModelDescendant<UserModel>(
            builder: (context, child, userModel) => ListTile(
           
          title: Text("sign out"),
          trailing: new Icon(Icons.exit_to_app),
          onTap:(){
            _signOut;
             userModel.delete();
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
           })
          
        ),
                ],
              );
  }    

}
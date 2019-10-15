import 'dart:async';

import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/model/drawer.dart';
import 'package:appv1/model/healthart.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class Health extends StatefulWidget{
 
  @override
 _MyHomeState createState() => new _MyHomeState() ;
}
class _MyHomeState extends State<StatefulWidget>{
  List<Article> _articles =health;
  @override
  Widget build(BuildContext context) {
     
  return ScopedModelDescendant<UserModel>(
              builder: (context, child, model) => Scaffold(
      appBar: AppBar(
        title: new Text("Health Calculator"),
           actions: <Widget>[
            new DrawerHeader(
          child: Icon(Icons.notifications),
        ),
                ],
          backgroundColor: Colors.red,
         ),
         drawer:  leftDrawer(context,),
        
     endDrawer: rightDrawer(context),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 1));
          setState(() {
                   // _articles.removeAt(0);
                  });
            return ;

          },
                child: ListView(
            children: _articles.map(_buildItem).toList(),
                    
                       
                    ),
        ),
                ),
                
        
    ),
  );
            }
          
       
          
 Widget _buildItem(Article e) {
   return Padding(
     key: Key(e.title),
     padding: EdgeInsets.all(16.0),
     child: Card(
       margin: EdgeInsets.all(10.0),
            child: ExpansionTile(
    title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
    
        new Text(e.title),
    ],),
   
       children:<Widget>[
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: Text(e.description),
         ),

       ]
       
  
       ),
     ));
  }
}

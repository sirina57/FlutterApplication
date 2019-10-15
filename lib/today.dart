import 'dart:async';

import 'package:flutter/material.dart';

import './today.dart' as today; 
import './tomorow.dart' as tomorrow;
import './yesterday.dart' as yesterday ;


class Today extends StatefulWidget
{
@override
_TodayState createState() => new _TodayState();
}

class _TodayState extends State<Today> with SingleTickerProviderStateMixin {
  
 final todayKey = GlobalKey<ScaffoldState>();
  TabController controller;
    //input fields
  Card field(String title,String img,String page ) {
    return new Card(
           color: Colors.grey[800],    
              child:new FlatButton(
            child:Row(
              mainAxisSize: MainAxisSize.max,

                    children: [
          
            new Image.asset(
                    img,
                   height: 25.0,
                   width: 25.0,
                   color: Colors.white,),
           
            
            new Text(title,textAlign: TextAlign.center,style: new TextStyle( fontSize: 15.0 ,color: Colors.white ),),        

                    ]
          ),
          
                     onPressed:(){
                       Navigator.of(context).pushNamed(page);
                     }
               ) );
    }
 @override
    void initState() {
  
      super.initState();
      controller = new TabController(vsync:  this ,length: 3);
    }
    @override
      void dispose() {
       controller.dispose();
        super.dispose();
      }
  @override
  Widget build( BuildContext context){
    return new Scaffold(
     key: todayKey,
      appBar: new AppBar(
        leading:  IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: null,
              ),
        
        backgroundColor: Colors.red, 
        title: new Text("Today"),
        actions: <Widget>[
         
              
           IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new today.Today()))
              ), ]
      ),
      body: new  RefreshIndicator(
        onRefresh: () async{
          await new Future.delayed(const Duration(seconds: 1));
          setState(() {
                      
                    });
        },
              child: new Container(
          color: Colors.grey[850],
          child:  new Padding(
          padding: EdgeInsets.all(10.0),
          child:  new ListView(
          itemExtent: 70.0,
            shrinkWrap: true,
            children: <Widget>[
            field("        63 Kg ","assets/weight.png","/weight"),
             field("        0 litre", "assets/water.png" ,"/water"),
             field("        0 kcal", "assets/plate.png","/diary"),
             field("        855 kcal","assets/cal.png","/diary"),
             field("        11 Hours 33 Minutes","assets/lit.png","/sleep"),
             field("        No measurement","assets/heart.png","/heart"),
             field("        0 Km","assets/track.png","/track"),
            ],
          )
          ),
        ),
      ),
      );
        }
}


import 'package:appv1/pages/sleep/sleepModels.dart';
import 'package:flutter/material.dart';

import 'package:appv1/model/drawer.dart';

class Heart extends StatelessWidget{
  final scaffkey = GlobalKey<ScaffoldState>();
 
  
  //List<SleepItem> list =[Sleep(dateTime: "2018/07/07 08:00",target: "08:00",score: "100/100",debt: "30min",mood: true,timeSlept: "8 hours"),SleepItem(dateTime: "2018/07/09 08:00",target: "09:00",score: "90/100",debt: "45min",mood: true,timeSlept: "7hours"),];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
          body: new Scaffold(
            key: scaffkey,

        appBar: new AppBar(
          
          backgroundColor: Colors.red, 
          title:new Text("Heart Rate"),
           actions: <Widget>[
            new DrawerHeader(child: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: ()=>scaffkey.currentState.openEndDrawer()
        )
        ),
                ]
        ),
        drawer: leftDrawer(context,),
        endDrawer: rightDrawer(context),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: Header(
                minExtent: 40.0,
                maxExtent: 160.0,
              ),
            ),
             SliverFixedExtentList(
            
            itemExtent: 150.0,
            delegate: SliverChildBuilderDelegate(
             (BuildContext context,int index  ) {
               return
              
                  new Container(
                      //padding:EdgeInsets.all(3.0),
                alignment: Alignment.center,
                     
                child: new Card(
                    color: Colors.grey[750],    
                    child:Padding(
                      padding: EdgeInsets.all(10.0),
                     child: new Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                 Text( "01-08-2018 11:54" ,   
                 //date     
                style: TextStyle(fontSize: 17.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),]),
                          ),
                          Padding(
                             padding: EdgeInsets.all(5.0),
                             child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Text(
               "Measuring type" ,        
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600] ,),
            ),
             Text(//rate
               "92 bpm" ,        
                style: TextStyle(fontSize: 20.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),],
                            ),
                          ),
           Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
              Text(
                 "General" ,        
                  style: TextStyle(fontSize: 14.0, color: Colors.white ,),
              ),

                              ],
                            ),
           ),
                           
         
       ], ),
                    ),),
        );},
              childCount: 1,
            ),
          ),
          ],

        ),
        ),
    );
    }
}
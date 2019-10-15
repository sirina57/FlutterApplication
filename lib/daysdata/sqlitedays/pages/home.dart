
import 'dart:async';

import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/daysdata/sqlitedays/pages/grisList.dart';
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';

import 'package:appv1/login/sqliteLogin/loginModel.dart';

import 'package:appv1/model/drawer.dart';
import 'package:appv1/pages/healthCalculator.dart';
import 'package:appv1/screens/moadingIndic.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

class Home extends StatefulWidget
{
@override
 _HomeState createState() => new _HomeState();
}
class _HomeState extends State<Home> with SingleTickerProviderStateMixin { 
  final homeScaffKey = GlobalKey<ScaffoldState>();
 bool isLoading =false;

Future<List<DayDiary>> fetchDaysFromDatabase() async {
  var dbHelper = AppDatabase();
  Future<List<DayDiary>> days = dbHelper.getDays();

  setState(() {
      isLoading=true;
    });
  return days;
}

  TabController controller;
   @override
    void initState() {
  
      super.initState();
      controller = new TabController(vsync:  this ,length: 1);
    }

    @override
      void dispose() 
      {
       controller.dispose();
      
        super.dispose();
        }
   
  @override
  Widget build(BuildContext context) {
  
    return 
         ScopedModel<LoginModel>(
            model: LoginModel(),
            child: ScopedModel<DayModel>(
            model: DayModel(),
            child:
        Scaffold(
        // menu desplayed to the side (my account ...)
       drawer: /**ScopedModelDescendant<LoginModel>(
              builder: (context, child, model) => 
             
               MenuDrawer(user:model.currentUser,context: context,)
               
             
        ),  */SafeArea(child: leftDrawer(context)),
         endDrawer: rightDrawer(context),
         appBar: AppBar(
             title: Text("Overview :"),
                 
                     actions: <Widget>[
                     new DrawerHeader(
                    margin: EdgeInsets.only(bottom: 30.0),
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
                    child: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () => homeScaffKey.currentState.openEndDrawer()
            )
              ),
                  ],
                  backgroundColor:Colors.red,
         ),
         
           
           body: ScopedModelDescendant<DayModel>(
                builder: (context, child, model) => 
               FutureBuilder<List<DayDiary>>(
              future: fetchDaysFromDatabase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return 
          TabBarView(
              controller:  controller,
             children: <Widget>[
               // pages
                MyDaysList(day:snapshot.data[0],index: Key('_0_'),),
           //  MyDaysList(day:snapshot.data[1],index:  Key('_1_'),),
            //  MyDaysList(day:snapshot.data[2],index:  Key('_2_'),),
        
             ]
            );}
            else{
              return LoadingIndicator();
            }
            }
            )
            )
         )
        ),
      );
   
   
  }
    }
  
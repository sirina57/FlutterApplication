import 'package:appv1/animation/logo.dart';
import 'package:appv1/daysdata/sqlitedays/pages/home.dart';

import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/pages/water/addWaterContract.dart';
import 'package:appv1/pages/water/dbHelper.dart';
import 'package:appv1/pages/water/water.dart';
import 'package:flutter/material.dart';
import 'package:appv1/model/drawer.dart';

import 'package:scoped_model/scoped_model.dart';

class Wateradder extends StatelessWidget{
  final bool condition;
  //AddDayPagePresenter _presenter;
  Wateradder({Key key, @required this.condition}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  
  return Container(
    width: MediaQuery.of(context).size.width,
    child:condition ? LogoApp() : SizedBox(
                height: 35.0,
                width: 350.0,
               child: Container(
                 color: Colors.transparent,
               ),
             )
  );
  }

}
        

class WaterHome extends StatelessWidget implements AddWaterPageContract{
final Water mywater;
final Key index;
  //AddDayPagePresenter _presenter;
  WaterHome({Key key, @required this.mywater,this.index}) : super(key: key);
int _intake;

final scaffkey = GlobalKey<ScaffoldState>();
 @override
  Widget build(BuildContext context) {
 
      return ScopedModel<WaterModel>(
        model: WaterModel(),
        child: Scaffold(
        key: scaffkey,
        drawer: leftDrawer(context),
        appBar:AppBar(
     leading: IconButton(
     icon: Icon(Icons.arrow_back) ,
     onPressed:null,
   ),
        title: new Text("Water"),
         actions: <Widget>[
         /** new DrawerHeader(
        child: Icon(Icons.mode_edit),
      ), */
      DrawerHeader(
        child: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: ()=>scaffkey.currentState.openEndDrawer()
        )
      ),
              ],
        backgroundColor: Colors.red,
        bottom: PreferredSize(
             preferredSize:Size(300.0,100.0),
                  child: ListTile(
                 contentPadding: EdgeInsets.all(10.0),
               
               title: Center(
             child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                     children: <Widget>[
                      Row(children: <Widget>[
                        Text("      Ideal Water Intake            ",
                      //carte.minimum,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                    ),
                     Text("                      Goal Water Intake",
                      //carte.minimum,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                    ),
                      ]
                      ),
                      Row(children: <Widget>[
                          Text("          205 Litre",
                      //carte.minimum,
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                Text("                                 2.05 Litre",
                      //carte.minimum,
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                        ]  )
                     ],
                 ),
                  ),
                              ),
               ),
  ),
        ),
        ),
  
       
  endDrawer: rightDrawer(context),
body: ScopedModel<WaterModel>(
                model: WaterModel(),
                child:  Column(
  mainAxisAlignment: MainAxisAlignment.end,
  
         children: <Widget>[
           
  new Container(
   padding: EdgeInsets.all(4.0),
   
    child:ScopedModelDescendant<WaterModel>(
      builder: (context, child, model) => Column(
    mainAxisSize: MainAxisSize.min,
      children: <Widget>[
      
    Wateradder(condition:mywater.intake>= 2500),
    Wateradder(condition:mywater.intake>=2250),
    Wateradder(condition:mywater.intake>=2000),
    Wateradder(condition:mywater.intake>=1750),
    Wateradder(condition:mywater.intake>= 1500),
    Wateradder(condition:mywater.intake>= 1250),
    Wateradder(condition:mywater.intake>= 1000),
    Wateradder(condition:mywater.intake>= 750),
    Wateradder(condition:mywater.intake>= 500),
    Wateradder(condition:mywater.intake>= 250),
 
         
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
             
              ScopedModelDescendant<UserModel>(
            builder: (context, child, userModel) =>FlatButton(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                         new Image.asset(
                     "assets/water.png",
                     height: 25.0,
                     width: 25.0,
                     color: Colors.white,),
           
                      Text("250 ml"),
                      Text(mywater.intake.toString())
                    ],
                  ), 
                  onPressed: (){
                   model.increment(mywater, 250);
                   _intake= mywater.intake;
                   userModel.currentUser.intake=mywater.intake;
              },
              ),
                ),
             
              
             
            ],
          )
        
      ],
    ),

  ) ,
)])),

 floatingActionButton:  ScopedModelDescendant<WaterModel>(
              builder: (context, child, model) =>  FloatingActionButton(
      
          onPressed: (){   
       Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>Home()));
      model.intake=_intake;
             },
       child: new Icon(Icons.done,size: 30.0,),
          backgroundColor: Colors.green,
        ),
 ),
  
      
     ));
  }

  @override
  void onAddError(String error) {
    // TODO: implement onAddError
  }

  @override
  void onAddSuccess(Water water) {
    // TODO: implement onAddSuccess
  }

}

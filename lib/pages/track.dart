
import 'package:flutter/material.dart';
import 'package:appv1/model/drawer.dart';

class Tracker extends StatelessWidget{
  final scaffkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
     
    return new Scaffold(
      key: scaffkey,
      appBar: new AppBar(
        
        backgroundColor: Colors.red, 
        title:new Text("Track"),
         actions: <Widget>[
          new DrawerHeader(child: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: ()=>scaffkey.currentState.openEndDrawer()
        )
      ),
              ]
      ),
      drawer:leftDrawer(context,),
      endDrawer: rightDrawer(context),
      body:CustomScrollView(
        slivers: <Widget>[
          /**fEWaterlist([
          new Image.asset(
            'assets/water.png',
            height: 30.0,
            width: 30.0,
            color: Colors.white),
             Text(
                'Water intake',        
                style: TextStyle(fontSize: 17.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
             Text(
                "0 Litre",        
                style: TextStyle(fontSize: 12.0, color: Colors.white),
            ),
             Text(
            "2.05 left",        
                style: TextStyle(fontSize: 12.0, color: Colors.white),
            ),

            ]
          ) */
        ],
      ),
      
      

    );
  }

}

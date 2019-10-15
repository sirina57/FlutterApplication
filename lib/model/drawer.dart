
import 'package:appv1/google_sign_in/homepage.dart';
import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';

import 'package:appv1/login/sqliteLogin/loginModel.dart';

import 'package:appv1/login/sqliteLogin/pages/loginaddUser.dart';

import 'package:appv1/pages/healthCalculator.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


final drawerKey = GlobalKey<ScaffoldState>();
  
String url ="https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg";
 Drawer leftDrawer(BuildContext context,) {
   return Drawer(   
     child:
        ScopedModelDescendant<LoginModel>(
              builder: (context, child, loginmodel) =>  ScopedModelDescendant<UserModel>(
              builder: (context, child, model) => ListView(
               children: <Widget>[

                new UserAccountsDrawerHeader(
                   accountEmail: Text(model.currentUser.email ),
                   accountName:  Text(model.currentUser.username ),
                   currentAccountPicture:
                     new GestureDetector
                     (child:  new CircleAvatar
                       (
                       backgroundImage: new NetworkImage("https://scontent.ftun6-1.fna.fbcdn.net/v/t1.0-9/22090023_1622046531173669_7059101739102756733_n.jpg?_nc_cat=0&oh=081efb3179136020c941746667b3cbd5&oe=5BD3D2C0"),
                       ),
                        onTap: () => print(" This is The Current Account. "),
                     ),
                  
                         
                   decoration: new BoxDecoration(
                     image: new DecorationImage(
                       image: new NetworkImage(url),
                        fit: BoxFit.fill
                     )
                   ),
                   ),
              new ListTile(
                leading: new Icon(Icons.home) ,
                   title: new Text("Overview"),
                    onTap: ()
                   {
                   Navigator.pop(context);
                   Navigator.of(context).pushNamed( "/overview");
                   }
              ),

        new ListTile(
                   leading: new Image(image: new AssetImage("assets/goals.png"),width: 30.0,height: 30.0,color: Colors.white),
                  // trailing: new Icon(icon),
                    title:  new Text("Goals"),
                   onTap: () {
                   
                    Navigator.of(context).pushNamed("/goals");
                    //router.navigateTo(context,route);

                   },
       ),
        new ListTile(
                   leading: new Image(image: new AssetImage("assets/weight.png"),width: 30.0,height: 30.0,color: Colors.white),
                  // trailing: new Icon(icon),
                    title:  new Text("Weight"),
                   onTap: () {
                   
                    Navigator.of(context).pushNamed("/weight");}),

             new ListTile(
                   leading: new Image(image: new AssetImage("assets/lit.png"),width: 30.0,height: 30.0,color: Colors.white),
                  // trailing: new Icon(icon),
                    title:  new Text("Sleep"),
                   onTap: () {
                   
                    Navigator.of(context).pushNamed("/sleep");
                    //router.navigateTo(context,route);

                   },
               ),
        new ListTile(
                   leading: new Image(image: new AssetImage("assets/diary.png"),width: 30.0,height: 30.0,color: Colors.white),
                  // trailing: new Icon(icon),
                    title:  new Text("Diary",),
                   onTap: () {
                   
                    Navigator.of(context).pushNamed("/diary");
                   

                    //router.navigateTo(context,route);

                   },
              ),
               new ListTile(
                   leading: new Image(image: new AssetImage("assets/heart.png"),width: 30.0,height: 30.0,color: Colors.white),
                  // trailing: new Icon(icon),
                    title:  new Text("Heart rate"),
                   onTap: () {
                   
                    Navigator.of(context).pushNamed("/heart");
                    //router.navigateTo(context,route);

                   },
              ),
               new ListTile(
                   leading: new Image(image: new AssetImage("assets/track.png"),width: 30.0,height: 30.0,color: Colors.white),
                  // trailing: new Icon(icon),
                    title:  new Text("Route Tracker"),
                   onTap: () {
                   
                    Navigator.of(context).pushNamed("/track");
                    //router.navigateTo(context,route);

                   },
              ),
              
              new ListTile(
                   leading: new Image(image: new AssetImage("assets/track.png"),width: 30.0,height: 30.0,color: Colors.white),
                  // trailing: new Icon(icon),
                    title:  new Text("health"),
                   onTap: () {
                   
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Health()));
                    //router.navigateTo(context,route);

                   },
                  ),
                  
                  new Divider(),
                  SignOutBtn(),
                  
                 new ListTile(
                   title: new Text("Deconnect"),
                   trailing: new Icon(Icons.exit_to_app),
                   onTap: () {
                  // model.deleteItem(loginmodel.items[loginmodel.items.length]);
                  
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LoginPage()));
                    //router.navigateTo(context,route);
}
                 ),
                 new Divider(),
                 new ListTile(
                   title: new Text("Cancel"),
                   trailing: new Icon(Icons.cancel),
                   onTap: () => Navigator.pop(context),
                 ),
               ],
             ),
           ),
         ),
       
   );}




 Drawer rightDrawer(BuildContext context) {
   var time= TimeOfDay.now();
    return  new Drawer(
        child: SafeArea(
          child: ScopedModelDescendant<UserModel>(
              builder: (context, child, model) =>ListView(
              itemExtent: 100.0,
             children: <Widget>[
                        new Card(
                      color: Colors.grey[750],    
                      child:new Stack(
                      fit: StackFit.loose,
                        
                        children: [
              Positioned(
                width: 80.0,
                height: 60.0,

                left: 25.0,
                top: 10.0,
                child: Text("Water Intake",
                  //carte.minimum,
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ),
               Positioned(
                left: 35.0,
                top: 40.0,
                child: Text(
                "Water Intake",
                  style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                ),
              ),
               Positioned(
            
                left: 35.0,
              bottom: 10.0,
                child: Text( model.currentUser.intake.toString() +" mL",
                 //carte.average,        
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ),
               Positioned(
            
               right: 15.0,
               top: 10.0,
                child: Text(
                time.hour.toString()+' : '+ time.minute.toString(),        
                  style: TextStyle(fontSize: 17.0, color: Colors.white),
                ),
              ),
               Positioned(
            
              right: 35.0,
              top:40.0,
                child: Text("Goal water intake",
                // carte.debt,        
                  style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                ),
              ),
               Positioned(
            
                right: 40.0,
              bottom:10.0,
                child:
                 Text(
                   "2.05 Litre",
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ),
                        ]
                      ),
    ),
               ]
                 ),
          ),
                  ),
      );}
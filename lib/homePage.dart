/**

import 'package:appv1/login/inheritWidget.dart';

import 'package:appv1/pages/healthCalculator.dart';
import 'package:flutter/material.dart';

import './others/myVariables.dart';
import 'model/drawer.dart';

import './today.dart' as today; 
import './tomorow.dart' as tomorrow;
import './yesterday.dart' as yesterday ;



class Home extends StatefulWidget
{
  final  String name ;
  final String email ;
  

  const Home({Key key, this.name, this.email}) : super(key: key);

@override
 _HomeState createState() => new _HomeState();
}
class _HomeState extends State<Home> with SingleTickerProviderStateMixin { 
  final scaffkey = GlobalKey<ScaffoldState>();
  TabController controller;

  var txtkey;
  // change account pic
  void switchAccounts()
   {
    String picBackup =currentProfilePic;
    this.setState(()
    {
       currentProfilePic = otherProfilePic;
      otherProfilePic =picBackup;
    }
    );
  }
   @override
    void initState() {
  
      super.initState();
      controller = new TabController(vsync:  this ,length: 3);
    }

    @override
      void dispose() 
      {
       controller.dispose();
      
        super.dispose();
        }

        // drawer options 
ListTile menuOpton(String title, String image ,String route ) {
   return  new ListTile(
             leading: new Image(image: new AssetImage(image),),
            // trailing: new Icon(icon),
              title:  new Text(title),
             onTap: () {
             
              Navigator.of(context).pushNamed(route);
              //router.navigateTo(context,route);

             },
           );}
   
        
  @override
  Widget build(BuildContext context) {
    final login = Login.of(context);
    var myMenuScaffold = new Scaffold(
      key: scaffkey,

      appBar: new AppBar(
        
        backgroundColor: Colors.red, 
        title: new Text("Overview"),
         actions: <Widget>[
          new DrawerHeader(child: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: ()=>scaffkey.currentState.openEndDrawer()
        )
      ),
              ],
      ),

      // menu desplayed to the side (my account ...)
     drawer:  Drawer(     
       child: new ListView(
         children: <Widget>[

          new UserAccountsDrawerHeader(
             accountEmail: new Text( widget.email ?? "sirinamaaref@gmail.com",
               ),
             accountName: new Text( widget.name ?? "sirin maaref",
             ) ,
             currentAccountPicture:
               new GestureDetector
               (child:  new CircleAvatar
                 (
                 backgroundImage: new NetworkImage("https://scontent.ftun6-1.fna.fbcdn.net/v/t1.0-9/22090023_1622046531173669_7059101739102756733_n.jpg?_nc_cat=0&oh=081efb3179136020c941746667b3cbd5&oe=5BD3D2C0"),
                 ),
                  onTap: () => print(" This is The Current Account. "),
               ),
            
             otherAccountsPictures:
              <Widget>[
               new GestureDetector
               ( child: new CircleAvatar( child:  new Icon(Icons.switch_camera),
                  backgroundImage: new NetworkImage("https://yt3.ggpht.com/-2_2skU9e2Cw/AAAAAAAAAAI/AAAAAAAAAAA/6NpH9G8NWf4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg"),
                  ),
              onTap:  login.onTap,
             ),
             ],         
             decoration: new BoxDecoration(
               image: new DecorationImage(
                 image: new NetworkImage("https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
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
           new ListTile(
             title: new Text("Cancel"),
             trailing: new Icon(Icons.cancel),
             onTap: () => Navigator.pop(context),
           ),
         ],
       ),
     ),
     body: /* StoreConnector<AppState, dynamic>(
      converter: (store) => store.state,
      builder: (context, list) =>*/ new TabBarView(
          controller:  controller,
         children: <Widget>[
           // pages
          new yesterday.Yesterday(),
           new today.Today(),
           new tomorrow.Tomorrow() 
         ],
        ),
    
       endDrawer:rightDrawer(context) );
    // my main page :scaffold
        return myMenuScaffold;

  
  }
    }  */
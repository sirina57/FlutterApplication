import 'package:flutter/material.dart';

 
 
// drawer options 
ListTile menuOpton(String title, String image ,String route,BuildContext context ) {
   return  new ListTile(
             leading: new Image(image: new AssetImage(image)),
            // trailing: new Icon(icon),
              title:  new Text(title),
             onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(route);
             },
           );}

 Positioned pos(double l,double t ,String text,IconData icon){
     return Positioned(
          left: l,
          top: t,
          child: Text(
            text,
            style: TextStyle(fontSize: 25.0, color: Colors.white),
            
          ),
        );
   
   }

//side menu
 String currentProfilePic ="https://yt3.ggpht.com/-2_2skU9e2Cw/AAAAAAAAAAI/AAAAAAAAAAA/6NpH9G8NWf4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg";
  String otherProfilePic ="https://yt3.ggpht.com/-2_2skU9e2Cw/AAAAAAAAAAI/AAAAAAAAAAA/6NpH9G8NWf4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg";



TabBar tab = new TabBar(
        // controller: ,
         tabs: <Tab>[
           new Tab(text: "History",),
             new Tab(text: "History",
           )

         ],
       );
 /* 
 background: new Image.asset(
                  "img.jpg",
                  fit: BoxFit.cover,
 
 
 new Container(
            color: Colors.black45,
          
            
         child:new  Row(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
     new Icon(Icons.fastfood ,size: 30.0,color: Colors.white,),

      new Text("food",textAlign: TextAlign.center,style: new TextStyle(
      fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white
     ),),
       IconButton(
      icon: new Icon(Icons.add, size: 20.0,color: Colors.white,),
      alignment: Alignment.centerRight,
      ),
      
      ],

  )  ),
  Row diaryButtons( String title,IconData icon ){
    return Row(
      
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
     new Icon(Icons.fastfood ,size: 20.0,),

      new Text(title,textAlign: TextAlign.center,style: new TextStyle(
      fontSize: 20.0
     ),),
       IconButton(
      icon: new Icon(icon, size: 20.0,),
      alignment: Alignment.centerRight,
      ),
      
      ],

    
    
     
      
    
    
    
    );
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  class Home extends StatefulWidget
{

@override
 _HomeState createState() => new _HomeState();

}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  String currentProfilePic ="https://yt3.ggpht.com/-2_2skU9e2Cw/AAAAAAAAAAI/AAAAAAAAAAA/6NpH9G8NWf4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg";
  String otherProfilePic ="https://yt3.ggpht.com/-2_2skU9e2Cw/AAAAAAAAAAI/AAAAAAAAAAA/6NpH9G8NWf4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg";
  
  TabController controller;

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

   ListTile menuOpton(String title, IconData icon ,String route ) {
   return  new ListTile(
            
             trailing: new Icon(icon),
              title:  new Text(title),
             onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(route);
             },
           );}
  
      ListTile option( String title,IconData icon ,)
      {
        return ListTile(
             title:  new Text("Diary"),
             trailing: new Icon(Icons.book),
             onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new Diary() )
              
              );}
              );
             }
          
             
          
  
  @override
  Widget build(BuildContext context) {
    var myMenuScaffold = new Scaffold(

      appBar: new AppBar(
        
        backgroundColor: Colors.red, 
        title: new Text("Overview"),
      ),

      // menu desplayed to the side (my account ...)
     drawer: new Drawer(
      
       child: new ListView(
         children: <Widget>[

          new UserAccountsDrawerHeader(
             accountEmail: new Text("sirinamaaref@gmail.com"),
             accountName: new Text("sirine maaref") ,
             currentAccountPicture:
               new GestureDetector
               (
                 child:  new CircleAvatar
                 (
                 backgroundImage: new NetworkImage("https://scontent.ftun6-1.fna.fbcdn.net/v/t1.0-9/22090023_1622046531173669_7059101739102756733_n.jpg?_nc_cat=0&oh=081efb3179136020c941746667b3cbd5&oe=5BD3D2C0"),
                 ),
                  onTap: () => print(" This is The Current Account. "),
               ),
            
             otherAccountsPictures:
              <Widget>[
               new GestureDetector
               ( child: new CircleAvatar( child:  new Icon(Icons.switch_camera),
                  backgroundImage: new NetworkImage(otherProfilePic),
                  ),
              onTap: () => switchAccounts(),
           
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
            
             trailing: new Icon(Icons.home),
              title:  new Text("Overview"),
             onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new Overview()));
             },
           ),

          new ListTile(
             title:  new Text("Diary"),
             trailing: new Icon(Icons.book),
             onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new Diary() ));
          
           },
           ),
           
           new ListTile(
             title:  new Text("Weight"),
             trailing: new Icon(Icons.linear_scale),
             onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new Weight()));
          
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
      )
      ,
      body: new TabBarView(
        controller:  controller,
       children: <Widget>[
         // pages
         new yesterday.Yesterday(),
         new today.Today(),
         new tomorrow.Tomorrow()
        
       ],

      

      ),

      
    );

    // my main page :scaffold
    return myMenuScaffold;
  }}*/
/*
 new ListTile(
             leading: new Image(image: new AssetImage("assets/goals.png")),
            // trailing: new Icon(icon),
              title:  new Text("Goals"),
             onTap: () {
             
              Navigator.of(context).pushNamed("/goals");
              //router.navigateTo(context,route);

             },
     ),
       new ListTile(
             leading: new Image(image: new AssetImage("assets/lit.png")),
            // trailing: new Icon(icon),
              title:  new Text("Sleep"),
             onTap: () {
             
              Navigator.of(context).pushNamed("/sleep");
              //router.navigateTo(context,route);

             },
         ),
      new ListTile(
             leading: new Image(image: new AssetImage("assets/diary.png")),
            // trailing: new Icon(icon),
              title:  new Text("Diary"),
             onTap: () {
             
              Navigator.of(context).pushNamed("/diary");
              //router.navigateTo(context,route);

             },
        ),
        

        /*menuOpton("Weight", "assets/weight.png","/weight",context ),
        ListTile menuOpton(String title, String image ,String route ) {
   return  new ListTile(
             leading: new Image(image: new AssetImage(image)),
            // trailing: new Icon(icon),
              title:  new Text(title),
             onTap: () {
             
              Navigator.of(context).pushNamed(route);
              //router.navigateTo(context,route);

             },
   );*/ */


 //body cards 
   Card card = new Card(
              color: Colors.grey[750],    
              child:new Stack(
                fit: StackFit.expand,
                children: [
                   Container(
         
        ),
        Positioned(
          left: 10.0,
          top: 14.0,
          child: Text(
            'Hero Image',
            style: TextStyle(fontSize: 25.0, color: Colors.white),
          ),
        ),
         Positioned(
      
          left: 10.0,
         bottom: 40.0,
          child: Text(
            'Sleep score',        
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
        Positioned(
      
          left: 130.0,
         bottom: 16.0,
          child: Text(
            'debt',        
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
        Positioned(
      
          left: 120.0,
         bottom: 40.0,
          child: Text(
            'Sleep Debt',        
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
        Positioned(
      
          left: 40.0,
         bottom: 16.0,
          child: Text(
            'score',        
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
        Positioned(
         
          right: 16.0,
          bottom: 16.0,
          child: SafeArea(
           child:  Image.asset(
          'assets/smile.png',
          height: 30.0,
          width: 30.0,)
          ),
        ),
         Positioned(
         
          right: 16.0,
          top: 16.0,
         child: Text(
            'date',        
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
        
         new Divider( color: Colors.grey[600],),
             
               ],
            ),
          );

  //header stack 
  Stack s= new Stack(
      fit: StackFit.expand,
      children: [
        //background image
        Image.asset(
          'assets/red.png',
         fit: BoxFit.cover,
        ),
        //shade behind pic
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        //title 
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            'Sleep',
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
        ),
      ],
     
      );
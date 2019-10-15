/**import 'package:flutter/material.dart';
import 'package:sliver_fab/sliver_fab.dart';
import '../others/History.dart' as h;
import '../pages/Trends.dart'as t;
class Sleep extends StatefulWidget{
  @override
  SleepState createState() => new SleepState();}
class SleepState extends State<Sleep> with SingleTickerProviderStateMixin{
  final String title;
   TabController controller ;
   @override
  void initState(){
    super.initState();}

Card field(String title,TextEditingController controller,IconData icon ,String result ) {
       return new Card(
         //shape: Border.all(color: Colors.grey[850], style: BorderStyle.solid),
         color: Colors.grey[700],    
              child:new Column(
                children: <Widget>
              [
                // icon + title +button 
               new  ListTile(
                 
                  leading: new Text("date",style: new TextStyle(color: Colors.white),),
                  title:   new Text("06:25",style: new TextStyle(color: Colors.white),),
               ),
              new Divider( color: Colors.grey[600],),
              
              ]
              )
              );
              }



  @override
  Widget build(BuildContext context) {
return  Scaffold(
  appBar: new AppBar(),
  body: new CustomScrollView(
  
        slivers: <Widget>[
  
          SliverAppBar(
  
            pinned: true,
  
            expandedHeight:120.0,

            flexibleSpace: FlexibleSpaceBar(
   title:new Text("Sleep"),
  
             background: new Card(
  
               margin: EdgeInsets.all(20.0),
  
              shape: Border.all(color: Colors.grey[850], style: BorderStyle.solid),
  
          
  
                 color:Colors.grey[850],    
  
                child:new Column(
  
                  mainAxisAlignment: MainAxisAlignment.center,
  
                  children: <Widget>
  
                [
  
               new Text("date",style: new TextStyle(color: Colors.white, fontSize: 30.0),),
  
               new Text("06:25",style: new TextStyle(color: Colors.white),),
  
              // new Divider( color: Colors.grey[600],),
  
                
  
                ]
  
                )
  
                ),
  
           
  
                ),
  
          
  
          ),
  
         SliverFixedExtentList(
  
            itemExtent: 40.0,
  
            delegate: SliverChildBuilderDelegate(
  
                  (BuildContext context, int index) {
  
                return Container(
  
                  alignment: Alignment.center,
  
              child: new Card(
  
           color: Colors.grey[700],    
  
                child:new Column(
  
                  children: <Widget>[
  
                 new  ListTile(   
  
                  leading: new Text(title,textAlign: TextAlign.center,style: new TextStyle( fontSize: 20.0 ,color: Colors.white ),),
  
                  title: new Text("data"),
  
                   trailing: new Icon(Icons.face, size: 30.0,),
  
                       onTap: (){}
  
                       ),
  
                new Divider( color: Colors.grey[600],),
  
                 ],
  
              ),
  
            ),
  
                );
  
                  }
  
            )
  
         )
  
         ]
  
          ),
);
        }
        } 

    /*  body:new Container(
        color: Colors.grey[850],
        child:  new Padding(
        padding: EdgeInsets.all(20.0),
        child: new ListView(
          shrinkWrap: true,
        children: <Widget>[

          new Card(
          
             color: Colors.grey[700],    
              child:new Column(
                children: <Widget>[
                  new Card(
         //shape: Border.all(color: Colors.grey[850], style: BorderStyle.solid),
         color: Colors.grey[700],    
              child:new Column(

                children: <Widget>
              [
                // icon + title +button 
               new  ListTile(
                 
                  leading: new Text("date",style: new TextStyle(color: Colors.white),),
                  title:   new Text("06:25",style: new TextStyle(color: Colors.white),),
               ),
              new Divider( color: Colors.grey[600],),
               new  ListTile(
                 
                  leading: new Text("date",style: new TextStyle(color: Colors.white),),
                  title:   new Text("06:25",style: new TextStyle(color: Colors.white),),
               ),
              new Divider( color: Colors.grey[600],),
               new  ListTile(
                 
                  leading: new Text("date",style: new TextStyle(color: Colors.white),),
                  title:   new Text("06:25",style: new TextStyle(color: Colors.white),),
               ),
              new Divider( color: Colors.grey[600],),
               new  ListTile(
                 
                  leading: new Text("date",style: new TextStyle(color: Colors.white),),
                  title:   new Text("06:25",style: new TextStyle(color: Colors.white),),
               ),
              new Divider( color: Colors.grey[600],),
            bottom:  new TabBar(
         controller: controller,
         tabs: <Tab>[
           new Tab(
             child: new FlatButton(
               color: Colors.green,
               child: new Text("HISTORY",style: new TextStyle( fontSize: 20.0 ,color: Colors.white ),),
               onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new h.History()))) ,
             ),
              new Tab(
             child: new FlatButton(
               color: Colors.green,
               child: new Text( "TRENDS",style: new TextStyle( fontSize: 20.0 ,color: Colors.white ),),
               onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new t.Trends()))) ,
                )]
                ),
                 
              
              
              ]
              )
              ),
                ],
         * field("Water Intake ", controller,Icons.watch_later,result[0]),  
           field("Breakfast", controller,Icons.free_breakfast,result[1]),
           field("Lunch", controller,Icons.face,result[2]),
           field("Snacks", controller,Icons.airplanemode_active,result[3]),
           field("Dinner", controller,Icons.add,result[4]),
           field("Activity", controller,Icons.add,result[5]),
                ], 
          new Row(
          children: <Widget>[
            new Text("minimum"),
            new Text("average"),
            new Text("maximum"),
          ],),
           new Row(
          children: <Widget>[
            new Text("minimum"),
            new Text("average"),
            new Text("maximum"),
          ],),])),

     new Card(
         //shape: Border.all(color: Colors.grey[850], style: BorderStyle.solid),
         color: Colors.grey[700],  
         child: new Column(
           children: <Widget>[
             new Text("minimum"),
            new Text("average"),
            new Text("maximum"),
           ],

         ),
      )
     ]
      ) 
      )));
    }
}*/
 */
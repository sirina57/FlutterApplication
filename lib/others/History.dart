 import 'package:flutter/material.dart';
 class History extends StatefulWidget{
@override
HistoryState createState() => new HistoryState();
}
class HistoryState extends State<History> with SingleTickerProviderStateMixin{
 
 @override
    void initState() {
  
      super.initState();
    }


   Card field(String title, String date ,IconData icon ) {
       return new Card(
         color: Colors.grey[700],    
              child:new Column(
                children: <Widget>[
               new  ListTile(   
                leading: new Text(title,textAlign: TextAlign.center,style: new TextStyle( fontSize: 20.0 ,color: Colors.white ),),
                title: new Text("data"),
                 trailing: new Icon(icon, size: 30.0,),
                     onTap: (){}
                      // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new SearchFood() ));}
                     ),
                   new Divider( color: Colors.grey[600],),
               ],
            )
            );}
  @override
  Widget build( BuildContext context){
    return new Scaffold(
      body: new Container(
        color: Colors.grey[850],
        child:  new Padding(
        padding: EdgeInsets.all(20.0),
        child:  new ListView(
          shrinkWrap: true,
          children: <Widget>[
           field("date", "11/11/1995" ,Icons.face ),  
          field("date", "11/11/1995" ,Icons.face ),
           field("date", "11/11/1995" ,Icons.face ),
            field("date", "11/11/1995" ,Icons.face ),

          
          ],
        )    
      ),
 )
    );
 }
}
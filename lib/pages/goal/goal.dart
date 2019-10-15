
import 'package:appv1/daysdata/sqlitedays/pages/home.dart';
import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/model/drawer.dart';
import 'package:appv1/pages/goal/inheritGoalWeight.dart';
import 'package:appv1/pages/water/waterHome.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



class Goal extends StatefulWidget {
 final String weight;
 final String goalWeight;

const Goal( {this.weight, this.goalWeight,Key key,}) : super(key: key);

  @override
  _WeightState createState() => _WeightState();
}

class _WeightState extends State<Goal> {
   final goalScaff = GlobalKey<ScaffoldState>();
 
   String w='63';
   String gw ='60';

  @override
  Widget build(BuildContext context) {
    final edited =EditWeight.of(context);  
     

              
//var oldscaff=
return 
Scaffold(
      key: goalScaff ,
     
       endDrawer:rightDrawer(context),
     drawer: leftDrawer(context,),  
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                title: Text("Goal"),
                 actions: <Widget>[
    
              new DrawerHeader(
                margin: EdgeInsets.only(bottom: 30.0),
                padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
                child: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () => goalScaff.currentState.openEndDrawer()
        )
          ),
      ],
              backgroundColor:  Colors.red,
              expandedHeight: 210.0,
       titleSpacing: 1.0,
              pinned: true,
             
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
               background:
                       Container(
                         padding: EdgeInsets.all(30.0),
                         color: Colors.red,
                         child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ScopedModelDescendant<UserModel>(
                builder: (context, child, model) => Card(
            margin: EdgeInsets.only(top: 50.0),
           color: Colors.grey[750],    
                             child:Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.center,
                               
                               children : <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                    //1
                                  child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: <Widget>[
                                     Text("Calories",
                         
                           style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                         ), Text("Fat",
                             
                           style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                         ), ], ),
                                  ),
                            //2      
                         Padding(
                                    padding: EdgeInsets.all(2.0),
                             child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: <Widget>[
                                        Text(
                          model.calories().toString()+"Kcal",
                             style: TextStyle(fontSize: 15.0, color: Colors.white),
                         ),
                            Text(
                       "0 gm",
                             style: TextStyle(fontSize: 15.0, color: Colors.white),
                         ),],),
                        ),
                        //3
                        Padding(
                                    padding: EdgeInsets.all(2.0),child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: <Widget>[
                                       Text("Carbohydrates",        
                           style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                         ),
                                     
                          Text(
                          "Protein",
                           style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                         ),]),),
                         //4
                         Padding(
                                    padding: EdgeInsets.all(2.0),child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: <Widget>[
                                        Text(
                          " 0 gm",
                           style: TextStyle(fontSize: 15.0, color: Colors.white),
                         ),
                          Text(
                          "  0 gm",
                           style: TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                          ],

                      ),
                       ),
                      
                    ]
                  ),
    ),
        ),)),
     )),
      
       ];
       },
       
     
          body:Container(
            child: Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(10.0),
              color: Colors.grey[750],    
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
             Padding(
             padding: EdgeInsets.all(12.0), child: 
             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                     Text(
                "Weight Loss",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          
          GestureDetector(
            child:  CircleAvatar
            (child: Icon(Icons.edit ,color: Colors.white,),
            backgroundColor: Colors.transparent,),
        
        onTap: edited.onTap,
      ),
           
          ]),
              ),
            
         Padding(
                     padding: EdgeInsets.all(3.0), child: 
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
          Column(
            children: <Widget>[
             Text(
                  "Goal weight",        
                  style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
              ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    widget.goalWeight ??'60',      
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
                ),
              ]
          ),
            Column( 
              children: <Widget>[
            
                Text(
                  'Starting weight',        
                  style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
              ),
               Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Text(
                   widget.weight ?? '63',     
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
           ),
               )
               ,
              ],
            ),
             Column( 
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                  widget.weight ?? '63',      
                  style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold, color: Colors.white),
          ),
            ),
              ],
            ),
           
             
          ]),
          ),

          ],
              ),
          ),


          // water
           Card(
                  margin: EdgeInsets.all(10.0),
              color: Colors.grey[750],    
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
             Padding(
                     padding: EdgeInsets.all(10.0), child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   Text(
              'Water intake',        
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
           
          GestureDetector(
            child:  CircleAvatar
            (child: Icon(Icons.remove_red_eye ,color: Colors.white,),
            backgroundColor: Colors.transparent,),
        
        onTap:()=>  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Home())),
      ),
           
          ]),
              ),
         Padding(
                     padding: EdgeInsets.all(10.0), child: 
        Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
          Text(
              'Goal water intake',        
              style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
          ),
            
          ]),
          ),
           Padding(
           padding: EdgeInsets.all(15.0), child: 
        Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
          Text(
              "2.05 Litre",        
              style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),])),
         ],
              ),
          ),
              ],
            ),
          )
      )
      
    );
 
    
   }}

//main page for weight
import 'package:appv1/model/drawer.dart';
import 'package:appv1/pages/weight/sqliteweight/pages/list.dart';

import 'package:appv1/pages/weight/sqliteweight/pages/weightTrends.dart';
import 'package:appv1/pages/weight/sqliteweight/pages/largerExemple.dart';
import 'package:appv1/pages/weight/sqliteweight/weight.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

class WeightHome extends StatefulWidget
{
@override
 _HomeState createState() => new _HomeState();
}
class _HomeState extends State<WeightHome> with SingleTickerProviderStateMixin { 
  final scaffkey = GlobalKey<ScaffoldState>();
  TabController controller;
   @override
    void initState() {
  
      super.initState();
      controller = new TabController(vsync:  this ,length: 2);
    }

    @override
      void dispose() 
      {
       controller.dispose();
      
        super.dispose();
        }
   
  @override
  Widget build(BuildContext context) {
 
    var scaff = ScopedModel<WeightModel>(
      model: WeightModel(),
          child: Scaffold(
      
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // ~ appbar 
              SliverAppBar(
                title: Text("Weight Tracker :"),
               
                   actions: <Widget>[
                   new DrawerHeader(
                  margin: EdgeInsets.only(bottom: 30.0),
                  padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
                  child: IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => scaffkey.currentState.openEndDrawer()
          )
            ),
                ],
                //card in the background
                backgroundColor:Colors.red,
              expandedHeight: 220.0,
               titleSpacing: 0.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title:Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
              TabBar(
             isScrollable: true,
            controller: controller,
            tabs: [
              Tab(text: 'History'),
              Tab(text: 'Trends',)
            ],
  indicatorSize: TabBarIndicatorSize.label,
  indicator: new BubbleTabIndicator(
      indicatorHeight: 28.0,
      padding:EdgeInsets.only(bottom: 0.0,right: 10.0,left: 10.0,top: 0.0),
      //indicatorRadius: 50.0,
      indicatorColor: Colors.green,
      tabBarIndicatorSize: TabBarIndicatorSize.label,
  ),),], ),
                    
  background:Card(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.zero),
         color: Colors.red,
          margin: EdgeInsets.fromLTRB(4.0, 40.0, 4.0, 45.0),
          child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Card(
           margin: EdgeInsets.all(10.0),
           color: Colors.grey[750],    
                  child:
               ScopedModelDescendant<WeightModel>(
               builder: (context, child, model) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children : <Widget>[
                         Padding(
                          padding: EdgeInsets.only(top: 10.0,bottom: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                            Text("Minimum",
               
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ), Text("Maximum",
                  
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ), ], ),
                         ),
              Padding(
                           padding: EdgeInsets.all(2.0), child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                               Text(
             '63',
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
                 Text(
               '63',
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
              ), ], ),),

                 Padding(
                           padding: EdgeInsets.all(2.0),child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Average",
                      
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ),
                             
               Text(
             "Ideal Weight",
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ),]),
                        ),
                        
                Padding(
                           padding: EdgeInsets.all(2.0),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                               Text(
               '63',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
               Text(
                 '57.5',
            // model.average().toString(),
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
         
         body:new TabBarView(
            controller:  controller,
           children: <Widget>[
             // pages
         MyWeightList(),
         TrendsPage(),
         // HomePage(),
        //  DisplayPage()
           ]
          ),
        ),
       drawer: leftDrawer(context), 
       endDrawer: rightDrawer(context),
      ),
    );
       
   
         
    // my main page :scaffold
        return  ScopedModel<AppModel>(
        model: AppModel(),
        child:scaff);

  
  }
    }
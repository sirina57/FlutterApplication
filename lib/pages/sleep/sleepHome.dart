
import 'package:appv1/model/drawer.dart';
import 'package:appv1/pages/sleep/list.dart';
import 'package:appv1/pages/sleep/sleep.dart';
import 'package:appv1/pages/sleep/sleepTrends.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

class SleepHome extends StatefulWidget
{
@override
 _HomeState createState() => new _HomeState();
}
class _HomeState extends State<SleepHome> with SingleTickerProviderStateMixin { 
  final sleepScaff = GlobalKey<ScaffoldState>();
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
  
    var scaff = Scaffold(
    
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              
               title: Text("Sleep Tracker :"),
             
                 actions: <Widget>[
                 new DrawerHeader(
                margin: EdgeInsets.only(bottom: 30.0),
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                child: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () => sleepScaff.currentState.openEndDrawer()
        )
          ),
              ],
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
  ),
), ],),
                  
 background:ScopedModelDescendant<SleepModel>(
            builder: (context, child, model) => Padding(
              padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                          child: Card(
                            margin: EdgeInsets.all(20.0),
                  color: Colors.grey[750],    
                  child:new Stack(
                    fit: StackFit.expand,
                    children: [
          Positioned(
              width: 80.0,
              height: 60.0,

              left: 35.0,
              top: 15.0,
              child: Text("Minimum",
                //carte.minimum,
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ),
          ),
           Positioned(
              left: 35.0,
              top: 30.0,
              child: Text(
           model.min.hour.toString()+':'+model.min.minute.toString(),
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
          ),
           Positioned(
        
              left: 125.0,
           top: 15.0,
              child: Text("Average",
               //carte.average,        
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ),
          ),
           Positioned(
        
              left: 130.0,
           top: 30.0,
              child: Text(
            model.average.hour.toString()+':'+model.average.minute.toString(),     
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
          ),
           Positioned(
        
              right: 40.0,
          top:15.0,
              child: Text("Maximum",
              // carte.debt,        
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ),
          ),
           Positioned(
        
              right: 40.0,
          top:30.0,
              child:
               Text(
                 model.max.hour.toString()+':'+model.max.minute.toString(),
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
          ),
           Positioned(
        
              left: 55.0,
           bottom: 30.0,
              child: Text("Sleep score",
              //carte.score,        
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ),
          ),
           Positioned(
        
              left: 60.0,
           bottom: 10.0,
              child: Text(
           model.averageScore.toString(),      
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
          ),
           Positioned(
        
           right: 60.0,
           bottom: 30.0,
              child: Text("Sleep debt",
              // carte.maximum,       
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ),
          ),
          Positioned(
        
           right: 70.0,
           bottom: 10.0,
              child: Text(
                '__',      
                style: TextStyle(fontSize: 15.0, color: Colors.white),  ),
          ),
                    ]
                  ),
    ),
            ),
             
    ),)
     
      
            )];
       },
       
       body:new TabBarView(
          controller:  controller,
         children: <Widget>[
      MySleepList(),
      TrendsPage()
         ]
        ),
      ),
     drawer: leftDrawer(context,), 
     endDrawer: rightDrawer(context),
    );
       
   
         
    // my main page :scaffold
        return  ScopedModel<SleepModel>(
        model: SleepModel(),
        child:scaff);

  
  }
    }
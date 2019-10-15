import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class HeaderModel implements SliverPersistentHeaderDelegate {
  HeaderModel({
    this.minExtent,
    this.maxExtent,
  });
  double maxExtent;
  double minExtent;

  Card  card(){
        
final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

    return Card(
     color: Colors.grey[750],    
     child:
     new Column(
       mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,
     children: <Widget>[
       Padding(
     padding: EdgeInsets.all(5.0),
     child: Row(
     mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,
      children: <Widget>[
    
     Column(
          mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,children: <Widget>[
        Text( "gained" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
            Text( "0" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
            Text( "kcal" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
      ],),
       
     Column(
          mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //chart
            AnimatedCircularChart(
  key: _chartKey,
  size:const Size(60.0,60.0),
  initialChartData: <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(
          33.33,
          Colors.grey,
          rankKey: 'completed',
        ),
        new CircularSegmentEntry(
          66.67,
          Colors.white,
          rankKey: 'remaining',
        ),
      ],
      rankKey: 'progress',
    ),
  ],
  chartType: CircularChartType.Radial,
  percentageValues: true,
  holeLabel: '1350',
  labelStyle: new TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
  ),
)
      ],),
      
     Column(
          mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,children: <Widget>[
        Text( "Burned" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
            Text( "510" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
            Text( "kcal" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
            
      ],),
            ]
            ),), 
     Padding(
     padding: EdgeInsets.all(5.0),
     child: Row(
     mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,
      children: <Widget>[
    
       Column(
          mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,children: <Widget>[
        Text( "Fat" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
            Text( "0 gm" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
           
      ],),
       
     Column(
          mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,children: <Widget>[
        Text( "Carbohydrates" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
            Text( "0 gm" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
            
      ],),
      Column(
          mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,children: <Widget>[
        Text( "Protein" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
            Text( "0 gm" ,   
      style: TextStyle(fontSize: 12.0, color: Colors.white ,fontWeight: FontWeight.bold,),
            ),
            
      ],),
            ]
            ),), 
            ], ),);}

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          child: card(),
          decoration: BoxDecoration(
             border: Border.all(width: 30.0,color: Colors.red),
            gradient:RadialGradient(
              colors: [
                Colors.red,
                Colors.red,
              ],
              tileMode: TileMode.repeated,
            ),
          ),
        ),
  
            ],
            );
      }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  // TODO: implement snapConfiguration
  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
  }
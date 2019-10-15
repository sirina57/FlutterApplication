import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';

class Carte{
  String minimum,average,maximum,score,debt;
  Carte({this.minimum,this.average
  ,this.maximum,this.score,this.debt});
}

class Header implements SliverPersistentHeaderDelegate {
  Header({
    this.minExtent,
    this.maxExtent,
  });
  double maxExtent;
  double minExtent;

  static Carte carte =Carte(minimum: "minimum",average:"average",maximum: "maximum",score: "score",debt: "debt");
 
  Card card=  new Card(
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
            carte.minimum,
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
             carte.average,        
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
             Text(carte.maximum,
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
            carte.score,        
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
            child: Text(carte.debt,       
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ),
                  ]
                ),
    );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          child: card,
          decoration: BoxDecoration(
             border: Border.all(width: 20.0,color: Colors.red),
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


  // dont touch!!!!!!

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  // TODO: implement snapConfiguration
  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
  
 

 


}
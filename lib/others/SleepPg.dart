/**import 'package:flutter/material.dart';
import '../pages/Trends.dart'as t;
import '../others/scrolledPage.dart' as s;
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
class SleepHeader implements SliverPersistentHeaderDelegate {
  SleepHeader({
    
    this.minExtent,
    this.maxExtent,
  });
  double maxExtent;
  double minExtent;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return  Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/red.png',
         fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black38,
              ],
             
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            'Sleep',
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
        ),

         Positioned(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          child: Card(

             color: Colors.grey[750],    
              child:new Stack(
                fit: StackFit.expand,
                children: [
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

         new Divider( color: Colors.grey[600],),
            ],
              )
          )
          )
          ]
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
// page 
class Sleep extends StatelessWidget{
 Sleep({Key key,  this.onLayoutToggle}) : super(key: key);
  //final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;

  final List<String> assetNames = [
    'assets/lit.jpg',
    'assets/wow.jpg',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
      child:PageView(
      children: [
        new s.HeroPage(),//history
         new t.Trends(),
       
        //_buildPage(index: 4, color: Colors.red),
      ],
    )
      ),
    );
  }
} */
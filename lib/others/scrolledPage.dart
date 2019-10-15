import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:flutter/material.dart';


//header
class HeroHeader implements SliverPersistentHeaderDelegate {
  HeroHeader({
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
         child:  Card(

             color: Colors.grey[750],    
              
          )
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
  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;


}
// page 
class HeroPage extends StatelessWidget  {
  HeroPage({Key key,  this.onLayoutToggle}) : super(key: key);
  //final LayoutGroup layoutGroup;
  TabController controller;
  final VoidCallback onLayoutToggle;

  final List<String> assetNames = [
    'assets/lit.jpg',
    'assets/wow.jpg',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
      child: _scrollView(context),
      ),
    );
  }

  Widget _scrollView(BuildContext context) {
    // Use LayoutBuilder to get the hero header size while keeping the image aspect-ratio
    TabController controller;
    return  Scaffold(
      appBar:AppBar(
        title: new Text("Sleep"),
        backgroundColor: Colors.red,
       
      ),
      


      body: CustomScrollView(
          slivers: <Widget>[

            SliverPersistentHeader(
              pinned: true,
              //header
              delegate: HeroHeader(
                minExtent: 50.0,
                maxExtent: 150.0,
              ),
            ),
            //body

            SliverFixedExtentList(
            itemExtent: 150.0,
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  //padding:EdgeInsets.all(3.0),
              alignment: Alignment.center,
                 
              child: new Card(
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
            )
                );
              },
            ),
          ),
            


/*          SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    padding: _edgeInsetsForIndex(index),
                    child: Image.asset(
                      assetNames[index % assetNames.length],
                    ),
                  );
                },
                childCount: assetNames.length * 2,
              ),
            ),*/
          ],
        
      ),
    );
  }

 /* EdgeInsets _edgeInsetsForIndex(int index) {
    if (index % 2 == 0) {
      return EdgeInsets.only(top: 4.0, left: 8.0, right: 4.0, bottom: 4.0);
    } else {
      return EdgeInsets.only(top: 4.0, left: 4.0, right: 8.0, bottom: 4.0);
    }
  }*/
}
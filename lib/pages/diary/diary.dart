
import 'package:appv1/loadJson/food.dart';
import 'package:appv1/loadJson/loadFood.dart';
import 'package:appv1/loadJson/mealsModel.dart';

import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/pages/sleep/sleep.dart';
import 'package:appv1/pages/sleep/sleepHome.dart';
import 'package:appv1/pages/water/water.dart';
import 'package:appv1/pages/water/waterHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:rxdart/rxdart.dart';

import 'package:appv1/model/drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class Diary extends StatefulWidget{
  final Key index;
  final Function() onPressed;
  final String tooltip;
  final IconData icon;
 Diary({this.index,this.onPressed, this.tooltip, this.icon});
  @override
  DiaryState createState() => new DiaryState(index);}
class DiaryState extends State<Diary> with SingleTickerProviderStateMixin{
    final Key pageindex;
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

 List<Food> food=List();
 bool hasLoaded = false;
 final PublishSubject subject =PublishSubject<String>();

  DiaryState(this.pageindex);

   @override
  void dispose() 
   {  subject.close();
   _animationController.dispose();
        super.dispose();}
 
 animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget addfood() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'Food',
         backgroundColor: Colors.green,
         onPressed: (){
           Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Diary()));
              },
        tooltip: 'Food',
        child: Image.asset(
            'assets/plate.png',
            height: 30.0,
            width: 30.0,
            color: Colors.white),
      ),
    );
  }

  Widget activity() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'Activity' ,
        backgroundColor: Colors.green,
        onPressed: (){
             Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SleepHome()));
            },
        tooltip: 'Activity',
        child: Image.asset(
            'assets/activ.png',
            height: 25.0,
            width: 25.0,
            color: Colors.white),
      ),
    );
  }

  Widget water() {
    return Container(
      child: FloatingActionButton(
        heroTag:'water' ,
        backgroundColor: Colors.green,
        onPressed: (){
         Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Wateradder(condition: false,)));
                  },
        tooltip: 'water',
        child: Image.asset(
            'assets/water.png',
            height: 25.0,
            width: 25.0,
            color: Colors.white),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }
// card displayed in the background 
  Card  card(){
        
final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

    return Card(
     margin: EdgeInsets.only(top: 30.0),
     color: Colors.grey[750],    
     child:
     ScopedModelDescendant<UserModel>(
            builder: (context, child, userModel) => Column(
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
  holeLabel: userModel.calories().toString(),
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
              ], ),
     ),);}

void onError(dynamic d){
  setState(() {
      hasLoaded = true;
    });
}
void resetFood(){
    setState(()=> food.clear());
  }
  @override
  void initState(){
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.green,
      end: Colors.green,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

 final TextEditingController controller = new TextEditingController();

 final scaffkey = GlobalKey<ScaffoldState>();
 @override
Widget build(BuildContext context) {
   
  var scaff =ScopedModelDescendant<UserModel>(
 builder: (context, child, usermodel) => Scaffold(
      key: scaffkey,
       floatingActionButton:   Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 3.0,
              0.0,
            ),
            child: addfood(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 2.0,
              0.0,
            ),
            child: activity(),
          ),
          
          toggle(),
        ],
      ),
    
      endDrawer:rightDrawer(context),
    drawer: leftDrawer(context),  
        body: CustomScrollView(
         slivers: <Widget>[
              SliverAppBar(
                
                title: 
                  Text("My Diary:"),
               
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
                backgroundColor:  Colors.red,
                expandedHeight: 210.0,
               titleSpacing: 1.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
     background:  Container(
                           padding: EdgeInsets.all(30.0),
                           color: Colors.red,
                           child: Padding(
          padding: EdgeInsets.all(5.0),
          child: card(),
      ) )
                 )),
              
                //water
               SliverFixedExtentList(
              
              itemExtent: 100.0,
              delegate: SliverChildBuilderDelegate(
               (BuildContext context,int index  ) {
                 return
                 ScopedModelDescendant<UserModel>(
                builder: (context, child, model) => Container(
                          //padding:EdgeInsets.all(3.0),
                  alignment: Alignment.center,
                         
                  child: new Card(
                        color: Colors.grey[750],    
                        child:new Stack(
                          fit: StackFit.expand,
                          children: [

            Positioned(
              left: 10.0,
              top: 14.0,
              child:  new Image.asset(
              'assets/water.png',
              height: 30.0,
              width: 30.0,
              color: Colors.white),
              ),
            
             Positioned(
          
              left: 60.0,
             top: 15.0,
              child:Text(
                  'Water intake',        
                  style: TextStyle(fontSize: 17.0, color: Colors.white ,fontWeight: FontWeight.bold,),
              ),
            ),
            //divider!
            new Divider( color: Colors.grey[600],),
            Positioned(
          
              left: 40.0,
             bottom: 16.0,
              child: Text(
                 model.currentUser.intake.toString()+ " Litre",  
                  style:  TextStyle(fontSize: 12.0, color: Colors.white),),
               
            ),
             Positioned(
             
              right: 16.0,
             bottom: 16.0,
             child: Text(
              "Goal : 2.05 Litre",        
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
              ),
            ),
            Positioned(
          
             right: 5.0,
             top: 10.0,
              child: FlatButton(
                onPressed: (){
        Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => WaterHome(mywater:Water(model.currentUser.intake,2500,false,''))));
      
                         },
                child: Icon(Icons.add),
              )
            ),
         ], ),),
          ),
                    );},
                childCount: 1,
              ),
            ),

    //breakfest
 SliverFixedExtentList(
          itemExtent: 150.0,
              delegate: SliverChildBuilderDelegate(
               (BuildContext context,int index  ) {
                 return  Container(
                          //padding:EdgeInsets.all(3.0),
                    alignment: Alignment.center,
                    child: new Card(
                        color: Colors.grey[750],    
                        child:new Stack(
                          fit: StackFit.expand,
                          children: [
                             Positioned(
              left: 10.0,
              top: 16.0,
              child:new   Image.asset(
              'assets/bread.png',
              height: 30.0,
              width: 30.0,
              color: Colors.white),
              ),
            

            Positioned(
              left: 60.0,
              top: 16.0,
              child: Text(
                    "Breakfast",
                    style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
             Positioned(
          
             right: 5.0,
             top: 10.0,
              child: FlatButton(
                   onPressed: (){
                           Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new FoodList(meal: 'breakfast',pageindex: pageindex,)));
                         print('breakfast');
                         },
                child: Icon(Icons.add),
              )
            ),
            
              new Divider( color: Colors.white), 
          
            
            Positioned(
          
              left: 120.0,
             bottom: 16.0,
              child: Text(
                  //  "338-473 Kcal"
                 usermodel.currentUser.breakfastCalories.toString()+'  Kcal',        
                    style: TextStyle(fontSize: 13.0, color: Colors.white),
              ),
            ),
             ],),),
                 );
                },
                childCount: 1,
              ),
            ),
      //lunch
       SliverFixedExtentList(
          itemExtent: 150.0,
              delegate: SliverChildBuilderDelegate(
               (BuildContext context,int index  ) {
                 return new Container(
                        //padding:EdgeInsets.all(3.0),
                  alignment: Alignment.center,
                  child: new Card(
                      color: Colors.grey[750],    
                      child:new Stack(
                        fit: StackFit.expand,
                        children: [
                           Positioned(
              left: 10.0,
              top: 16.0,
              child:new  Image.asset(
              'assets/bol.png',
              height: 30.0,
              width: 30.0,
              color: Colors.white),
              ),
            

            Positioned(
              left: 60.0,
              top: 16.0,
              child: Text(
                  "Lunch",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
             Positioned(
          
             right: 5.0,
             top: 10.0,
              child: FlatButton(
                onPressed: (){
                         Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new FoodList(meal: 'lunch',pageindex: pageindex,)));
                         print('lunch');
                          print('$index');
                       },
                child: Icon(Icons.add),
              )
            ),
               new Divider( color: Colors.white),
           
            Positioned(
          
              left: 120.0,
             bottom: 40.0,
              child: Text("",
                 // "Recommendation",        
                  style: TextStyle(fontSize: 11.0, color: Colors.grey[600]),
              ),
            ),
            Positioned(
          
              left: 120.0,
             bottom: 16.0,
              child: Text(
                 usermodel.currentUser.lunchCalories.toString()+'  Kcal',
                //  "338-473 Kcal",        
                  style: TextStyle(fontSize: 13.0, color: Colors.white),
              ),
            ),
             ],
                  ),
              ),
       );
                },
                childCount: 1,
              ),
            ),
    //dinner        
SliverFixedExtentList(
          itemExtent: 150.0,
              delegate: SliverChildBuilderDelegate(
               (BuildContext context,int index  ) {
                 return new Container(
                        //padding:EdgeInsets.all(3.0),
                  alignment: Alignment.center,
                  child: new Card(
                      color: Colors.grey[750],    
                      child:new Stack(
                        fit: StackFit.expand,
                        children: [
                           Positioned(
              left: 10.0,
              top: 16.0,
              child:new  Image.asset(
              'assets/fish.png',
              height: 30.0,
              width: 30.0,
              color: Colors.white),
              ),
            

            Positioned(
              left: 60.0,
              top: 16.0,
              child: Text(
                  "Dinner",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
             Positioned(
          
             right: 5.0,
             top: 10.0,
              child: FlatButton(
               onPressed: (){
                         Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new FoodList(meal: 'dinner',pageindex: pageindex,)));
                         print('dinner');
                       },
                child: Icon(Icons.add),
              )
            ),
               new Divider( color: Colors.white),
           
            Positioned(
          
              left: 120.0,
             bottom: 40.0,
              child: Text("",
                  //"Recommendation",        
                  style: TextStyle(fontSize: 11.0, color: Colors.grey[600]),
              ),
            ),
            Positioned(
          
              left: 120.0,
             bottom: 16.0,
              child: Text(
                   usermodel.currentUser.dinnerCalories.toString()+'  Kcal',
               //   "338-473 Kcal",        
                  style: TextStyle(fontSize: 13.0, color: Colors.white),
              ),
            ),
             ],
                  ),
              ),
       );
                },
                childCount: 1,
              ),
            ),
//snacks
SliverFixedExtentList(
          itemExtent: 150.0,
              delegate: SliverChildBuilderDelegate(
               (BuildContext context,int index  ) {
                 return new Container(
                        //padding:EdgeInsets.all(3.0),
                  alignment: Alignment.center,
                  child: new Card(
                      color: Colors.grey[750],    
                      child:new Stack(
                        fit: StackFit.expand,
                        children: [
                           Positioned(
              left: 10.0,
              top: 16.0,
              child:new  Image.asset(
              'assets/apple.png',
              height: 30.0,
              width: 30.0,
              color: Colors.white),
              ),
            

            Positioned(
              left: 60.0,
              top: 16.0,
              child: Text(
                  "Snacks",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
             Positioned(
          
             right: 5.0,
             top: 10.0,
              child: FlatButton(
                onPressed: (){
                         Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new FoodList(meal: 'snack',pageindex: pageindex,)));
                         print('snack');
                       },
                child: Icon(Icons.add),
              )
            ),
               new Divider( color: Colors.white),
            Positioned(
          
              left: 120.0,
             bottom: 40.0,
              child: Text("",
               //   "Recommendation",        
                  style: TextStyle(fontSize: 11.0, color: Colors.grey[600]),
              ),
            ),
            Positioned(
          
              left: 120.0,
             bottom: 16.0,
              child: Text(
                   usermodel.currentUser.snackCalories.toString()+'  Kcal',
                 // "338-473 Kcal",        
                  style: TextStyle(fontSize: 13.0, color: Colors.white),
              ),
            ),
             ],
                  ),
              ),
       );
                },
                childCount: 1,
              ),
            ),

            //activity
SliverFixedExtentList(
          itemExtent: 200.0,
              delegate: SliverChildBuilderDelegate(
               (BuildContext context,int index  ) {
                 return new Container(
                   height: 200.0,
                        //padding:EdgeInsets.all(3.0),
                  alignment: Alignment.center,
                  child: new Card(
                      color: Colors.grey[750],    
                    
                      child: new ExpansionTile(
                        initiallyExpanded: true,
                          leading:new  Image.asset(
              'assets/activ.png',
              height: 30.0,
              width: 30.0,
              color: Colors.white) ,
              trailing:FlatButton(
                onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SleepHome()));
                        },
                child: Icon(Icons.add),
              ) ,
             title: Text(
                  "Activity",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              
              children: <Widget>[
                 ScopedModelDescendant<UserModel>(
            builder: (context, child, userModel) =>Column(
          children: <Widget>[
             new Divider( color: Colors.white),
             RichText(
               textAlign: TextAlign.start,
                text: TextSpan(
                    text:"Sleeping",
                    style: TextStyle(
                      fontSize: 14.0,
                      
                    )),
              ),
              new Divider( color: Colors.transparent),
               RichText(
                text: TextSpan(
                    text:"Time performed",
                     style: TextStyle(fontSize: 11.0, color: Colors.grey[600]),),
              ),
              new Divider( color: Colors.white),
              new Divider( color: Colors.transparent),
               RichText(
                text: TextSpan(
                    text: userModel.currentUser.sleep,
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),),
             new Divider( color: Colors.transparent),
          

          ]
           ),
                 ),
              ]
          )
             
       ),);},
        
        childCount: 1,
        ),
        ) ,



        // displaying meals
        /*
        SliverFixedExtentList(
          itemExtent: 200.0,
              delegate: SliverChildBuilderDelegate(
               (BuildContext context,int index  ) {
                 return new Container(
                   height: 200.0,
                        //padding:EdgeInsets.all(3.0),
                  alignment: Alignment.center,
                  child: new Card(
                      color: Colors.grey[750],    
                    
                      child: new ExpansionTile(
                        initiallyExpanded: true,
                          leading:new  Image.asset(
              'assets/bread.png',
              height: 30.0,
              width: 30.0,
              color: Colors.white) ,
              trailing:FlatButton(
                onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new FoodList(meal: 'breakfast',pageindex: pageindex,)));
                        },
                child: Icon(Icons.add),
              ) ,
             title: Text(
                 "Breakfast",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              
              children: <Widget>[
                   new Divider( color: Colors.white),
           
                ScopedModelDescendant<MealsModel>(
            builder: (context, child, mealmodel) =>  Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
                          children:<Widget>[
                             Text(
                mealmodel.breakfast.length==0 ?"":"  "+mealmodel.breakfast[0].title,
                       // "Recommendation",        
                style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                   Text(
                mealmodel.breakfast.length <2 ?"":"  "+ mealmodel.breakfast[1].title,
                       // "Recommendation",        
                style: TextStyle(fontSize: 11.0, color: Colors.white),
                  ),
                   Text(
                mealmodel.breakfast.length <3 ?"":"  "+ mealmodel.breakfast[2].title,
                       // "Recommendation",        
                style: TextStyle(fontSize: 11.0, color: Colors.white),
                  ),

                          ]),
            ),
              ]
          )
             
       ),);},
        
        childCount: 1,
        ),
        ) */])),
  );
 
 return 
   SafeArea(
      child: scaff
  );
  

}
}
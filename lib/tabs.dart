import 'package:flutter/material.dart';


import './today.dart' as today; 
import './tomorow.dart' as tomorrow;
import './yesterday.dart' as yesterday ;

// the go back and forth 
//control tabs 


 class BasicAppBarSample extends StatefulWidget {
  @override
  _BasicAppBarSampleState createState() => _BasicAppBarSampleState();
}

class _BasicAppBarSampleState extends State<BasicAppBarSample> with SingleTickerProviderStateMixin {
  String currentProfilePic ="https://yt3.ggpht.com/-2_2skU9e2Cw/AAAAAAAAAAI/AAAAAAAAAAA/6NpH9G8NWf4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg";
  String otherProfilePic ="https://yt3.ggpht.com/-2_2skU9e2Cw/AAAAAAAAAAI/AAAAAAAAAAA/6NpH9G8NWf4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg";
 
  TabController controller;
  Choice _selectedChoice = choices[0]; // The app's "state".

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }
   @override
    void initState() {
  
      super.initState();
      controller = new TabController(vsync:  this ,length: 3);
    }

    @override
      void dispose() 
      {
       controller.dispose();
        super.dispose();
        }



  @override
  Widget build(BuildContext context){
    Widget myTabsScaffold = Scaffold(
  appBar: new AppBar(
         backgroundColor: Colors.red, 
        title: new Text("Overview"),
          actions: <Widget>[
            IconButton(
              icon: Icon(choices[0].icon),
              onPressed: () {
                _select(choices[0]);
              },
            ) ,
             IconButton(
              icon: Icon(choices[1].icon),
              onPressed: () {
                 _select(choices[1]);
              },
            ),
            // overflow menu
            PopupMenuButton<Choice>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.skip(2).map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
        ),
 body:  Padding(
         padding: const EdgeInsets.all(16.0),
        child:  ChoiceCard(choice: _selectedChoice),
        
       ));

    return MaterialApp(
      home: myTabsScaffold 
      );
  }
  }

        

class Choice {
  const Choice({this.title,this.icon});
  final String title;
  final IconData icon;
}
const List<Choice> choices = const <Choice>[
    const Choice(title: 'last', icon: Icons.arrow_back),
  const Choice(title: 'next', icon: Icons.arrow_forward),


];

class ChoiceCard extends StatelessWidget{

  const ChoiceCard({Key key, this.choice}):super(key :key);
  final Choice choice;
  @override
  Widget build(BuildContext context ){

final TextStyle textStyle=Theme.of(context).textTheme.display1;
var card = Card(
  color:  Colors.white,
  child: Center(
    child: Column(
     crossAxisAlignment: CrossAxisAlignment.center,
     children: <Widget>[
       Icon(choice.icon,size:  128.0, color: textStyle.color,),
       Text(choice.title,style: textStyle,)
     ],
    ),
  ),

);
return  card ;
  }
}
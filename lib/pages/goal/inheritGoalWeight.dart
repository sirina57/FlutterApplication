
import 'package:appv1/pages/goal/editGoalWeight.dart';
import 'package:appv1/pages/goal/goal.dart';
import 'package:flutter/material.dart';



class GoalApp extends StatefulWidget {
  @override
  GoalAppState createState() => GoalAppState();
}

class GoalAppState extends State<GoalApp> {
  
 bool edited =true;

  void onTap() {
    setState(() {
     // bool edit=edited;
       edited = false;
       // !edit;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return EditWeight(
      edited: edited,
      onTap: onTap,
      child: BoxTree(),
    );
  }
}

class EditWeight extends InheritedWidget {
  EditWeight({
    Key key,
    this.edited,
    this.weight,
    this.goalWeight,
    this.onTap,
    Widget child,
  }) : super(key: key, child: child);

  final bool edited;
  final String weight;
   final String goalWeight;

  final Function onTap;

  @override
  bool updateShouldNotify(EditWeight oldWidget) {
    return edited != oldWidget.edited;
  }

  static EditWeight of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(EditWeight);
  }
}

class BoxTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newweight = EditWeight.of(context);
    return Scaffold(
      body:newweight.edited ? Goal():EditBox() ,
      //weight: newweight.weight,goalWeight:newweight.goalWeight,
    );
  }
}

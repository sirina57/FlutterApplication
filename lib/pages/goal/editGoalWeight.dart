
import 'package:appv1/pages/goal/goal.dart';

import 'package:flutter/material.dart';



class EditBox extends StatefulWidget {
  @override
  EditBoxState createState() => EditBoxState();
}

class EditBoxState extends State<EditBox> {
  bool edited = false;
  String weight ='';
  String goalWeight ='';
  String _weight, _goalWeight;

  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      key: mainKey,
     
     // appBar: AppBar(title: Text("Login")),
      body:edited == false
              ?  SafeArea(
       child: Container(
         padding: EdgeInsets.only(top: 10.0),
         color: Colors.grey[750],
                child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
                      key: formKey,
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                           keyboardType: TextInputType.number,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "New Weight:",
                            ),
                           onSaved: (str) =>  _weight = str,
                          ),
                          TextFormField(
                             keyboardType: TextInputType.number,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "Goal Weight:",
                            ),
                            onSaved: (str) => _goalWeight = str,
                          ),
                            RaisedButton(
                              color: Colors.green,
                              child: Text("Submit"),
                              onPressed: onPressed,
                            ),
                            
                          /** RaisedButton(
                            child: Text("Cancel"),
                            onPressed: null,
                          ), */
                        ],
                      ),
                    )),
       ),
              ): Goal(weight:weight,goalWeight:goalWeight,)
               );
  }
  
  void onPressed() {
    var form = formKey.currentState;


    if (form.validate()) {
      form.save();
      setState(() {
        edited = true;
        weight= '$_weight';
        goalWeight='$_goalWeight';
        form.setState((){
         
        });
        
      });
    
}
  }
  }
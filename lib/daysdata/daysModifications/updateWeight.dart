

import 'package:appv1/daysdata/databaseHelper.dart';
import 'package:appv1/daysdata/daysModifications/display.dart';
import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/daysdata/sqlitedays/restData.dart';
import 'package:flutter/material.dart';


class UpdateWeight extends StatefulWidget {
  @override
  _UpdateWeightState createState() => new _UpdateWeightState();
}

class _UpdateWeightState extends State<UpdateWeight> implements UpdateDayPageContract{
 
  BuildContext _ctx;
  bool _isLoading = false;
  final updateWeightscaffoldKey = new GlobalKey<ScaffoldState>();
 final updateWeightformKey = new GlobalKey<FormState>();
  String _breakfast,_lunch,_dinner,_snack,_water,_weight,_value;
  int _id;
  DayDiary _day =new DayDiary( 'date',0,0,0,0, 'waterIntake', 'weight');

  UpdateDayPagePresenter _updatepresenter;

  _UpdateWeightState() {
  
    _updatepresenter = new UpdateDayPagePresenter(this);
  }
  
  
 
   void _submitWeight() {
    final form = updateWeightformKey.currentState;
    
    if (form.validate()) {
      setState(() {
   //  _isLoading = true;
       form.save();
      // String val= _day.weight + _value;
       _updatepresenter.doUpdate(_id,_value);
       print('$_value');
     
     
      });
    }
  }

  void _showSnackBar(String text) {
    updateWeightscaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    _ctx = context;
  
   var weightbtn = RaisedButton(
                  child: Text('change weight'),
                  color: Colors.green,
                  onPressed:_submitWeight );
  var updateform = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Add Weight",
          textScaleFactor: 2.0,
        ),
        new Form(
          key: updateWeightformKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _value = val,
                  decoration: new InputDecoration(contentPadding: EdgeInsets.all(10.0),
                  labelText: "Previous Weight:",
                    hintText: 'Kg'),
                ),
              ),
               new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                   initialValue: '1535223745412',
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _id = int.parse(val),
                  decoration: new InputDecoration(contentPadding: EdgeInsets.all(10.0),
                  labelText: "id :",
                    hintText: ''),
                ),
              ),
              ])),
   
    
        weightbtn,
       
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Weight Tracker Page"),
      ),
      key: updateWeightscaffoldKey,
      body: new Container(
        child: new Center(
          child: ListView(
            children: <Widget>[
              updateform,
          ],
          )
          
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
                  child:Icon(Icons.done),
            onPressed: () {
            Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (context) => Mydays()));
            },
          ), 
    );
  }
@override
  void onUpdateSuccess(DayDiary weight,String value) async {
   
    _showSnackBar(weight.toString());
    setState(() {
     _isLoading = false;
    });
    var db = new AppDatabase();
    // String val = weight.weight+value;
    await db.addWeight(weight,value);
 }
  @override
  void onupdateError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }
 
 
}

abstract class UpdateDayPageContract {
  void onupdateError(String error);
  void onUpdateSuccess(DayDiary day,String value);
}

class UpdateDayPagePresenter {
 
  UpdateDayPageContract _upview;
  RestData api = new RestData();
  UpdateDayPagePresenter(this._upview);
  
   doUpdate(int id,String weight) {
    api
        .update( id, weight)
        .then((day) => _upview.onUpdateSuccess(day,weight))
        .catchError((onError) => _upview.onupdateError(onError.toString()));
  }
}
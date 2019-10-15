

import 'package:appv1/daysdata/databaseHelper.dart';
import 'package:appv1/daysdata/daysModifications/display.dart';
import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/daysdata/sqlitedays/restData.dart';
import 'package:flutter/material.dart';


class Update extends StatefulWidget {
  
  @override
  _UpdateState createState() => new _UpdateState();
}

class _UpdateState extends State<Update> implements UpdateDayPageContract{
 
 
  BuildContext _ctx;
  bool _isLoading = false;
  final updateFoodscaffoldKey = new GlobalKey<ScaffoldState>();
 final updateformKey = new GlobalKey<FormState>();
  String _breakfast,_lunch,_dinner,_snack,_water,_meal;
  int _valueId;
  DayDiary _day =new DayDiary('date',0,0,0,0, 'waterIntake', 'weight');

  UpdateDayPagePresenter _updatepresenter;

  _UpdateState() {

    _updatepresenter = new UpdateDayPagePresenter(this);
  }
  
  
 
   void _submitWeight() {
    final form = updateformKey.currentState;
    
    if (form.validate()) {
      setState(() {
   //  _isLoading = true;
       form.save();
      
       _updatepresenter.doUpdate(_day,_meal,1535223745412);
     
     
      });
    }
  }

  void _showSnackBar(String text) {
    updateFoodscaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    _ctx = context;
  
   var weightbtn = RaisedButton(
                  child: Text('change '),
                  color: Colors.green,
                  onPressed:_submitWeight );
  var updateform = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          "change",
          textScaleFactor: 2.0,
        ),
         new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  initialValue: '1535223745412',
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _valueId = int.parse(val),
                  decoration: new InputDecoration(contentPadding: EdgeInsets.all(10.0),
                  labelText: "id:",
                    hintText: ''),
                ),
              ),
        new Form(
          key: updateformKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _meal = val,
                  decoration: new InputDecoration(contentPadding: EdgeInsets.all(10.0),
                  labelText: "meal:",
                    hintText: 'Kg'),
                ),
              ),
               new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  initialValue: '1535223745412',
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _valueId = int.parse(val),
                  decoration: new InputDecoration(contentPadding: EdgeInsets.all(10.0),
                  labelText: "meal:",
                    hintText: 'Kg'),
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
      key: updateFoodscaffoldKey,
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
  void onUpdateSuccess(DayDiary day,String meal,int id) async {
   
    _showSnackBar(day.toString());
    setState(() {
     _isLoading = false;
    });
    var db = new AppDatabase();
    int val = int.parse(day.weight) +id;
    await db.addFood(day,meal,val);
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
  void onUpdateSuccess(DayDiary day,String value,int id);
}

class UpdateDayPagePresenter {
 
  UpdateDayPageContract _upview;
  RestData api = new RestData();
  UpdateDayPagePresenter(this._upview);
  
   doUpdate(DayDiary day,String meal,int id ) {
    api
        .updateBreakfast( day,id.toString())
        .then((day) => _upview.onUpdateSuccess(day,meal,id))
        .catchError((onError) => _upview.onupdateError(onError.toString()));
  }
}

/*
import 'package:appv1/daysdata/databaseHelper.dart';
import 'package:appv1/daysdata/display.dart';
import 'package:flutter/material.dart';


class UpdatePage extends StatefulWidget {
  @override
  _UpdateState createState() => new _UpdateState();
}

class _UpdateState extends State<UpdatePage> implements UpdateDayPageContract{
 
  BuildContext _ctx;
  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
 final updateformKey = new GlobalKey<FormState>();
  String _breakfast,_lunch,_dinner,_snack,_water,_weight,_value;
  DayDiary _day =new DayDiary(1535223745412, 'breakfastIds', 'dinnerIds', 'lunchIds', 'snackIds', 'waterIntake', 'weight');

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
      
       _updatepresenter.doUpdate(_day,_value);
     
     
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
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
          key: updateformKey,
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
              ),])),
   
    
        weightbtn,
       
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Weight Tracker Page"),
      ),
      key: scaffoldKey,
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
     // _isLoading = false;
    });
    var db = new AppDatabase();
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
  
   doUpdate(DayDiary day,String weight) {
    api
        .update( day, weight)
        .then((day) => _upview.onUpdateSuccess(day,weight))
        .catchError((onError) => _upview.onupdateError(onError.toString()));
  }
}*/
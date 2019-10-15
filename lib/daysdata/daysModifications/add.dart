

import 'package:appv1/daysdata/databaseHelper.dart';
import 'package:appv1/daysdata/daysModifications/display.dart';

import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/daysdata/sqlitedays/restData.dart';
import 'package:flutter/material.dart';


class AddDay extends StatefulWidget {
  @override
  _AddWeightState createState() => new _AddWeightState();
}

class _AddWeightState extends State<AddDay> implements AddDayPageContract{
  
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffAddKey = new GlobalKey<ScaffoldState>();
 final updateformKey = new GlobalKey<FormState>();
  String _water,_weight,_value;
  int _breakfast,_lunch,_dinner,_snack;
  DayDiary _day =new DayDiary('date',0,0,0,0, 'waterIntake', 'weight');
  AddDayPagePresenter _presenter;
 

  _AddWeightState() {
    _presenter = new AddDayPagePresenter(this);
 
  }
  
  
  void _submit() {
    final form = formKey.currentState;
    
    if (form.validate()) {
      setState(() {
     _isLoading = true;
       form.save();
     int now = DateTime.now().millisecondsSinceEpoch;
   
       _presenter.doAdd('now',_breakfast,_lunch,_dinner,_snack,_water,_weight);
     
     
      });
    }
  }
  

  void _showSnackBar(String text) {
    scaffAddKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var addBtn = RaisedButton(
                  child: Text('Add Item'),
                  color: Colors.green,
                  onPressed:_submit, );
   
    var dayForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
               
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _breakfast = int.parse(val),
              ),
              ),
               new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                 keyboardType: TextInputType.number,
                  onSaved: (val) => _lunch = int.parse(val),
                 ),
              ),
               new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _dinner = int.parse(val),
                  ),
              ),
               new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _snack = int.parse(val),
                 ),
              ),
               new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _water = val,
                 ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _weight = val,
                  ),
              ),
            ],
          ),
        ),
        addBtn,
        
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Weight Tracker Page"),
      ),
      key: scaffAddKey,
      body: new Container(
        child: new Center(
          child: ListView(
            children: <Widget>[
               dayForm,
           
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
  void onAddErroro(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onAddSuccess(DayDiary weight) async {
   
    _showSnackBar(weight.toString());
    setState(() {
      _isLoading = false;
    });
    var db = new AppDatabase();
    await db.save(weight);
    await db.show();
   // Navigator.of(context).pushNamed("/weight");
  }
 
}


abstract class AddDayPageContract {
  void onAddSuccess(DayDiary day);
  void onAddErroro(String error);
  
}

class AddDayPagePresenter {
  AddDayPageContract _view;

  RestData api = new RestData();
  AddDayPagePresenter(this._view);
  doAdd(String date,int breakfast,int lunch,int dinner,int snack,String water,String weight) {
    api
        .add( date, breakfast, lunch, dinner, snack, water, weight)
        .then((weight) => _view.onAddSuccess(weight))
        .catchError((onError) => _view.onAddErroro(onError.toString()));
  }
}
 


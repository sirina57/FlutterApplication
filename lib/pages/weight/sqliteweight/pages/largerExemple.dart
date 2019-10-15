import 'dart:async';
import 'package:appv1/charts/dataModel.dart';
import 'package:appv1/login/sqliteLogin/currentuser/currentUser.dart';
import 'package:appv1/pages/weight/sqliteweight/dbHelper.dart';

import 'package:appv1/pages/weight/sqliteweight/pages/addWeightContract.dart';
import 'package:appv1/pages/weight/sqliteweight/pages/weightHome.dart';

import 'package:appv1/pages/weight/sqliteweight/weight.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
class AppModel extends Model {
  List<Item> _items = [];
  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
  }

  void deleteItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}

class Item {
  final String name;
 final String sub;
final String date;


  Item(this.name,this.sub,this.date,);
}



class HomePage extends StatefulWidget {
  static final String route = "Home-Page";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> implements AddWeightPageContract {
  _MyHomePageState(){
 _presenter = new AddWeightPagePresenter(this);
  }
   AddWeightPagePresenter _presenter;
 String _prevweight, _newweight;
  static String _date,_time;
  DateTime _entry;
 List< String> _thedate =[_date,_time];

    DateTime _ndate=new DateTime.now();
  TimeOfDay _ntime =TimeOfDay.now();
 DateTime pickeddate ;
 TimeOfDay pickedTime;
  TextEditingController controller = TextEditingController();
TextEditingController subcontroller = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: AppModel(),
        child: Scaffold(
      appBar: AppBar(
        leading:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
   "assets/weight.png",
     height: 15.0,
    width: 15.0,
   color: Colors.white,
   ),
        ),
        title: Text('Add Weight'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            child: TextField(
              controller: controller,
               decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              labelText: "Previous Weight:",
                              hintText: 'Kg'
                            ),
            ),
          ),
          Container(
            child: TextField(
              controller: subcontroller,
               decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              labelText: "New Weight:",
                              hintText: 'Kg'
                            ),
            ),
          ),

            Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[ 
              Card(
                margin: EdgeInsets.all(10.0),
         child: IconButton(
    iconSize: 90.0,
   icon: Icon(Icons.calendar_today),
   onPressed: () async{
       pickeddate = await showDatePicker(
      context: context,
      initialDate: _ndate,
      firstDate: DateTime(2016),
      lastDate: DateTime(2019) );
      _date=''+pickeddate.day.toString()+'/'+pickeddate.month.toString()+'/'+pickeddate.year.toString()+' ';
      _entry=pickeddate;
                            print('${_date} *'); 
                            setState(() {
                             _thedate[0] =_date;  });},

                            ),
                          ),
      Card(
       margin: EdgeInsets.all(10.0),
      child: IconButton(
         iconSize: 90.0,
        icon: Icon(Icons.access_time),
        onPressed: () async{
       pickedTime = await showTimePicker(
      context: context,
      initialTime:_ntime, );
      _time=''+pickedTime.hour.toString()+':'+ pickedTime.minute.toString()+'';
                           print('${_time} *');
                           setState(() {
                            _thedate[1]=_time;  });},

                            ),
                          ),]),
          
          ScopedModelDescendant<AppModel>(
            builder: (context, child, model) =>ScopedModelDescendant<UserModel>(
 builder: (context, child, userModel) => ScopedModelDescendant<DataModel>(
            builder: (context, child, datamodel) => RaisedButton(
                      child: Text('Add Item'),
                      color: Colors.green,
                      onPressed: () { 
                        Item item = Item(controller.text,subcontroller.text,_date);
                        model.addItem(item);
                        userModel.currentUser.weight=subcontroller.text;
                        String date =_date.toString()+_time.toString();
                        _presenter.doAdd(controller.text,subcontroller.text,date);
                        datamodel.data(_entry);
                        setState(() {
                          controller.text = '';
                          subcontroller.text='';
                        });
                      },
                    ),
 ),
            ),
          ),
        ],
      )),
       floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
                  child:Icon(Icons.done),
            onPressed: () {
            Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (context) => WeightHome()));
            },
          ),
    ));
  }

  @override
  void onAddError(String error) {
    // TODO: implement onLoginError
  print('error: $error');
    
  }

  @override
  void onAddSuccess(Weight weight) async {
   
    var db = new DatabaseHelper();
    await db.saveWeight(weight);
    await db.show();
   // Navigator.of(context).pushNamed("/weight");
  }
}

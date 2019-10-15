import 'dart:async';
import 'package:appv1/daysdata/sqlitedays/pages/addContract.dart';
import 'package:appv1/daysdata/sqlitedays/pages/grisList.dart';
import 'package:appv1/daysdata/sqlitedays/pages/home.dart';
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';


class HomePage extends StatefulWidget {
  static final String route = "Home-Page";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> implements AddPageContract {
  _MyHomePageState(){
 _presenter = new AddPagePresenter(this);
  }
   AddPagePresenter _presenter;
 String water,weight,date;
 int breakfast,lunch,dinner,snack;
 int id =DateTime.now().millisecondsSinceEpoch;

  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<DayModel>(
        model: DayModel(),
        child: Scaffold(
      appBar: AppBar(
        title: Text('Add day'),
      ),
       floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
                  child:Icon(Icons.done),
            onPressed: () {
            Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (context) => Home()));
            },
          ),
      body:  
 Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
        key: formKey,
          child: new Column(
            children: <Widget>[
                new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => date = val,
                  initialValue: 'date',
              ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => breakfast = int.parse(val),
                  initialValue: 'breakfast',
              ),
              ),
               new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  initialValue: 'lunch',
                  onSaved: (val) => lunch = int.parse(val),
                 ),
              ),
               new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  initialValue: 'dinner',
                  onSaved: (val) => dinner =int.parse(val),
                  ),
              ),
               new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  initialValue: 'snack',
                  onSaved: (val) => snack =int.parse(val),
                 ),
              ),
               new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  initialValue: 'water',
                  onSaved: (val) => water = val,
                 ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  initialValue: 'weight',
                  onSaved: (val) => weight = val,
                  ),
              ),
            ],
          ),
        ),
   
          ScopedModelDescendant<DayModel>(
            builder: (context, child, model) => RaisedButton(
                  child: Text('Add Item'),
                  onPressed: () {
                     final form = formKey.currentState;
    
                    if (form.validate()) {
                      form.save();
                   DayDiary  item= DayDiary(date,breakfast, dinner, lunch, snack, water, weight);
                    model.addItem(item);
                    _presenter.doAdd(date, breakfast, dinner, lunch, snack, water, weight);
                    }
                  
                    
                  },
                ),
          ),
            ScopedModelDescendant<DayModel>(
            builder: (context, child, model) => RaisedButton(
                  child: Text('delete DB'),
                  onPressed: () {
                      model.delete();
              var db = AppDatabase();
                    db.deleteDay();
                    db.show();
                  },
                ),
          )

          ])
         ));
        
  } 
 
  
  


  @override
  void onAddError(String error) {
    // TODO: implement onLoginError
  print('error: $error');
    
  }

  @override
  void onAddSuccess(DayDiary day) async {
   
    var db = new AppDatabase();
    await db.save(day);
    await db.show();
   // Navigator.of(context).pushNamed("/weight");
  }

}
/**
class DisplayPage extends StatelessWidget {
  static final String route = "Display-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Weight History'),
          
        ),
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
                  child:Icon(Icons.add),
             onPressed: () {
                Navigator
                    .of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
          ),
        body: Container(
          child: ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => Column(
                children: model.items
                    .map((item) => ListTile(
                      title: Text(item.date,
                       style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),),
                         trailing: Text(item.name,
                          style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),),
                          subtitle: Text(item.sub),
                          
                          onLongPress: () {
                            model.deleteItem(item);
                          },
                        ))
                    .toList()),
          ),
        ));
  }
} */
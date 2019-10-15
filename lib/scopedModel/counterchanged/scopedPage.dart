
import 'package:appv1/scopedModel/counterchanged/database.dart';
import 'package:appv1/scopedModel/counterchanged/homePage.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



class ScopedModelPage extends StatelessWidget {
  ScopedModelPage({this.database});
  final AppDatabase database;//dbhelper sqlite

  void _createCounter() async {
    await database.createCounter();
  }

  void _increment(DayDiary day,String val) async {
   day.breakfastIds+=val;
    await database.update(day);
  }
  void _delete(DayDiary day) async {
 
    await database.deleteDay(day);
  }
final updateformKey = new GlobalKey<FormState>();
 String _val;
  DayDiary _day =new DayDiary(1535223745412, 'breakfastIds', 'dinnerIds', 'lunchIds', 'snackIds', 'waterIntake', 'weight');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scoped model'),
        elevation: 1.0,
      ),
      body: _buildContent(),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
           onPressed: () {
              _createCounter;
           }
        
      ),
    );
  }

  Widget _buildContent() {
    return ScopedModelDescendant<DaysModel>(
        builder: (context, child, model) {
      return Column(
        
              children:<Widget>[
                IconButton(
                  icon:  Icon(Icons.done),
           onPressed: () {
              Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (context) => ScopedPage(database: database,)));
            },),
                IconButton(
        icon: Icon(Icons.add, size: 28.0),
        color: Colors.black,
       onPressed:()=> _increment(_day, _val),
      ),
       Form(
            key: updateformKey,
            child: new Column(
              children: <Widget>[
              
                 new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new TextFormField(
                     initialValue: '1535223745412',
                    keyboardType: TextInputType.number,
                    onSaved: (val) => _val = val,
                    decoration: new InputDecoration(contentPadding: EdgeInsets.all(10.0),
                    labelText: "val :",
                      hintText: ''),
                  ),
                ),
                ])
        ),
              ]);
    });
  }
}

typedef Widget ItemWidgetBuilder<T>(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  ListItemsBuilder({this.items, this.itemBuilder});
  final List<T> items;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (items != null) {
      if (items.length > 0) {
        return _buildList();
      } else {
        return PlaceholderContent();
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return itemBuilder(context, items[index]);
        });
  }
}

class CounterListTile extends StatelessWidget {
  CounterListTile({this.key, this.counter,this.onIncrement});
  final Key key;
  final DayDiary counter;

  final ValueChanged<DayDiary> onIncrement;
 

  @override
  Widget build(BuildContext context) {
    return
       Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           
            SizedBox(width: 8.0),
            CounterActionButton(
              iconData: Icons.add,
              onPressed: () => onIncrement(counter),
            ),
          ]
    );
  }
}

class CounterActionButton extends StatelessWidget {
  CounterActionButton({this.iconData, this.onPressed});
  final VoidCallback onPressed;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 28.0,
      backgroundColor: Theme.of(context).primaryColor,
      child: IconButton(
        icon: Icon(iconData, size: 28.0),
        color: Colors.black,
        onPressed: onPressed,
      ),
    );
  }
}

class PlaceholderContent extends StatelessWidget {
  PlaceholderContent({
    this.title: 'Nothing Here',
    this.message: 'Add a new item to get started.',
  });
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Text(title,
              style: TextStyle(fontSize: 32.0, color: Colors.black54),
              textAlign: TextAlign.center),
          Text(message,
              style: TextStyle(fontSize: 16.0, color: Colors.black54),
              textAlign: TextAlign.center),
        ]));
  }
}
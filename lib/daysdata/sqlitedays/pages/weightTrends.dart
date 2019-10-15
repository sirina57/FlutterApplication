import 'dart:async';

import 'package:appv1/pages/weight/sqliteweight/dbHelper.dart';
import 'package:appv1/pages/weight/sqliteweight/weight.dart';
import 'package:appv1/pages/weight/sqliteweight/pages/largerExemple.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:scoped_model/scoped_model.dart';

Future<List<Weight>> fetchWeightsFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Weight>> weights = dbHelper.getWeights();
  return weights;
}

/**FutureBuilder<List<Weight>>(
          future: fetchWeightsFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {} */
class TrendsPage extends StatefulWidget {
@override
  TrendsPageState createState() => new TrendsPageState();
}

class TrendsPageState extends State<TrendsPage> {
 /**List<double> data(){
    List<double> content;
   FutureBuilder<List<Weight>>(
        future: fetchWeightsFromDatabase(),
        builder: (BuildContext context, AsyncSnapshot<List<Weight>> snapshot) {
          if (!snapshot.hasData)
        for (var i = 0; i < snapshot.data.length; i++) {
             content.add(double.parse(snapshot.data[i].newweight));
        }
            });
            return content;
} */

  @override
  Widget build(BuildContext context) {
    List<double> data =[63.0,60.0];
    return  ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => 
     Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
                  child:Icon(Icons.add),
             onPressed: () {
                Navigator
                    .of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
          ),
        body:
  Center(
      child: Container( 
      child:new FutureBuilder<List<Weight>>(
            future: fetchWeightsFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                                  child: new ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        for (int i = 0; i < snapshot.data.length; i++) {
                          data.add(double.parse(snapshot.data[i].newweight));
                        }
                        

    return SizedBox(
      height: 300.0,
        child: Card(
          margin: EdgeInsets.all(10.0),
        color: Colors.grey[750],
          child: Sparkline(
        data:data,
        fillMode: FillMode.below,
        fillColor: Colors.redAccent,
        pointsMode: PointsMode.all,
        pointSize: 8.0,
        pointColor: Colors.amber,
),
),
    );}
    ),
                );
              } } )
       ),
  ) ));
  }
}
/*
class WeightList extends StatelessWidget {
  WeightList({Key key}) : super(key: key);
var dH = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WeightModel>(
      builder: (context, child, model) {
        return Container(
          child: RefreshIndicator(
            child: _buildList(model),
             onRefresh: () async{
                var dbClient = await dH.db;
   List<Map> list = await dbClient.rawQuery('SELECT * FROM weight');
  final weights = list
        .map<Weight>((weight) => Weight.fromMap(weight))
        .toList();
              return weights;
          //await new Future.delayed(const Duration(seconds: 1));
            },

          ) 
        );
      },
    );
  }

  Center get _buildLoading {
    return Center(
      child: CircularProgressIndicator(
        //key: ArchSampleKeys.todosLoading,
      ),
    );
  }

  ListView _buildList(WeightModel model) {
    final weights = model.items;


    return ListView.builder(
     // key: ArchSampleKeys.todoList,
      itemCount: weights.length,
      itemBuilder: (BuildContext context, int index) {
        final weight = weights[index];

        return WeightItem(
          weight: weight,
          onTap: null,
          onDismissed: (direction) {
          
            _removeTodo(context, weight);
          },
        );
      },
    );
  }

  void _removeTodo(BuildContext context, Weight item) {
    WeightModel.of(context).deleteItem(item) ; 
    

    _showUndoSnackbar(context, item);
  }

  void _showUndoSnackbar(BuildContext context, Weight item) {
    Scaffold.of(context).showSnackBar(
          SnackBar(
           // key: ArchSampleKeys.snackbar,
            duration: Duration(seconds: 2),
            backgroundColor: Theme.of(context).backgroundColor,
            content: Text(' test',
             // ArchSampleLocalizations.of(context).todoDeleted(todo.task),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            action: SnackBarAction(
             // key: ArchSampleKeys.snackbarAction(todo.id),
              //label: ArchSampleLocalizations.of(context).undo,
              onPressed: () {
                WeightModel.of(context).addItem(item);
              },
            ),
          ),
        );
  }
}

class WeightItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Weight weight;

  WeightItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.weight,
  });
// card i get 
  @override
  Widget build(BuildContext context) {
    return Dismissible(
     
      key:Keys.weightItem('${weight.id}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
     contentPadding:EdgeInsets.all(10.0),
     title: Text(weight.date,
     style: TextStyle(
      fontSize: 18.0,
    fontWeight: FontWeight.bold,),),
     trailing: Text(''+ weight.newweight,
     style: TextStyle(
      fontSize: 25.0,
    fontWeight: FontWeight.bold, ),),
   subtitle: Text (' previous weight'+ weight.prevweight,
     style: TextStyle(
      ),),                     
                         
      ),
    );
  }
}*/
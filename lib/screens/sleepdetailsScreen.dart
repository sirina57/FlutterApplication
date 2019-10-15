/**

import 'package:appv1/extlib/flutter_architecture_samples.dart';
import 'package:appv1/model/models.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Food food;
  final Function onDelete;
  final Function(bool) toggleCompleted;

  DetailsScreen({
    Key key,
    @required this.food,
    @required this.onDelete,
    @required this.toggleCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.foodDetails),
        actions: [
          IconButton(
            tooltip: localizations.deleteFood,
            key: ArchSampleKeys.deleteFoodButton,
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.pop(context, food);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Checkbox(
                    value: food.favored,
                    onChanged: toggleCompleted,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: '${food.id}__heroTag',
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                            top: 8.0,
                            bottom: 16.0,
                          ),
                          child: Text(
                            food.name,
                            key: ArchSampleKeys.detailsFoodItemName,
                            style: Theme.of(context).textTheme.headline,
                          ),
                        ),
                      ),
                      Text(
                        food.serving,
                        key: ArchSampleKeys.detailsFoodItemNote,
                        style: Theme.of(context).textTheme.subhead,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.editFoodFab,
        tooltip: localizations.editFood,
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EditFood(
                  food: food,
                );
              },
            ),
          );
        },
      ),
    );
  }
} */
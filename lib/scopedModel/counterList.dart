import 'dart:async';

import 'package:appv1/scopedModel/database.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



class ScopedModelPage extends StatelessWidget {
  ScopedModelPage({this.database});
  final AppDatabase database;//dbhelper sqlite

  void _createCounter() async {
    await database.createCounter();
  }

  void _increment(Counter counter) async {
    counter.value++;
    await database.update(counter);
  }

  void _decrement(Counter counter) async {
    counter.value--;
    await database.update(counter);
  }

  void _delete(Counter counter) async {
    await database.deleteWeight(counter);
  }

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
        onPressed: _createCounter,
      ),
    );
  }

  Widget _buildContent() {
    return ScopedModelDescendant<CountersModel>(
        builder: (context, child, model) {
      return ListItemsBuilder<Counter>(
          items: model.counters,
          itemBuilder: (context, counter) {
            return CounterListTile(
              key: Key('counter-${counter.id}'),
              counter: counter,
              onDecrement: _decrement,
              onIncrement: _increment,
              onDismissed: _delete,
            );
          });
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
  CounterListTile({this.key, this.counter, this.onDecrement, this.onIncrement, this.onDismissed});
  final Key key;
  final Counter counter;
  final ValueChanged<Counter> onDecrement;
  final ValueChanged<Counter> onIncrement;
  final ValueChanged<Counter> onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: key,
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed(counter),
      child: ListTile(
        title: Text(
          '${counter.value}',
          style: TextStyle(fontSize: 48.0),
        ),
        subtitle: Text(
          '${counter.id}',
          style: TextStyle(fontSize: 16.0),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CounterActionButton(
              iconData: Icons.remove,
              onPressed: () => onDecrement(counter),
            ),
            SizedBox(width: 8.0),
            CounterActionButton(
              iconData: Icons.add,
              onPressed: () => onIncrement(counter),
            ),
          ],
        ),
      ),
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
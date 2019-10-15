
import 'package:appv1/scopedModel/counterchanged/database.dart';
import 'package:appv1/scopedModel/counterchanged/scopedPage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



class ScopedPage extends StatelessWidget {
  ScopedPage({this.database});
  final AppDatabase database;//dbhelper sqlite

void _delete(DayDiary day) async {
 
    await database.deleteDay(day);
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
         onPressed: () {
            Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (context) => ScopedModelPage()));
            },
      ),
    );
  }

  Widget _buildContent() {
    return ScopedModelDescendant<DaysModel>(
        builder: (context, child, model) {
      return ListItemsBuilder<DayDiary>(
          items: model.counters,
          itemBuilder: (context, counter) {
            return CounterListTile(
              key: Key('counter-${counter.id}'),
              counter: counter,
              onDismissed:_delete
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
  CounterListTile({this.key, this.counter,  this.onDismissed});
  final Key key;
  final DayDiary counter;

  final ValueChanged<DayDiary> onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: key,
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed(counter),
      child: ListTile(
        title: Text(
          '${counter.id}',
          style: TextStyle(fontSize: 48.0),
        ),
        subtitle: Text(
          '${counter.dinnerIds}',
          style: TextStyle(fontSize: 16.0),
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
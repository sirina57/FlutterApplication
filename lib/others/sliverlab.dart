
import 'package:flutter/material.dart';


class MySilverPage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MySilverPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final double defaultTopMargin = 256.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 96.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }
    return new Scaffold(
      body: 
          new CustomScrollView(
            controller: _scrollController,
            slivers: [
              new SliverAppBar(
                expandedHeight: 256.0,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  title: new Text("Weight Tracker"),
                  background: new Image.asset(
                    "img.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new SliverList(
                delegate: new SliverChildListDelegate(
                   new List.generate(
                    20,
                    (int index) => new ListTile(title: new Text("Item $index")),
                  ),
                 )
                  ),
                  
    //starting fab position
   new Positioned(
      top: top,
      right: 16.0,
      child: new Transform(
        transform: new Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: new FloatingActionButton(
          onPressed: () => {},
          child: new Icon(Icons.add),
        ),
      ),
    )
             ] ),
      
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 256.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 96.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return new Positioned(
      top: top,
      right: 16.0,
      child: new Transform(
        transform: new Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: new FloatingActionButton(
          onPressed: () => {},
          child: new Icon(Icons.add),
        ),
      ),
    );
  }
}
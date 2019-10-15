  import 'package:flutter/material.dart';

SliverFixedExtentList fEWaterlist(
  List<Widget> children,
 
){
    return SliverFixedExtentList(
            
            itemExtent: 100.0,
            delegate: SliverChildBuilderDelegate(
             (BuildContext context,int index  ) {
               return
              
                  new Container(
                      //padding:EdgeInsets.all(3.0),
                alignment: Alignment.center,
                     
                child: new Card(
                    color: Colors.grey[750],    
                    child:new Stack(
                      fit: StackFit.expand,
                      children: [

          Positioned(
            left: 10.0,
            top: 14.0,
            child: children[0]
            ),
          
           Positioned(
        
            left: 60.0,
           top: 15.0,
            child:children[1]
          ),
          //divider!
          new Divider( color: Colors.grey[600],),
          Positioned(
        
            left: 40.0,
           bottom: 16.0,
            child:children[2]
          ),
           Positioned(
           
            right: 16.0,
           bottom: 16.0,
           child:children[3]
          ),
       ], ),),
        );},
              childCount: 1,
            ),
          );}
        
SliverFixedExtentList fEDiarylist(
  List<Widget> children,
 
){
    return   SliverFixedExtentList(
        itemExtent: 150.0,
            delegate: SliverChildBuilderDelegate(
             (BuildContext context,int index  ) {
               return new Container(
                      //padding:EdgeInsets.all(3.0),
                alignment: Alignment.center,
                child: new Card(
                    color: Colors.grey[750],    
                    child:new Stack(
                      fit: StackFit.expand,
                      children: [
                         Positioned(
            left: 10.0,
            top: 16.0,
            child:children[0]
            ),
          

          Positioned(
            left: 60.0,
            top: 16.0,
            child:children[1]
          ),
           Positioned(
        
           right: 5.0,
           top: 10.0,
            child: FlatButton(
              onPressed: null,
              child: Icon(Icons.add),
            )
          ),
             new Divider( color: Colors.white),
         
          Positioned(
        
            left: 120.0,
           bottom: 40.0,
            child: children[2]
          ),
          Positioned(
        
            left: 120.0,
           bottom: 16.0,
            child:children[3]
          ),
           ],
                ),
            ),
     );
              },
              childCount: 1,
            ),
          );}
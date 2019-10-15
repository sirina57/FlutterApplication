import 'dart:async';

import 'package:flutter/material.dart';
 class SearchActivity extends StatelessWidget{
    Center get _buildLoading {
    return Center(
      child: CircularProgressIndicator(
        value: 10.0,
        //key: ArchSampleKeys.todosLoading,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.red,
),
body:  Center(
  child:   RefreshIndicator(
  
              child:Icon(Icons.favorite),
  
               onRefresh: () async{
  
                 _buildLoading;
  
            await new Future.delayed(const Duration(seconds: 1));
  
              },
  
  
  
            ),
) ,
    );
  }
  
 }


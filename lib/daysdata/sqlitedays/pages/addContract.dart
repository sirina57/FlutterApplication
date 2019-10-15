

import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/daysdata/sqlitedays/restData.dart';

abstract class AddPageContract {
  void onAddSuccess(DayDiary weight);
  void onAddError(String error);
}

class AddPagePresenter {
  AddPageContract _view;
  List<double> data=[];
  RestData api = new RestData();
  AddPagePresenter(this._view);
  
  doAdd( String date,int breakfast, int dinner,int lunch,int snack,String water, String weight) {
    api
        .add(date, breakfast, dinner, lunch, snack, water, weight)
        .then((day) => _view.onAddSuccess(day))
        .catchError((onError) => _view.onAddError(onError.toString()));
  }


   doGet( String date,int breakfast, int dinner,int lunch,int snack,String water, String weight) {
    api
        .add(date, breakfast, dinner, lunch, snack, water, weight)
         .then((day) => _view.onAddSuccess(day))
        .catchError((onError) => _view.onAddError(onError.toString()));
  }
}

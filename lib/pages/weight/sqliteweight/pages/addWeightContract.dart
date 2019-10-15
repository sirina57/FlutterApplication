

import 'package:appv1/pages/weight/sqliteweight/restData.dart';
import 'package:appv1/pages/weight/sqliteweight/weight.dart';

abstract class AddWeightPageContract {
  void onAddSuccess(Weight weight);
  void onAddError(String error);
}

class AddWeightPagePresenter {
  AddWeightPageContract _view;
  List<double> data=[];
  RestData api = new RestData();
  AddWeightPagePresenter(this._view);
  
  doAdd(String prevweight, String newweight,String date) {
    api
        .add(prevweight, newweight,date)
        .then((weight) => _view.onAddSuccess(weight))
        .catchError((onError) => _view.onAddError(onError.toString()));
  }
}
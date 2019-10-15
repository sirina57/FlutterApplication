

import 'package:appv1/pages/water/restData.dart';
import 'package:appv1/pages/water/water.dart';

abstract class AddWaterPageContract {
  void onAddSuccess(Water water);
  void onAddError(String error);
}

class AddWaterPagePresenter {
  AddWaterPageContract _view;
  List<double> data=[];
  RestData api = new RestData();
  AddWaterPagePresenter(this._view);
  
  doAdd(bool achieved ,int intake,int goalIntake ,String note) {
    api
        .add(achieved,intake, goalIntake, note,)
        .then((water) => _view.onAddSuccess(water))
        .catchError((onError) => _view.onAddError(onError.toString()));
  }
}
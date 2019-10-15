import 'dart:async';

import 'package:appv1/daysdata/sqlitedays/dbHelper.dart';
import 'package:appv1/daysdata/sqlitedays/pages/model.dart';
import 'package:appv1/pages/weight/sqliteweight/networkUtil.dart';
import 'package:appv1/pages/weight/sqliteweight/weight.dart';


/**
class RestData {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<Weight> add(String prevweight, String newweight,String date) {
    return new Future.value(new Weight(prevweight, newweight,date));
  }
} */


class RestData {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<DayDiary> add(String date ,int breakfast,int lunch,int dinner,int snack,String water,String weight) {
   
    return new Future.value(new DayDiary( date,breakfast, lunch, dinner, snack, water, weight));
  }
   Future<List<String>> getDay(DayDiary day) {
   
    return new Future.value( [day.date,day.breakfastIds.toString(),day.lunchIds.toString(),day.dinnerIds.toString(),day.snackIds.toString(),day.waterIntake,day.weight]);
  }
  
  Future<DayDiary> update(int id,String val){
      var db = new AppDatabase();
     DayDiary oldDay;
    
     
  var res=  Future.value(db.getDay(id)).then((day)=>oldDay=day).then((onValu)=>DayDiary(oldDay.date,oldDay.breakfastIds, oldDay.lunchIds, oldDay.dinnerIds, oldDay.snackIds, oldDay.waterIntake, oldDay.weight +'*'+val)) ;
  print('$res');
  
  return res;
  // return  Future.value(DayDiary( oldDay.id,oldDay.breakfastIds, oldDay.lunchIds, oldDay.dinnerIds, oldDay.snackIds, oldDay.waterIntake, oldDay.weight+val));
  }
   Future<DayDiary> updateBreakfast(DayDiary day,String val){
    String value = val +day.breakfastIds.toString();
    print('value : $value');
   return  Future.value(DayDiary(day.date,int.parse(value), day.lunchIds, day.dinnerIds, day.snackIds, day.waterIntake, day.weight));
   }
 Future<DayDiary> updateLunch(DayDiary day,String val){
    String value = val +day.lunchIds.toString();
    print('value : $value');
    return  Future.value(DayDiary(
     day.date, day.breakfastIds,int.parse(value), day.dinnerIds, day.snackIds, day.waterIntake, day.weight));
   }
 Future<DayDiary> updateDinner(DayDiary day,String val){
    String value = val +day.dinnerIds.toString();
    print('value : $value');
   return  Future.value(DayDiary( day.date,day.breakfastIds, day.lunchIds,int.parse(value), day.snackIds, day.waterIntake, day.weight));
   }
 Future<DayDiary> updateSnack(DayDiary day,String val){
    String value = val +day.snackIds.toString();
    print('value : $value');
   return  Future.value(DayDiary( day.date,day.breakfastIds , day.lunchIds, day.dinnerIds, int.parse(value), day.waterIntake, day.weight));
   }
}

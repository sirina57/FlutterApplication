
import 'package:scoped_model/scoped_model.dart';

class DataModel extends Model {
  List<DateTime> _weightsEntry = [];
  List<DateTime> get weightsEntry => _weightsEntry;
   List<DateTime> _sleepEntrys = [];
  List<DateTime> get sleepEntrys => _sleepEntrys;

  

  void deleteItem(DateTime item) {
    _weightsEntry.remove(item);
    notifyListeners();
  }
   
void data(DateTime item){
     _weightsEntry.add(item);
    notifyListeners();
 }
  

  void deleteSItem(DateTime item) {
    _sleepEntrys.remove(item);
    notifyListeners();
  }
   
 void sleepdata(DateTime item){
  
   _sleepEntrys.add(item);
   notifyListeners();
  
  
 }
}
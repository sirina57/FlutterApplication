
import 'package:appv1/entities/foodEntity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
@immutable
class Fact {
  final String fat;
  final String carbohydrates;
  final String protein;
  Fact({ this.fat,this.carbohydrates,this.protein});


  factory Fact.fromJson(Map<String, dynamic> parsedJson){
 return Fact(
   fat:parsedJson['Fat'],
   protein:parsedJson['Carbohydrates'],
   carbohydrates:parsedJson['Protein']
 );
}
}
@immutable
class Food{
  final String id;
 final  String name;
 final  String serving;
  final  String calories;
  final bool favored;
  //final  String servingSize;
//  final  String rank;
  //final  List<Fact> nutritionalFacts;
  
Food(
this.name,{this.favored =false,String calories='', String serving='',String id})
:this.serving=serving ?? '',
this.calories =calories ?? '',
this.id=id ?? Uuid().v4();
Food copyWith({String id,String name,String serving,String calories,bool favored})
  {
  return Food(
  name?? this.name,
  calories:calories?? this.calories,
 serving: serving?? this.serving,
  id:  id ?? this.id,
  );
}

@override
int get hashCode => favored.hashCode^serving.hashCode^name.hashCode^id.hashCode^calories.hashCode;

@override
bool operator ==(Object other) =>
identical(this, other) ||
this.runtimeType == other.runtimeType &&
other is Food &&
name == other.name &&
serving== other.serving &&
id == other.id &&
favored == other.favored &&
calories == other.calories;

@override
  String toString() {
    return 'Food{ recent:$favored,name:$name,calories:$calories,serving:$serving,id:$id}';
  }
FoodEntity toEntity(){
  return FoodEntity(name, serving, id, calories, favored);
}

static Food fromEntity(FoodEntity entity)
{
  return Food(
    entity.name,
   calories: entity.calories,
  favored:entity.favored ?? false,
    serving: entity.serving,
    id: entity.id ?? Uuid().v4(),

  );
} 


}

/*
  factory Food.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['Nutritional_facts']  as List;
    print(list.runtimeType);
    List<Fact> factsList = list.map((i) => Fact.fromJson(i)).toList();


    return Food(
      id: parsedJson['id'],
      name: parsedJson['name'],
     calories: parsedJson['calories'],
     serving:  parsedJson['serving'],
     servingSize:  parsedJson['serving_size'],
     nutritionalFacts: factsList,
     rank:  parsedJson['rank'],

    );
  }
}*/

  /*Map<String,dynamic> toMap(){
    var map =  Map<String,dynamic>();
   map["name"]= name ;
   map["serving"]=serving ;
   map["calories"] =calories ;
   map["serving_size"]=serving_size;
   map["rank"]=rank;
   map["Nutritional_facts"]= nutritional_facts;
   map['favored'] = favored;
    return map;
  }
  
  Food.fromDb(Map map) : name= map["name"],
   serving= map["serving"],
   calories=
   map["calories"],
   serving_size =
   map["serving_size"],
   rank=
   map["rank"],
   nutritional_facts=
   map["Nutritional_facts"],
   favored=
   map['favored'] ==1 ? true :false;*/
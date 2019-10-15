class FoodEntity{
 final String id;
 final  String name;
 final  String serving;
  final  String calories;
  final bool favored;
FoodEntity(this.name,this.serving,this.id,this.calories,this.favored);


@override
int get hashCode => favored.hashCode^serving.hashCode^name.hashCode^id.hashCode^calories.hashCode;

@override
bool operator ==(Object other) =>
identical(this, other) ||
this.runtimeType == other.runtimeType &&
other is FoodEntity &&
name == other.name &&
serving== other.serving &&
id == other.id &&
favored == other.favored &&
calories == other.calories;

@override
  String toString() {
    return 'FoodEntity{ recent:$favored,name:$name,calories:$calories,serving:$serving,id:$id}';
  }

Map<String,Object> toJson(){
    return {
      
    "name": name,
    "id": id,
     "serving" :serving, 
    " calories": calories,
  };
  }




  static FoodEntity fromJson(Map<String,Object> json){
    return FoodEntity(json["name"] as String,json["id"] as String,json["serving"] as String,json["calories"] as String,json["favored"] as bool, );
  }
}
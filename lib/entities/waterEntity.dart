class WaterEntity{
  final String id;
  final bool achieved;
  final String intake;
  final String goalIntake;
  final String note;

WaterEntity(
this.intake,this.id,this.note,this.achieved,this.goalIntake);

@override
int get hashCode => achieved.hashCode^note.hashCode^intake.hashCode^id.hashCode^goalIntake.hashCode;



@override
bool operator ==(Object other) =>
identical(this, other) ||
this.runtimeType == other.runtimeType &&
other is WaterEntity &&
intake == other.intake &&
goalIntake == other.goalIntake &&
achieved == other.achieved &&
id == other.id &&
note == other.note;

@override
  String toString() {
    return 'FoodEntity{ achieved:$achieved,name:$intake,goal intake:$goalIntake,note:$note,id:$id}';
  }


Map<String,Object> toJson(){
    return {
      "achieved": achieved,
      "intake": intake,
      "goal_intake": goalIntake,
      "note": note,
      "id": id,

    };
  }




  static WaterEntity fromJson(Map<String,Object> json){
    return WaterEntity(json["intake"] as String,json["id"] as String,json["note"] as String, json["achieved"] as bool,json["goal_intake"] as String );
  }
}
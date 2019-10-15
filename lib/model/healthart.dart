import 'package:uuid/uuid.dart';

class Article{
  final String id;
  final bool achieved;
  final String title;
  final String current;
  final String description;
Article( 
{this.achieved =false, String description='',String id, String current='', String title=''})
:this.description=description ?? '',
this.current=current ?? '',
this.title=title ?? '',
this.id=id ?? Uuid().v4();
@override
int get hashCode => achieved.hashCode^description.hashCode^title.hashCode^id.hashCode^current.hashCode;

Article.fromJsonMap(Map map)
      : id = map['id'],
      title = map['title'],
       current = map['current'],
        description = map['description'];

@override
bool operator ==(Object other) =>
identical(this, other) ||
this.runtimeType == other.runtimeType &&
other is Article &&
title == other.title &&
current == other.current &&
achieved == other.achieved &&
id == other.id &&
description == other.description;

@override
  String toString() {
    return 'Food{ recent:$achieved,name:$title,goal intake:$current,note:$description,id:$id}';
  }


Article copyWith({String id,String achieved ,String name,String goalIntake ,String note})
  {
  return Article(
  title:name?? this.title,
  current:goalIntake??this.current,
  achieved:  achieved?? this.achieved,
  id:  id ?? this.id,
  description: note ?? this.description,
  );
}

}
final health =[
  Article(
 id :"1",
  achieved:true,
  title :"ideal body weight (IBW)",
 current :"57.5",
 description:"the weight statistically determined on actuarial tables to be associated with the lowest mortality for an average individual, adjusting for some combination of height, age, frame size, and gender. Which factors should be included and how it should be determined remain controversial.",),
   Article(
 id :"2",
  achieved:true,
  title :"BMI ( Body Mass index)",
 current :"",
 description:" ou IMC (Indice de Masse Corporelle).Le BMI est une mesure pour évaluer le poids corporel chez l’adulte.Cette formule de calcul n’est pas applicable pour les enfants, la femme enceinte ni pour les personnes âgées de plus de 65 ans. Underweight = <18.5   Normal weight = 18.5 to 24.9 Overweight = 25 to 29.9 Obesity = BMI of 30 or greater",)
];

class Food {
  final String title;
  final String serving;
  final int calories;
   final String fat;
  final String protein;
  final String carbohydrates;

  Food.fromJsonMap(Map map)
      : title = map['title'],
      serving = map['serving'],
        calories = map['calories'],
         fat = map['fat'],
          protein = map['protein'],
        carbohydrates = map['carbohydrates'];
}

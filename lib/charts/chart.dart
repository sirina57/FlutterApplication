import 'package:appv1/pages/weight/sqliteweight/weight.dart';
import 'package:flutter/material.dart';

class ProgressChart extends StatelessWidget {
  static const int NUMBER_OF_DAYS = 31;
  final List<Weight> entries;

  ProgressChart(this.entries);

  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
    //  painter: new ChartPainter(_prepareEntryList(entries)),
    );
  }

  List<Weight> _prepareEntryList(List<Weight> initialEntries) {
   DateTime beginningDate;// = _getStartDateOfChart();
    List<Weight> entries = initialEntries
        .where((entry) => entry.entryDate.isAfter(beginningDate))
        .toList();
    
    return entries;
  }
}
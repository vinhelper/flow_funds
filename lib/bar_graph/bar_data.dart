import 'package:flow_funds/bar_graph/individual_bar.dart';

class BarData {
  // final double food;
  // final double util;
  // final double travel;
  // final double personal;

  final List<double> categoryExpenses;

  List<IndividualBar> barData = [];

  BarData({required this.categoryExpenses});

  void initializeData() {
    barData =
        categoryExpenses
            .map((category) => IndividualBar(x: 0, y: category))
            .toList();
  }
}

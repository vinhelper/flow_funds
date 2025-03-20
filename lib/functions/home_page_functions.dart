import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_funds/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void signOut() async {
  await FirebaseAuth.instance.signOut();
}

Map<String, List<Expense>> groupExpensesByMonth(List<Expense> expenses) {
  Map<String, List<Expense>> groupedExpenses = {};

  for (var expense in expenses) {
    String monthYear = DateFormat('yyyy-MM').format(expense.date);
    if (!groupedExpenses.containsKey(monthYear)) {
      groupedExpenses[monthYear] = [];
    }
    groupedExpenses[monthYear]!.add(expense);
  }

  return groupedExpenses;
}

Widget getHeaderTile(String selectedFilter, String categoryKey) {
  switch (selectedFilter) {
    case "By Category":
      return Text(
        categoryKey,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
    case "By Month":
      return Text(
        categoryKey,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
    default:
      return Text(
        "All Expenses ${selectedFilter.contains("highest") ? "(descending)" : "(ascending)"}",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
  }
}

void showEntryDetailsModal(BuildContext context, Expense expense) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Expense Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Title: ${expense.title}'),
              Text('Category: ${expense.categoryId}'),
              Text('Amount: Php ${expense.amount}'),
              Text('Date: ${DateFormat('MM/dd/yyyy').format(expense.date)}'),
              Text('Notes: ${expense.note ?? "N/A"}'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

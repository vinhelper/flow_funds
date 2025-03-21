import 'package:flow_funds/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageFilter extends StatefulWidget {
  const HomePageFilter({super.key});

  @override
  State<HomePageFilter> createState() => _HomePageFilterState();
}

class _HomePageFilterState extends State<HomePageFilter> {
  List<String> filters = [
    "By Month",
    "By Category",
    "Sort from highest amount",
    "Sort from lowest amount",
  ];
  String? _selectedFilter = "By Month";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade500, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
        icon: Icon(Icons.tune),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        isExpanded: true,
        underline: Container(),
        value: _selectedFilter,
        hint: const Text('Select a filter'),
        items:
            filters.map((filter) {
              return DropdownMenuItem(
                value: filter,
                child: Text(filter, softWrap: true),
              );
            }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedFilter = newValue;
            context.read<ExpenseProvider>().changeFilter(newValue!);
          });
        },
      ),
    );
  }
}

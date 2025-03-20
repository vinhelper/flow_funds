import 'package:flutter/material.dart';

class HomePageFilter extends StatefulWidget {
  const HomePageFilter({super.key});

  @override
  State<HomePageFilter> createState() => _HomePageFilterState();
}

class _HomePageFilterState extends State<HomePageFilter> {
  List<String> filters = ["Month", "Year", "Category"];
  String? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade500, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
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
          });
        },
      ),
    );
  }
}

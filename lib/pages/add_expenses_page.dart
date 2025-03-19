import 'package:flow_funds/models/category_model.dart';
import 'package:flow_funds/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddExpensesPage extends StatefulWidget {
  const AddExpensesPage({super.key});

  @override
  State<AddExpensesPage> createState() => _AddExpensesPageState();
}

class _AddExpensesPageState extends State<AddExpensesPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedValue;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categories = context.watch<CategoryProvider>().categories;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense", style: TextStyle(fontSize: 20)),
        centerTitle: true,
        backgroundColor: Color(0xFF48C9B3),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          DropdownButton(
            value: _selectedValue,
            hint: const Text('Select an option'),
            items:
                categories.map((category) {
                  return DropdownMenuItem(
                    value: category.name,
                    child: Text(category.name),
                  );
                }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedValue = newValue;
              });
            },
          ),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(labelText: 'Date'),
            readOnly: true,
            onTap: () => _selectDate(context),
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: "Amount"),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
            ],
          ),
          TextField(
            controller: notesController,
            decoration: const InputDecoration(labelText: "Notes"),
            minLines: 1,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

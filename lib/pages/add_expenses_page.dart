import 'package:flow_funds/models/category_model.dart';
import 'package:flow_funds/models/expense_model.dart';
import 'package:flow_funds/providers/category_provider.dart';
import 'package:flow_funds/providers/expense_provider.dart';
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
  String? _selectedCategory;
  bool _showError = false;

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
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 14.0, left: 14.0, right: 14),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text(
                  "Title",
                  style: TextStyle(color: Color.fromRGBO(54, 69, 79, 0.8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2, color: Colors.grey.shade500),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2, color: Colors.black),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),

            SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade500, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 2,
                      ),
                      isExpanded: true,
                      underline: Container(),
                      value: _selectedCategory,
                      hint: const Text('Select a category'),
                      items:
                          categories.map((category) {
                            return DropdownMenuItem(
                              value: category.name,
                              child: Text(category.name),
                            );
                          }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 14),

            TextField(
              controller: dateController,
              decoration: InputDecoration(
                label: Text(
                  "Select date",
                  style: TextStyle(color: Color.fromRGBO(54, 69, 79, 0.8)),
                ),
                suffixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2, color: Colors.grey.shade500),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2, color: Colors.black),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),

            SizedBox(height: 14),

            TextField(
              controller: amountController,
              decoration: InputDecoration(
                label: Text(
                  "Amount",
                  style: TextStyle(color: Color.fromRGBO(54, 69, 79, 0.8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2, color: Colors.grey.shade500),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2, color: Colors.black),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                floatingLabelStyle: TextStyle(
                  color: Color(0xFF2C3E50),
                  fontSize: 16,
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
            ),

            SizedBox(height: 14),

            TextField(
              controller: notesController,
              decoration: InputDecoration(
                label: Text(
                  "Notes (optional)",
                  style: TextStyle(color: Color.fromRGBO(54, 69, 79, 0.8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2, color: Colors.grey.shade500),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2, color: Colors.black),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                floatingLabelStyle: TextStyle(
                  color: Color(0xFF2C3E50),
                  fontSize: 16,
                ),
              ),
              minLines: 1,
              maxLines: 2,
            ),

            SizedBox(height: 14),

            if (_showError)
              Column(
                children: [
                  Text(
                    "*Please fill up all fields",
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 14),
                ],
              ),

            FilledButton.tonal(
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                if (titleController.text.isEmpty ||
                    amountController.text.isEmpty ||
                    _selectedCategory == null ||
                    _selectedDate.toString().isEmpty) {
                  setState(() {
                    _showError = true;
                  });

                  await Future.delayed(Duration(seconds: 2));

                  setState(() {
                    _showError = false;
                  });
                } else {
                  final expense = Expense(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text.trim(),
                    amount: double.parse(amountController.text.trim()),
                    categoryId: _selectedCategory!,
                    date: _selectedDate!,
                  );
                  context.read<ExpenseProvider>().addExpense(expense);
                  Navigator.pop(context);
                }
              },
              child: Text("Add Expense"),
            ),
          ],
        ),
      ),
    );
  }
}

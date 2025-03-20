import 'package:flow_funds/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstorage/localstorage.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;
  bool _isLoading = false;
  String _selectedFilter = "By Month";

  bool get isLoading => _isLoading;
  String get selectedFilter => _selectedFilter;

  Future<void> loadExpenses() async {
    String? uid = localStorage.getItem("uid");
    try {
      _isLoading = true;
      _selectedFilter = "By Month";
      DocumentSnapshot docs =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (docs.exists) {
        var collectionData = docs.data() as Map<String, dynamic>;
        if (collectionData.containsKey('expenses')) {
          List<dynamic> storedExpenses = docs.get('expenses');
          _expenses =
              storedExpenses.map((item) => Expense.fromJson(item)).toList();
        } else {
          _expenses = [];
        }
        notifyListeners();
      } else {
        _expenses = [];
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error loading expenses: $e");
      _isLoading = false;
      _expenses = []; // Ensure expenses are empty on error
      notifyListeners();
    }
  }

  void changeFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void _saveExpenses() async {
    String? uid = localStorage.getItem("uid");
    List jsonList = _expenses.map((expense) => expense.toJson()).toList();
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "expenses": jsonList,
    }, SetOptions(merge: true));
  }

  void addExpense(Expense item) {
    _expenses.add(item);
    _expenses.sort((item1, item2) => item2.date.compareTo(item1.date));
    _saveExpenses();
    notifyListeners();
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    _saveExpenses();
    notifyListeners();
  }
}

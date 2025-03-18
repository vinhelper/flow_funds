import 'package:flow_funds/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstorage/localstorage.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  CategoryProvider() {
    loadCategories();
  }

  Future<void> loadCategories() async {
    String? uid = localStorage.getItem("uid");
    DocumentSnapshot docs =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if (docs.exists) {
      _isLoading = true;
      notifyListeners();
      var data = docs.data() as Map<String, dynamic>;
      if (data.containsKey("categories")) {
        List<dynamic> storedCategories = docs.get("categories");
        _categories =
            storedCategories.map((item) => Category.fromJson(item)).toList();
      } else {
        _categories = [];
      }
      _isLoading = false;
      notifyListeners();
    } else {
      _categories = [];
    }
  }

  void _saveCategories() async {
    String? uid = localStorage.getItem("uid");
    List jsonList = _categories.map((category) => category.toJson()).toList();
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "categories": jsonList,
    }, SetOptions(merge: true));
  }

  void addCategory(Category item) {
    if (_categories.any((category) => category.name == item.name)) {
      print("Category already exists");
      return;
    }
    _categories.add(item);
    _saveCategories();
    notifyListeners();
  }

  void deleteCategory(String id) {
    _categories.removeWhere((category) => category.id == id);
    _saveCategories();
    notifyListeners();
  }
}

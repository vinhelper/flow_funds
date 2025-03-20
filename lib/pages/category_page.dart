import 'package:flow_funds/models/category_model.dart';
import 'package:flow_funds/providers/category_provider.dart';
import 'package:flow_funds/shared/loading_icon_dialog.dart';
import 'package:flow_funds/shared/on_boarding_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController categoryController = TextEditingController();
  late AnimationController iconController;
  bool _isDialogShowing = false;

  @override
  void dispose() {
    categoryController.dispose();
    iconController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Categories", style: TextStyle(fontSize: 20)),
        centerTitle: true,
        backgroundColor: Color(0xFF48C9B3),
        elevation: 0,
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && !_isDialogShowing) {
            _isDialogShowing = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconRotationTransition(controller: iconController),
                            SizedBox(height: 10),
                            const Text(
                              'Loading...',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            });
          } else {
            if (mounted && _isDialogShowing) {
              _isDialogShowing = false;
              Navigator.of(context).pop();
            }
          }

          if (provider.categories.isNotEmpty) {
            return ListView.builder(
              itemCount: provider.categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 10,
                    right: 10,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 24, right: 10),
                    title: Text(
                      provider.categories[index].name,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: Color.fromRGBO(72, 201, 179, 0.2),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent[400]),
                      onPressed: () {
                        context.read<CategoryProvider>().deleteCategory(
                          provider.categories[index].id,
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Click + to add recent category for your expenses",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddCategoryDialog(context, categoryController);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void showAddCategoryDialog(
  BuildContext context,
  TextEditingController categoryController,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text("Add Category", style: TextStyle(color: Color(0xFF2C3E50))),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OnBoardingTextField(
              inputLabel: "Category",
              inputObscureText: false,
              // inputIcons: Icon(Icons.add),
              inputController: categoryController,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton.tonal(
                  onPressed: () {
                    categoryController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                SizedBox(width: 10),
                FilledButton(
                  onPressed: () {
                    final category = Category(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: categoryController.text.trim(),
                    );
                    context.read<CategoryProvider>().addCategory(category);
                    categoryController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

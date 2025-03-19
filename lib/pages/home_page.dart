import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_funds/pages/add_expenses_page.dart';
import 'package:flow_funds/pages/category_page.dart';
import 'package:flow_funds/providers/expense_provider.dart';
import 'package:flow_funds/shared/loading_icon_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController iconController;
  bool _isDialogShowing = false;

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void dispose() {
    iconController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      drawer: Drawer(
        backgroundColor: Color(0xFF48C9B3),
        child: Column(
          children: [
            SizedBox(height: 22),
            Container(
              height: 140,
              padding: EdgeInsets.only(left: 22),
              alignment: Alignment.centerLeft,
              child: Text(
                "Menu",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFF2C3E50),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Divider(color: Colors.black, thickness: 2),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 22),
                      title: Text(
                        "Manage Categories",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      leading: Icon(Icons.category, color: Color(0xFF2C3E50)),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(),
                          ),
                        );
                      },
                    ),

                    ListTile(
                      contentPadding: EdgeInsets.only(left: 22),
                      title: Text(
                        "Sign Out",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      leading: Icon(
                        Icons.logout_outlined,
                        color: Color(0xFF2C3E50),
                      ),
                      onTap: signOut,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Consumer<ExpenseProvider>(
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

          if (provider.expenses.isNotEmpty) {
            return Text("Not Empty");
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Click + to add recent expenses and monitor them",
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
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddExpensesPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

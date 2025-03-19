import 'package:flow_funds/pages/home_page.dart';
import 'package:flow_funds/pages/login_or_register.dart';
import 'package:flow_funds/providers/category_provider.dart';
import 'package:flow_funds/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            localStorage.setItem("uid", snapshot.data!.uid);
            Provider.of<CategoryProvider>(
              context,
              listen: false,
            ).loadCategories();
            Provider.of<ExpenseProvider>(context, listen: false).loadExpenses();

            return HomePage();
          } else {
            return LoginOrRegister(initialHasAccount: true);
          }
        },
      ),
    );
  }
}

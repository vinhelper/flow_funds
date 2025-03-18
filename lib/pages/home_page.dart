import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_funds/pages/category_page.dart';
import 'package:flow_funds/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
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

            Column(
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
                      MaterialPageRoute(builder: (context) => CategoryPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                signOut(context);
              },
              child: Text("Sign Out"),
            ),
          ),
        ],
      ),
    );
  }
}

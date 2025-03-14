import 'package:flow_funds/pages/login_page.dart';
import 'package:flow_funds/pages/register_page.dart';
import 'package:flutter/material.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(169, 204, 227, 1),
      body: Column(
        children: [
          Expanded(flex: 1, child: SizedBox()),
          //display logo
          Expanded(
            flex: 4,
            child: Image.asset("assets/images/flow_funds_logo_bg.png"),
          ),

          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //message
                Column(
                  children: [
                    const Text(
                      "Welcome to FlowFunds",
                      style: TextStyle(
                        color: Color.fromRGBO(54, 69, 79, 0.8),
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "Find your financial peace",
                      style: TextStyle(
                        color: Color.fromRGBO(54, 69, 79, 0.8),
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                //buttons
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF48C9B3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (BuildContext context) =>
                                            (RegisterPage()),
                                  ),
                                );
                              },
                              child: Text(
                                "GET STARTED",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E50),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        bottom: 40,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (BuildContext context) => (LoginPage()),
                                  ),
                                );
                              },
                              child: Text(
                                "I ALREADY HAVE AN ACCOUNT",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

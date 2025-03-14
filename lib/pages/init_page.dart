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
                                backgroundColor: Color.fromRGBO(
                                  12,
                                  192,
                                  223,
                                  1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed:
                                  () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (BuildContext context) =>
                                              (RegisterPage()),
                                    ),
                                  ),
                              child: const Text(
                                "GET STARTED",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 66, 73, 1),
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
                                backgroundColor: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {
                                // Button 1 action
                              },
                              child: const Text(
                                "I ALREADY HAVE AN ACCOUNT",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 151, 167, 1),
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

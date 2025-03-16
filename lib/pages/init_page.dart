import 'package:flow_funds/pages/login_page.dart';
import 'package:flow_funds/pages/register_page.dart';
import 'package:flow_funds/shared/on_boarding_button.dart';
import 'package:flutter/material.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 1, child: SizedBox()),
          //display logo
          Expanded(
            flex: 4,
            child: Image.asset("assets/images/flow_funds_logo_bg2.png"),
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
                      child: OnBoardingButton(
                        buttonColor: Color(0xFF48C9B3),
                        buttonText: Text(
                          "GET STARTED",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        buttonPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (BuildContext context) => (RegisterPage()),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        bottom: 40,
                      ),
                      child: OnBoardingButton(
                        buttonText: Text(
                          "I ALREADY HAVE AN ACCOUNT",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        buttonColor: Colors.white,
                        buttonPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
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

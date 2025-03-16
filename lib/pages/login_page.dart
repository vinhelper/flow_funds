import 'package:flow_funds/pages/register_page.dart';
import 'package:flow_funds/shared/on_boarding_button.dart';
import 'package:flow_funds/shared/on_boarding_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 12),

              Image.asset("assets/images/flow_funds_logo_bg2.png"),

              Text(
                "Sign in to FlowFunds",
                style: TextStyle(
                  color: Color(0xFF292828),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              OnBoardingTextField(
                inputLabel: "Email",
                inputObscureText: false,
                inputIcons: Icon(
                  Icons.person_outline,
                  color: Color(0xFF2C3E50),
                ),
              ),

              SizedBox(height: 10),

              OnBoardingTextField(
                inputLabel: "Password",
                inputObscureText: true,
                inputIcons: Icon(
                  Icons.vpn_key_outlined,
                  color: Color(0xFF2C3E50),
                ),
              ),

              SizedBox(height: 14),

              OnBoardingButton(
                buttonColor: Color(0xFF48C9B3),
                buttonText: Text(
                  "SIGN IN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                buttonPressed: () {},
              ),

              SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Color(0xFF2C3E50)),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 2),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text("Register here"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

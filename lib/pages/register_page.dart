import 'package:flow_funds/pages/login_page.dart';
import 'package:flow_funds/shared/on_boarding_button.dart';
import 'package:flow_funds/shared/on_boarding_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Let's create an account for you",
                  style: TextStyle(
                    color: Color(0xFF292828),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            OnBoardingTextField(
              inputLabel: "Email",
              inputObscureText: false,
              inputIcons: Icon(Icons.person_outline, color: Color(0xFF2C3E50)),
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

            SizedBox(height: 10),

            OnBoardingTextField(
              inputLabel: "Confirm Password",
              inputObscureText: true,
              inputIcons: Icon(
                Icons.vpn_key_outlined,
                color: Color(0xFF2C3E50),
              ),
            ),

            SizedBox(height: 30),

            OnBoardingButton(
              buttonColor: Color(0xFF48C9B3),
              buttonText: Text(
                "SIGN UP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              buttonPressed: () {},
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account? ",
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
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text("Login now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

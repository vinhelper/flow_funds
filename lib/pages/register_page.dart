import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_funds/shared/on_boarding_button.dart';
import 'package:flow_funds/shared/on_boarding_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;

  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool _isLoading = false;

  String errorMessage = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void signup() async {
    if (passwordController.text.trim() != confirmController.text.trim()) {
      passwordController.clear();
      confirmController.clear();

      setState(() {
        errorMessage = "Password do not match";
      });

      await Future.delayed(Duration(seconds: 2));
      setState(() {
        errorMessage = "";
      });

      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (error) {
      emailController.clear();
      passwordController.clear();
      confirmController.clear();
      setState(() {
        errorMessage = error.message ?? "An unknown error occurred.";
        _isLoading = false;
      });

      await Future.delayed(Duration(seconds: 2));
      setState(() {
        errorMessage = "";
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

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
              inputController: emailController,
            ),

            SizedBox(height: 10),

            OnBoardingTextField(
              inputLabel: "Password",
              inputObscureText: true,
              inputIcons: Icon(
                Icons.vpn_key_outlined,
                color: Color(0xFF2C3E50),
              ),
              inputController: passwordController,
            ),

            SizedBox(height: 10),

            OnBoardingTextField(
              inputLabel: "Confirm Password",
              inputObscureText: true,
              inputIcons: Icon(
                Icons.vpn_key_outlined,
                color: Color(0xFF2C3E50),
              ),
              inputController: confirmController,
            ),

            if (errorMessage != "")
              Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red[600]),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            SizedBox(height: 20),

            OnBoardingButton(
              buttonColor:
                  _isLoading
                      ? Color.fromRGBO(72, 201, 179, 0.5)
                      : Color(0xFF48C9B3),
              buttonText: Text(
                _isLoading ? "Loading..." : "SIGN UP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              buttonPressed: signup,
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
                  onPressed: widget.togglePage,
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

import 'package:flow_funds/shared/on_boarding_button.dart';
import 'package:flow_funds/shared/on_boarding_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePage;

  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  String errorMessage = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (error) {
      emailController.clear();
      passwordController.clear();
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

              SizedBox(height: 14),

              if (errorMessage != "")
                Column(
                  children: [
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
                    SizedBox(height: 14),
                  ],
                ),

              OnBoardingButton(
                buttonColor:
                    _isLoading
                        ? Color.fromRGBO(72, 201, 179, 0.5)
                        : Color(0xFF48C9B3),
                buttonText: Text(
                  _isLoading ? "Loading..." : "SIGN IN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                buttonPressed: signin,
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
                    onPressed: widget.togglePage,
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

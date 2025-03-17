import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_funds/shared/loading_icon_dialog.dart';
import 'package:flow_funds/shared/on_boarding_button.dart';
import 'package:flow_funds/shared/on_boarding_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;

  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  late AnimationController iconController;

  String errorMessage = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
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

    final isMounted = mounted;
    showIconDialog(context);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (isMounted) {
        Navigator.of(context).pop();
        setState(() {
          errorMessage = "";
        });
      }
    } on FirebaseAuthException catch (error) {
      emailController.clear();
      passwordController.clear();
      confirmController.clear();
      if (isMounted) {
        // Check if the widget is still mounted
        Navigator.of(context).pop();
        setState(() {
          errorMessage = error.message ?? "An unknown error occurred.";
        });

        await Future.delayed(Duration(seconds: 2));
        setState(() {
          errorMessage = "";
        });
      }
    }
  }

  void showIconDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
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
              buttonColor: Color(0xFF48C9B3),
              buttonText: Text(
                "SIGN UP",
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

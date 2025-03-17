import 'package:flow_funds/pages/init_page.dart';
import 'package:flow_funds/pages/login_page.dart';
import 'package:flow_funds/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginOrRegister extends StatefulWidget {
  final bool initialHasAccount;

  const LoginOrRegister({super.key, required this.initialHasAccount});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  late Future<bool> _isFirstLaunch;
  late bool hasAccount;

  bool toggleClicked = false;

  void togglePages() {
    setState(() {
      hasAccount = !hasAccount;
      toggleClicked = true;
    });
  }

  @override
  void initState() {
    super.initState();
    hasAccount = widget.initialHasAccount;
    _isFirstLaunch = isFirstLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _isFirstLaunch,
        builder: (context, futureSnapShot) {
          if (futureSnapShot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          } else if (futureSnapShot.hasError) {
            return Text('Error: ${futureSnapShot.error}');
          } else {
            final isFirstLaunchResult = futureSnapShot.data ?? false;

            if (isFirstLaunchResult && !toggleClicked) {
              return InitPage(togglePage: togglePages);
            } else {
              if (hasAccount) {
                return LoginPage(togglePage: togglePages);
              } else {
                return RegisterPage(togglePage: togglePages);
              }
            }
          }
        },
      ),
    );
  }
}

Future<bool> isFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('firstLaunch') ?? true;

  if (isFirstLaunch) {
    await prefs.setBool('firstLaunch', false);
    return true;
  }
  return false;
}

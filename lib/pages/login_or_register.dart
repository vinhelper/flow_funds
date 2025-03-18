import 'package:flow_funds/pages/init_page.dart';
import 'package:flow_funds/pages/login_page.dart';
import 'package:flow_funds/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class LoginOrRegister extends StatefulWidget {
  final bool initialHasAccount;

  const LoginOrRegister({super.key, required this.initialHasAccount});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  late bool _isFirstLaunch;
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
    if (_isFirstLaunch && !toggleClicked) {
      return InitPage(togglePage: togglePages);
    } else {
      if (hasAccount) {
        return LoginPage(togglePage: togglePages);
      } else {
        return RegisterPage(togglePage: togglePages);
      }
    }
  }
}

bool isFirstLaunch() {
  final firstLaunch = localStorage.getItem('firstLaunch');

  if (firstLaunch == null || firstLaunch == 'true') {
    localStorage.setItem('firstLaunch', 'false');
    return true;
  }
  return false;
}

import 'package:flutter/material.dart';

class OnBoardingTextField extends StatelessWidget {
  final bool inputObscureText;
  final String inputLabel;
  final Icon? inputIcons;
  final TextEditingController inputController;

  const OnBoardingTextField({
    super.key,
    required this.inputLabel,
    required this.inputObscureText,
    this.inputIcons,
    required this.inputController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(
          inputLabel,
          style: TextStyle(color: Color.fromRGBO(54, 69, 79, 0.8)),
        ),
        prefixIcon: inputIcons,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2, color: Colors.grey.shade500),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2, color: Colors.black),
        ),
        floatingLabelStyle: TextStyle(color: Color(0xFF2C3E50), fontSize: 16),
      ),
      obscureText: inputObscureText,
      controller: inputController,
    );
  }
}

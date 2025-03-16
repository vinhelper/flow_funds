import 'package:flutter/material.dart';

class OnBoardingButton extends StatelessWidget {
  final Color? buttonColor;
  final Text? buttonText;
  final VoidCallback? buttonPressed;

  const OnBoardingButton({
    super.key,
    required this.buttonColor,
    required this.buttonText,
    required this.buttonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: buttonPressed,
            child: buttonText,
          ),
        ),
      ],
    );
  }
}

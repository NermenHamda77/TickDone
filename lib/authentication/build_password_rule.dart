import 'package:flutter/material.dart';

class PasswordRulesWidget extends StatefulWidget {
  final String password;

  PasswordRulesWidget({required this.password, super.key});

  @override
  State<PasswordRulesWidget> createState() => _PasswordRulesWidgetState();
}

class _PasswordRulesWidgetState extends State<PasswordRulesWidget> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPasswordRule(
            "At least 8 characters", getColor(hasMinLength(widget.password))),
        buildPasswordRule("At least 1 uppercase letter",
            getColor(hasUpperCase(widget.password))),
        buildPasswordRule("At least 1 lowercase letter",
            getColor(hasLowerCase(widget.password))),
        buildPasswordRule(
            "At least 1 number", getColor(hasDigit(widget.password))),
        buildPasswordRule("At least 1 special character (! @ # \$ & * ~)",
            getColor(hasSpecialChar(widget.password))),
      ],
    );
  }

  Widget buildPasswordRule(String text, Color color) {
    return Text(
      "• $text",
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: color
      ),
    );
  }

  Color getColor(bool condition) {
    if (widget.password.isEmpty) {
      return Theme.of(context).primaryColor;
    }
    return condition ? Colors.green : Colors.red;
  }

  bool hasUpperCase(String text) => text.contains(RegExp(r'[A-Z]'));

  bool hasLowerCase(String text) => text.contains(RegExp(r'[a-z]'));

  bool hasDigit(String text) => text.contains(RegExp(r'\d'));

  bool hasSpecialChar(String text) => text.contains(RegExp(r'[!@#\$&*~]'));

  bool hasMinLength(String text) => text.length >= 8;
}

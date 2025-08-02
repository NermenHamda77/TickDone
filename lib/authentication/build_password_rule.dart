import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            AppLocalizations.of(context)!.password_rule_min_length, getColor(hasMinLength(widget.password))),
        buildPasswordRule(AppLocalizations.of(context)!.password_rule_uppercase,
            getColor(hasUpperCase(widget.password))),
        buildPasswordRule(AppLocalizations.of(context)!.password_rule_lowercase,
            getColor(hasLowerCase(widget.password))),
        buildPasswordRule(
            AppLocalizations.of(context)!.password_rule_number, getColor(hasDigit(widget.password))),
        buildPasswordRule(AppLocalizations.of(context)!.password_rule_special,
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

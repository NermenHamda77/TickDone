import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tick_done_app/authentication/custom_text_form_field.dart';
import 'package:tick_done_app/authentication/signUpScreen.dart';

import '../theming/app_colors.dart';
import 'build_password_rule.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "log_in_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "TickDone",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),

                CustomTextFormField(
                  label: AppLocalizations.of(context)!.email,
                  validator:  (text) {
                    if(text == null || text.trim().isEmpty ){
                      return "Please enter Email";
                    }
                    final RegExp emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegex.hasMatch(text)) {
                      return 'Enter a valid Email';
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextFormField(
                  label: AppLocalizations.of(context)!.password,
                  validator: (text) {
                    if(text == null || text.trim().isEmpty ){
                      return "Please enter Password";
                    }
                    return null;
                  },
                  onChange: (text){
                    setState(() {
                    });

                  },
                  controller: passwordController,
                  obscureText: true,
                ),


                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.log_in,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.dont_have_an_account,
                      style: Theme.of(context).textTheme.titleSmall,),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignUpScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.sign_up,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppColors.textButtonColor),
                      ),
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            AppColors.primaryLightColor.withOpacity(0.1)),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void login() {
    if(formKey.currentState?.validate() == true){
      // login and go to home
    }

  }
}

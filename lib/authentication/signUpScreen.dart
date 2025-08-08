import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/authentication/custom_text_form_field.dart';
import 'package:tick_done_app/dialog_utils/dialog_utils.dart';
import 'package:tick_done_app/firebase_utils/firebase_utils.dart';
import 'package:tick_done_app/model/my_user.dart';
import 'package:tick_done_app/providers/app_config_provider.dart';
import '../theming/app_colors.dart';
import 'build_password_rule.dart';
import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "sign_up_screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController =
      TextEditingController();

  TextEditingController emailController =
      TextEditingController();

  TextEditingController confirmPasswordController =
      TextEditingController();

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
                      AppLocalizations.of(context)!.create_account,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                CustomTextFormField(
                  label: AppLocalizations.of(context)!.user_name,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter Username";
                    }
                    return null;
                  },
                  controller: nameController,
                ),
                CustomTextFormField(
                  label: AppLocalizations.of(context)!.email,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
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
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter Password";
                    }
                    final RegExp passwordRegEx = RegExp(
                      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
                    );

                    if (!passwordRegEx.hasMatch(text)) {
                      return "Password is weak. Please try again.";
                    }
                    return null;
                  },
                  onChange: (text) {
                    setState(() {});
                  },
                  controller: passwordController,
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: PasswordRulesWidget(
                    password: passwordController.text,
                  ),
                ),
                CustomTextFormField(
                  label: AppLocalizations.of(context)!.confirm_password,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter Confirm Password";
                    }
                    if (text != passwordController.text) {
                      return "Confirm Password doesn't match with Password";
                    }
                    return null;
                  },
                  controller: confirmPasswordController,
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.sign_up,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.already_have_an_account,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.log_in,
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

  void register() async {
    if (formKey.currentState?.validate() == true) {
      // create account
      var provider = Provider.of<AppConfigProvider>(context , listen: false);
      DialogUtils.showLoading(context: context, message: "Loading..." , provider:provider );
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? "",
            name: nameController.text,
            email: emailController.text,
            joinedAt: DateTime.now()
        );
        await FirebaseUtils.addUserToFireStore(myUser);

        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: "Account created successfully!",
          icon: Icon(
            Icons.check_circle_outline,
            color: Colors.greenAccent,
          ),
          posActionName: "Ok",
          posActionFn: () {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
          title: "Success",
        );

        print(
            "-------signup----------${credential.user?.uid ?? "no uid"}--------------------------");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: "The password provided is too weak.",
            icon: Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
            ),
            posActionName: "Ok",
            title: "Error",
          );
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: "The account already exists for that email.",
            icon: Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
            ),
            posActionName: "Ok",
            title: "Error",
          );
        } else if (e.code == 'network-request-failed') {
          print(
              'The supplied auth credential is incorrect, malformed or has expired.');
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message:
                "A network error (such as timeout, interrupted connection or unreachable host) has occurred.",
            icon: Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
            ),
            posActionName: "Ok",
            title: "Error",
          );
        }
      } catch (e) {
        print(e.toString());
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          icon: Icon(
            Icons.error_outline_rounded,
            color: Colors.red,
          ),
          posActionName: "Ok",
          title: "Error",
        );
      }
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../authentication/build_password_rule.dart';
import '../authentication/custom_text_form_field.dart';
import '../dialog_utils/dialog_utils.dart';
import '../theming/app_colors.dart';
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  static const String routeName = "change_password";

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  TextEditingController newPasswordController =
  TextEditingController();

  TextEditingController currentPasswordController =
  TextEditingController();

  TextEditingController confirmNewPasswordController =
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
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    AppLocalizations.of(context)!.change_password,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              CustomTextFormField(
                label: "Current Password",
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return "Enter Current Password";
                  }
                  return null;
                },
                controller: currentPasswordController,
                obscureText: true,
              ),


              // new password
              CustomTextFormField(
                label: "New Password",
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
                controller: newPasswordController,
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: PasswordRulesWidget(
                  password: newPasswordController.text,
                ),
              ),
              CustomTextFormField(
                label: "Confirm New Password",
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Please enter Confirm New Password";
                  }
                  if (text != newPasswordController.text) {
                    return "Confirm New Password doesn't match with Password";
                  }
                  return null;
                },
                controller: confirmNewPasswordController,
                obscureText: true,
              ),

              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(
                  onPressed: () {
                    saveChanges();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save_changes,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.cancel,
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
        ),
      ),
    );
  }

  void saveChanges() async{
    if (formKey.currentState?.validate() == true) {
      // create account
      DialogUtils.showLoading(context: context, message: "Loading...");
      try {
        final user = FirebaseAuth.instance.currentUser!;
        final credential =
        EmailAuthProvider.credential(
          email: user.email!,
          password: currentPasswordController.text,
        );
        print("re-authentication .......");
        await user.reauthenticateWithCredential(credential);
        print("re-authentication successfully");
        await user.updatePassword(newPasswordController.text);

        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: "Password updated successfully!",
          icon: Icon(
            Icons.check_circle_outline,
            color: Colors.greenAccent,
          ),
          posActionName: "Ok",
          posActionFn: (){
            Navigator.pop(context);
          },
          title: "Success",
        );
      }on FirebaseAuthException catch (e){
        /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? "Error occurred"))
        );*/
        print("re-authentication failed");

        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: e.message ?? "Error occurred",
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

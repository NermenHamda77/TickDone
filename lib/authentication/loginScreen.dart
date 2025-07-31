import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tick_done_app/authentication/custom_text_form_field.dart';
import 'package:tick_done_app/authentication/signUpScreen.dart';

import '../dialog_utils/dialog_utils.dart';
import '../home/home_screen.dart';
import '../theming/app_colors.dart';

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

  void login() async{
    if(formKey.currentState?.validate() == true){
      // login and go to home
      DialogUtils.showLoading(context: context, message: "Loading...");
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(context: context, message: "Welcome Back!",
            icon: Icon(Icons.check_circle_outline , color: Colors.greenAccent,),
          posActionName: "Ok",
          posActionFn: (){
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          },
          title: "Success",
        );


        print("----login-------------${credential.user?.uid ?? "no uid"}--------------------------");

     } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          print('The supplied auth credential is incorrect, malformed or has expired.');
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(context: context,
              message: "The supplied auth credential is incorrect, malformed or has expired.",
              icon: Icon(Icons.error_outline_rounded , color: Colors.red,),
            posActionName: "Ok",
            title: "Error",);

        }else if (e.code == 'network-request-failed') {
          print('The supplied auth credential is incorrect, malformed or has expired.');
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(context: context,
            message: "A network error (such as timeout, interrupted connection or unreachable host) has occurred.",
            icon: Icon(Icons.error_outline_rounded , color: Colors.red,),
            posActionName: "Ok",
            title: "Error",);

        }
      }catch(e){
        print(e.toString());
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(context: context, message: e.toString(),
            icon: Icon(Icons.error_outline_rounded , color: Colors.red,),
          posActionName: "Ok",
          title: "Error",);

      }
    }

  }
}

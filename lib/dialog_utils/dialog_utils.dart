import 'package:flutter/material.dart';
import 'package:tick_done_app/theming/app_colors.dart';

class DialogUtils {
  static showLoading({required BuildContext context, required String message}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content:Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message,
                  ),
                ),
              ],
            ) ,
          );

        });
  }

  static hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static showMessage(
      {required BuildContext context, required String message,
      String title = "", required Icon icon,
      String? posActionName, Function? posActionFn,
      String? negActionName, Function? negActionFn,
      }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              posActionFn?.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor
            ),
            child: Text(posActionName , style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.darkTextColor))),
      );
    }
    if (negActionName != null) {
      actions.add(
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              negActionFn?.call();
            },
            child: Text(negActionName , style: Theme.of(context).textTheme.titleLarge)),
      );
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
            content: Text(
              message,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            icon: icon,
            actions: actions,
          );
        });
  }
}

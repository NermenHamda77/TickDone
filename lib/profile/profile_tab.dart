import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/authentication/loginScreen.dart';
import 'package:tick_done_app/profile/change_password_screen.dart';
import 'package:tick_done_app/profile/widget/app_info_item.dart';
import 'package:tick_done_app/profile/widget/language_bottom_sheet.dart';
import 'package:tick_done_app/profile/widget/settings_item.dart';
import 'package:tick_done_app/providers/tasks_provider.dart';
import 'package:tick_done_app/theming/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';
import '../providers/app_config_provider.dart';
import '../providers/auth_user_provider.dart';
import '../services/notification_service.dart';

class ProfileTab extends StatefulWidget {
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late AuthUserProvider userProvider;
  late TasksProvider tasksProvider;
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<AuthUserProvider>(context);
    tasksProvider = Provider.of<TasksProvider>(context);

    provider = Provider.of<AppConfigProvider>(context);
    if(userProvider.currentUser == null){
      return Center(
        child: Text("User not logged in" ,
        style: Theme.of(context).textTheme.bodyMedium,),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    getInitials(userProvider.currentUser!.name!),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.lightBeigeColor),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(userProvider.currentUser!.name!,
                        style: Theme.of(context).textTheme.labelLarge),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userProvider.currentUser!.email!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.darkBeigeColor),
                    ),
                  ],
                )
              ],
            ),

            SizedBox(
              height: 16,
            ),

            // -----------------------Settings-----------------------------

            Divider(
              thickness: 1,
              color: AppColors.darkBeigeColor,
            ),
            SizedBox(
              height: 12,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(AppLocalizations.of(context)!.settings,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.start),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Divider(
              thickness: 1,
              color: AppColors.darkBeigeColor,
            ),
            SettingsItemRow(
              title: AppLocalizations.of(context)!.language,
              value: provider.isEnglishLanguage()
                  ? AppLocalizations.of(context)!.english
                  : AppLocalizations.of(context)!.arabic,
              icon: Icons.language,
              onTap: showLanguageBottomSheet,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.brightness_6 ,
                        size: 24,color: provider.isDarkMode() ?
                        AppColors.beigeColor:
                        AppColors.darkTextColor),
                    SizedBox(width: 10,),
                    Text(AppLocalizations.of(context)!.dark,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: provider.isDarkMode() ?
                        AppColors.beigeColor:
                        AppColors.darkTextColor
                    ),)
                  ],
                ),
                Switch(
                   activeColor:
                       AppColors.primaryDarkColor,
                    value: provider.isDarkMode(),
                    onChanged: (value){
                      provider.changeAppMode(
                        value ?
                        ThemeMode.dark :
                        ThemeMode.light
                      );
                    }
                ),
              ],

            ),

            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ChangePasswordScreen.routeName,
                    arguments: userProvider.currentUser);
              },
              child: AppInfoItem(
                  title: AppLocalizations.of(context)!.change_password,
                  value: "",
                  icon: Icons.lock),
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications ,
                        size: 24,color: provider.isDarkMode() ?
                        AppColors.beigeColor:
                        AppColors.darkTextColor),
                    SizedBox(width: 10,),
                    Text(AppLocalizations.of(context)!.notifications_settings,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: provider.isDarkMode() ?
                          AppColors.beigeColor:
                          AppColors.darkTextColor
                      ),)
                  ],
                ),
                Switch(
                  activeColor:Theme.of(context).primaryColor,
                  value: provider.isNotificationsEnabled(),
                  onChanged: (value) async {
                    await provider.setNotificationsEnabled(value);

                    if (value) {
                      await NotificationService.showNotification(
                        title: AppLocalizations.of(context)!.notifications_settings,
                        body: AppLocalizations.of(context)!.notifications_settings_desc,
                      );
                    } else {
                      await NotificationService.cancelAllNotifications();
                    }
                  },
                ),              ],

            ),

            // -----------------------App Info-----------------------------
            Divider(
              thickness: 1,
              color: AppColors.darkBeigeColor,
            ),

            SizedBox(
              height: 12,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(AppLocalizations.of(context)!.app_info,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.start),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Divider(
              thickness: 1,
              color: AppColors.darkBeigeColor,
            ),

            AppInfoItem(
                title: AppLocalizations.of(context)!.total_tasks,
                value: tasksProvider
                    .allTasksCount(userProvider.currentUser!.id!)
                    .toString(),
                icon: Icons.list_alt),

            AppInfoItem(
                title: AppLocalizations.of(context)!.pending_tasks,
                value: tasksProvider
                    .pendingTasksCount(userProvider.currentUser!.id!)
                    .toString(),
                icon: Icons.schedule),

            AppInfoItem(
                title: AppLocalizations.of(context)!.completed_tasks,
                value: tasksProvider
                    .completedTasksCount(userProvider.currentUser!.id!)
                    .toString(),
                icon: Icons.done_all),


            AppInfoItem(
                title: AppLocalizations.of(context)!.joined_on,
                value: provider.isEnglishLanguage()
                    ? DateFormat.yMMMMd("en")
                        .format(userProvider.currentUser!.joinedAt)
                    : DateFormat.yMMMMd("ar")
                        .format(userProvider.currentUser!.joinedAt),
                icon: Icons.event),

            Divider(
              thickness: 1,
              color: AppColors.darkBeigeColor,
            ),
            SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () async {
                logOutConfirm();
              },
              child: AppInfoItem(
                  title: AppLocalizations.of(context)!.log_out,
                  icon: Icons.logout_outlined),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      backgroundColor:
          provider.isDarkMode() ? AppColors.blackColor : AppColors.whiteColor,
      context: context,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: provider.isDarkMode()
                  ? AppColors.primaryDarkColor
                  : AppColors.primaryLightColor,
              width: 1),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => LanguageBottomSheetModel(),
    );
  }

  String getInitials(String userName) {
    List<String> names = userName.trim().split(" ");
    if (names.isEmpty || names[0].isEmpty) {
      return "?";
    }
    if (names.length == 1) {
      return names[0][0].toUpperCase();
    }
    return names[0][0].toUpperCase() + names[1][0].toUpperCase();
  }

  void logOutConfirm() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirm_logout_title ,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.blackColor
          ),),
        content: Text(AppLocalizations.of(context)!.confirm_logout_message ,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppColors.secondaryTextColor
        ),),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel ,
            style: TextStyle(color: AppColors.beigeColor)),
          ),
          TextButton(
            onPressed: () async{
              // log out
              Navigator.pop(context);
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushReplacementNamed(LoginScreen.routeName);
              tasksProvider.allUserTasks = [];
              userProvider.clearUser();
              tasksProvider.tasks = [];
            },
            child: Text(AppLocalizations.of(context)!.log_out, style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }

}

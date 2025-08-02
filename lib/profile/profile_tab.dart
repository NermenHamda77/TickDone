import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/authentication/loginScreen.dart';
import 'package:tick_done_app/profile/widget/app_info_item.dart';
import 'package:tick_done_app/profile/widget/language_bottom_sheet.dart';
import 'package:tick_done_app/profile/widget/mode_bottom_sheet.dart';
import 'package:tick_done_app/profile/widget/settings_item.dart';
import 'package:tick_done_app/providers/tasks_provider.dart';
import 'package:tick_done_app/theming/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/app_config_provider.dart';
import '../providers/auth_user_provider.dart';

class ProfileTab extends StatefulWidget {
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late AuthUserProvider userProvider;
  late TasksProvider tasksProvider;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<AuthUserProvider>(context);
    tasksProvider = Provider.of<TasksProvider>(context);

    var provider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
            ),
            SizedBox(
              height: 16,
            ),

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
/*
            Divider(
              thickness: 1,
              color: AppColors.lightBeigeColor,
            ),
            SizedBox(
              height: 12,
            ),
*/

            SettingsItemRow(
              title: AppLocalizations.of(context)!.mode,
              value: provider.isDarkMode()
                  ? AppLocalizations.of(context)!.dark
                  : AppLocalizations.of(context)!.light,
              icon: Icons.brightness_6,
              onTap: showModeBottomSheet,
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
/*            Divider(
              thickness: 1,
              color: AppColors.lightBeigeColor,
            ),
            SizedBox(
              height: 12,
            ),*/
            AppInfoItem(
                title: AppLocalizations.of(context)!.pending_tasks,
                value: tasksProvider
                    .pendingTasksCount(userProvider.currentUser!.id!)
                    .toString(),
                icon: Icons.schedule),
/*            Divider(
              thickness: 1,
              color: AppColors.lightBeigeColor,
            ),
            SizedBox(
              height: 12,
            ),*/
            AppInfoItem(
                title: AppLocalizations.of(context)!.completed_tasks,
                value: tasksProvider
                    .completedTasksCount(userProvider.currentUser!.id!)
                    .toString(),
                icon: Icons.done_all),


/*            Divider(
              thickness: 1,
              color: AppColors.lightBeigeColor,
            ),
            SizedBox(
              height: 12,
            ),*/
            AppInfoItem(
                title: AppLocalizations.of(context)!.joined_on,
                value: provider.isEnglishLanguage() ?
                DateFormat.yMMMMd("en").format(userProvider.currentUser!.joinedAt) :
                DateFormat.yMMMMd("ar").format(userProvider.currentUser!.joinedAt) ,
                icon: Icons.event),

            Divider(
              thickness: 1,
              color: AppColors.darkBeigeColor,
            ),
            SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                tasksProvider.allUserTasks = [];
                userProvider.currentUser = null;
                tasksProvider.tasks = [];
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
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
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => LanguageBottomSheetModel(),
    );
  }

  void showModeBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => ModeBottomSheetModel(),
    );
  }
}

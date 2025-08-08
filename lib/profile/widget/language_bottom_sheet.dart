import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../theming/app_colors.dart';

class LanguageBottomSheetModel extends StatefulWidget {
  @override
  State<LanguageBottomSheetModel> createState() =>
      _LanguageBottomSheetModelState();
}

class _LanguageBottomSheetModelState extends State<LanguageBottomSheetModel> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.select_language,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.cancel_outlined,
                    color: provider.isDarkMode()
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              // English
              provider.changeAppLanguage("en");
            },
            child: provider.isEnglishLanguage()
                ? getSelectedCardWidget(
                    provider, AppLocalizations.of(context)!.english)
                : getUnselectedCardWidget(
                    provider, AppLocalizations.of(context)!.english),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              //light
              provider.changeAppLanguage("ar");
            },
            child: provider.isEnglishLanguage()
                ? getUnselectedCardWidget(
                    provider, AppLocalizations.of(context)!.arabic)
                : getSelectedCardWidget(
                    provider, AppLocalizations.of(context)!.arabic),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget getSelectedCardWidget(
      AppConfigProvider provider, String selectedMode) {
    return Card(
      elevation: 3,
      color: provider.isDarkMode()
          ? AppColors.primaryDarkColor
          : AppColors.primaryLightColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.language,
              size: 24,
              color: provider.isDarkMode()
                  ? AppColors.lightWhiteColor
                  : AppColors.whiteColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              selectedMode,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: provider.isDarkMode()
                        ? AppColors.lightWhiteColor
                        : AppColors.whiteColor,
                  ),
            ),
            Spacer(),
            Icon(
              Icons.check,
              size: 30,
              color: provider.isDarkMode()
                  ? AppColors.lightWhiteColor
                  : AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget getUnselectedCardWidget(
      AppConfigProvider provider, String unSelectedMode) {
    return Card(
      elevation: 3,
      color: provider.isDarkMode()
          ? AppColors.lightBeigeColor
          : AppColors.lightBeigeColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.language,
              size: 24,
              color: provider.isDarkMode()
                  ? AppColors.secondaryTextColor
                  : AppColors.secondaryTextColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              unSelectedMode,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: provider.isDarkMode()
                        ? AppColors.secondaryTextColor
                        : AppColors.secondaryTextColor,
                  ),
            ),
            Spacer(),
            Opacity(
              opacity: 0,
              child: Icon(
                Icons.check,
                size: 30,
                color: provider.isDarkMode()
                    ? AppColors.secondaryTextColor
                    : AppColors.secondaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

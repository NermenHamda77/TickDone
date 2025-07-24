import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../theming/app_colors.dart';

class LanguageBottomSheetModel extends StatefulWidget {
  @override
  State<LanguageBottomSheetModel> createState() => _LanguageBottomSheetModelState();
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
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              AppLocalizations.of(context)!.select_language,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Divider(
            thickness: 1,
            color: AppColors.lightBeigeColor,
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              // English
              provider.changeAppLanguage("en");
            },
            child:
            provider.isEnglishLanguage()
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
            child:
            provider.isEnglishLanguage()
                ? getUnselectedCardWidget(
                provider, AppLocalizations.of(context)!.arabic)
                : getSelectedCardWidget(
                provider, AppLocalizations.of(context)!.arabic),

          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.cancel_outlined,
                color: AppColors.textButtonColor,
                size: 28,
              ),
              label: Text(
                AppLocalizations.of(context)!.exit,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.textButtonColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedCardWidget(AppConfigProvider provider, String selectedMode) {
    return
      Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.light_mode,
                size: 24,
                color: AppColors.primaryLightColor,
              ),
              SizedBox(width: 10,),
              Text(
                selectedMode,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primaryLightColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.check,
                size: 30,
                color: AppColors.primaryLightColor,
              ),
            ],
          ),
        ),

      );
  }

  Widget getUnselectedCardWidget(AppConfigProvider provider, String unSelectedMode) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.light_mode,
              size: 24,
              color: AppColors.secondaryTextColor,
            ),
            SizedBox(width: 10,),

            Text(
              unSelectedMode,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Spacer(),
            Opacity(
              opacity: 0,
              child: Icon(
                Icons.check,
                size: 30,
                color: AppColors.primaryLightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

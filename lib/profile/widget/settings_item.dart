import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/providers/app_config_provider.dart';

import '../../theming/app_colors.dart';

class SettingsItemRow extends StatelessWidget {
  String title;
  String value;
  IconData icon;
  Function onTap;
  SettingsItemRow({
    required this.title ,
    required this.value ,
    required this.icon ,
    required this.onTap
  });

  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return InkWell(
      onTap: (){
        // call back function :>  bottom sheet
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, size: 24,color: provider.isDarkMode() ?
            AppColors.beigeColor:
            AppColors.darkTextColor),
            SizedBox(width: 10,),
            Text(title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: provider.isDarkMode() ?
                  AppColors.beigeColor:
                  AppColors.darkTextColor
              ),),
            Spacer(),

            Text(value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.darkBeigeColor
              ),),
            Icon(Icons.arrow_drop_down , size: 24,
                color: provider.isDarkMode() ?
                AppColors.darkBeigeColor:
                AppColors.secondaryTextColor),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_config_provider.dart';
import '../../theming/app_colors.dart';

class AppInfoItem extends StatelessWidget {
  String title;
  String value;
  IconData icon;
  AppInfoItem({
    required this.title ,
    this.value = "" ,
    required this.icon ,
  });
  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24, color: provider.isDarkMode() ?
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
          SizedBox(width: 12,),

        ],
      ),
    );
  }
}

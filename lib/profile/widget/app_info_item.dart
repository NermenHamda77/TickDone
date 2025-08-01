import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24, color: AppColors.darkTextColor),
          SizedBox(width: 10,),
          Text(title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.secondaryTextColor
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

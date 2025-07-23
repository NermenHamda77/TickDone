import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // call back function :>  bottom sheet
        onTap();
      },
      child: Padding(
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
                  color: AppColors.secondaryTextColor
              ),),
            Icon(Icons.arrow_drop_down , size: 24, color: AppColors.darkTextColor),
          ],
        ),
      ),
    );
  }
}

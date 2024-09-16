import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../style/theme_app.dart';

class CustomBtn extends StatelessWidget {
  String titleBtn;
  Function onTap;
  CustomBtn({required this.titleBtn , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primeryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(child: Text(titleBtn, style: ThemeApp.lightTheme.textTheme.titleLarge?.copyWith(fontSize: 20),)),
      ),
    );
  }
}

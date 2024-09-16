import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/pages/signin.dart';
import 'package:todoapp/providers/firbase_provider.dart';
import 'package:todoapp/style/app_colors.dart';
import 'package:todoapp/style/theme_app.dart';
import 'package:todoapp/utils/firbase_utils.dart';
import 'package:todoapp/widgets/custom_btn.dart';
import 'package:todoapp/widgets/drop_items_language.dart';
import '../providers/select_theme.dart';

class Settings extends StatefulWidget {
  static const String routeName = 'settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<SelectTheme>(context);
    var firebaseList = Provider.of<FireBaseProvider>(context);
    return themeProvider.isDarkMode() ?
    Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.language, style: ThemeApp.darkTheme.textTheme.bodyLarge,),
          const SizedBox(height: 8,),
          const DropItemsMenuLanguage(),
          const SizedBox(height: 8,),
          Text(AppLocalizations.of(context)!.mode, style: ThemeApp.darkTheme.textTheme.bodyLarge,),
          const SizedBox(height: 8,),
          DropdownButtonFormField(
            value: Provider.of<SelectTheme>(context).isDarkMode() ? 'dark' : 'light',
            onChanged: (value) {
              Provider.of<SelectTheme>(context, listen: false).selectTheme();
              },
            items: [
              DropdownMenuItem(
                value: 'light',
                child: Text(AppLocalizations.of(context)!.light, style: ThemeApp.darkTheme.textTheme.titleMedium,),
              ),
              DropdownMenuItem(
                value: 'dark',
                child: Text(AppLocalizations.of(context)!.dark, style: ThemeApp.darkTheme.textTheme.titleMedium,),
              ),
            ],
            dropdownColor: AppColors.cardDarkColor,
            hint: Text('Select Theme', style: ThemeApp.darkTheme.textTheme.titleMedium,),
            isExpanded: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              fillColor: AppColors.cardDarkColor,
              filled: true,
              enabled: false,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          CustomBtn(titleBtn: AppLocalizations.of(context)!.logout_account, onTap: () {
            FirebaseUtils.signOut();
            firebaseList.tasksList = [];
            Navigator.pushReplacementNamed(context, SignIn.routeName);
          })

        ],
      ),
    ) :  //Dark Theme
    Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.language, style: ThemeApp.lightTheme.textTheme.bodyLarge,),
          const SizedBox(height: 8,),
          const DropItemsMenuLanguage(),
          const SizedBox(height: 8,),
          Text(AppLocalizations.of(context)!.mode, style: ThemeApp.lightTheme.textTheme.bodyLarge,),
          const SizedBox(height: 8,),
          DropdownButtonFormField(
            value: Provider.of<SelectTheme>(context).isDarkMode() ? 'dark' : 'light',
            onChanged: (value) {
              Provider.of<SelectTheme>(context, listen: false).selectTheme();
            },
            items: [
              DropdownMenuItem(
                value: 'light',
                child: Text(AppLocalizations.of(context)!.light, style: ThemeApp.lightTheme.textTheme.titleMedium,),
              ),
              DropdownMenuItem(
                value: 'dark',
                child: Text(AppLocalizations.of(context)!.dark, style: ThemeApp.lightTheme.textTheme.titleMedium,),
              ),
            ],
            hint: Text('Select Theme', style: ThemeApp.darkTheme.textTheme.titleMedium,),
            isExpanded: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              fillColor: AppColors.whiteColor,
              filled: true,
              enabled: false,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          CustomBtn(titleBtn: AppLocalizations.of(context)!.logout_account, onTap: (){
            FirebaseUtils.signOut();
            firebaseList.tasksList = [];
            Navigator.pushReplacementNamed(context, SignIn.routeName);
            }
          )
        ],
      ),
    );  //Light Theme
  }
}

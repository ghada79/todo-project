import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/style/app_colors.dart';
import 'package:todoapp/style/theme_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/widgets/task_bottom_sheet.dart';
import '../providers/bottom_nav_select.dart';
import '../providers/firbase_provider.dart';
import '../providers/select_language.dart';
import '../providers/select_theme.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var provider = Provider.of<BottomNavSelect>(context);
    var providerLang = Provider.of<SelectLanguage>(context);
    var themeProvider = Provider.of<SelectTheme>(context);
    var listProvider = Provider.of<FireBaseProvider>(context);
    var scaffoldColor = themeProvider.isDarkMode() ? AppColors.backgroundDarkColor : AppColors.backgroundColor;

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: ThemeApp.lightTheme.textTheme.titleLarge,
        ),
        backgroundColor: ThemeApp.lightTheme.appBarTheme.backgroundColor,
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
      ),
      body: Consumer<BottomNavSelect>(
        builder: (context, bottomNavSelect, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    color: AppColors.primeryColor,
                  ),
                  themeProvider.isDarkMode() ?
                  provider.selectedIndex == 0 ?
                  EasyDateTimeLine(
                    locale: providerLang.appLanguage == 'en' ? 'en' : 'ar',
                    initialDate: listProvider.selectDate,
                    onDateChange: (selectedDate) {
                    listProvider.changeSelectDate(selectedDate , userProvider.currentUser!.id!);
                    },
                    headerProps: const EasyHeaderProps(
                      showHeader: false,
                    ),
                    activeColor: AppColors.cardDarkColor,
                    dayProps: EasyDayProps(
                      todayHighlightStyle: TodayHighlightStyle.withBackground,
                      todayHighlightColor: AppColors.cardDarkColor,
                      activeDayStyle: const DayStyle(
                        dayNumStyle: TextStyle(
                          fontSize: 20,
                          color: AppColors.primeryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        dayStrStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.primeryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        monthStrStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.primeryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: AppColors.cardDarkColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        dayNumStyle: const TextStyle(
                          fontSize: 20,
                          color: AppColors.whiteColor,
                        ),
                        dayStrStyle: const TextStyle(
                          fontSize: 12,
                          color: AppColors.whiteColor,
                        ),
                        monthStrStyle: const TextStyle(
                          fontSize: 12,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ) : Container() :
                  provider.selectedIndex == 0 ?
                  EasyDateTimeLine(
                    locale: providerLang.appLanguage == 'en' ? 'en' : 'ar',
                    initialDate: listProvider.selectDate,
                    onDateChange: (selectedDate) {
                      listProvider.changeSelectDate(selectedDate , userProvider.currentUser!.id!);
                    },
                    headerProps: const EasyHeaderProps(
                      showHeader: false,
                    ),
                    activeColor: AppColors.whiteColor,
                    dayProps: EasyDayProps(
                      todayHighlightStyle: TodayHighlightStyle.withBackground,
                      todayHighlightColor: themeProvider.isDarkMode() ? AppColors.cardDarkColor : AppColors.whiteColor,
                      activeDayStyle: const DayStyle(
                        dayNumStyle: TextStyle(
                          fontSize: 20,
                          color: AppColors.primeryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        dayStrStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.primeryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        monthStrStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.primeryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        dayNumStyle: const TextStyle(
                          fontSize: 20,
                          color: AppColors.blackColor,
                        ),
                        dayStrStyle: const TextStyle(
                          fontSize: 12,
                          color: AppColors.blackColor,
                        ),
                        monthStrStyle: const TextStyle(
                          fontSize: 12,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ) : Container(),
                ],
              ),
              const SizedBox(height: 24,),
              bottomNavSelect.getSelectedPage(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: themeProvider.isDarkMode() ? AppColors.cardDarkColor : AppColors.whiteColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.list,
                color: provider.selectedIndex == 0
                    ? AppColors.primeryColor
                    : AppColors.unSelectedColor,
              ),
              onPressed: () {
                provider.selectTap(0);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: provider.selectedIndex == 1
                    ? AppColors.primeryColor
                    : AppColors.unSelectedColor,
              ),
              onPressed: () {
                provider.selectTap(1);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: ThemeApp.lightTheme.floatingActionButtonTheme.shape,
        backgroundColor: ThemeApp.lightTheme.appBarTheme.backgroundColor,
        onPressed: () {
          addTaskBottomSheet(
          );
        },
        elevation: ThemeApp.lightTheme.floatingActionButtonTheme.elevation,
        hoverElevation: 0,
        child: Icon(
          Icons.add,
          color: ThemeApp.lightTheme.iconTheme.color,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void addTaskBottomSheet() {
    showModalBottomSheet(context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: TaskBottomSheet(),
    ),
    );
  }
}


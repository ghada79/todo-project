import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/pages/edit_task.dart';
import 'package:todoapp/providers/user_provider.dart';
import 'package:todoapp/style/app_colors.dart';
import 'package:todoapp/style/theme_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/task_model.dart';
import '../providers/firbase_provider.dart';
import '../providers/select_theme.dart';

class TaskListItem extends StatefulWidget {
  Task task;

  TaskListItem({required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<SelectTheme>(context);
    var firbaseProvider = Provider.of<FireBaseProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return themeProvider.isDarkMode() ? Container(
      margin: EdgeInsets.all(16),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) async {
                await firbaseProvider.deleteTask(widget.task , userProvider.currentUser!.id!);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.of(context).pushNamed(EditTask.routeName);
              },
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4)),
            ),
          ],
        ),
        child: widget.task.isDone == true ? Container(
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
              color: AppColors.cardDarkColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 5,
                margin: EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4)),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: ThemeApp.darkTheme.textTheme.titleMedium,
                    ),
                    Text(
                      widget.task.dateTime.toString(),
                      style: ThemeApp.darkTheme.textTheme.titleMedium
                          ?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  firbaseProvider.taskToDone(widget.task , userProvider.currentUser!.id!);
                  firbaseProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
                },
                child: widget.task.isDone == true
                    ? Container(
                        margin: const EdgeInsets.all(16),
                        child: Text(
                        AppLocalizations.of(context)!.done,
                        style: ThemeApp.lightTheme.textTheme.titleMedium
                            ?.copyWith(color: AppColors.greenColor),
                      ))
                    : Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: AppColors.primeryColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: AppColors.whiteColor,
                        ),
                      ),
              )
            ],
          ),
        ) : Container(
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 5,
                margin: EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: AppColors.primeryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4)),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: ThemeApp.lightTheme.textTheme.titleMedium,
                    ),
                    Text(
                      widget.task.dateTime.toString(),
                      style: ThemeApp.lightTheme.textTheme.titleMedium
                          ?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  firbaseProvider.taskToDone(widget.task , userProvider.currentUser!.id!);
                  firbaseProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
                },
                child: widget.task.isDone == true
                    ? Container(
                    margin: const EdgeInsets.all(16),
                    child: Text(
                      AppLocalizations.of(context)!.done,
                      style: ThemeApp.lightTheme.textTheme.titleMedium
                          ?.copyWith(color: AppColors.greenColor),
                    ))
                    : Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                    color: AppColors.primeryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.whiteColor,
                  ),
                ),
              )
            ],
          ),
        )
      ),
    ) : Container(
      margin: EdgeInsets.all(16),
      child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                onPressed: (context) async {
                  await firbaseProvider.deleteTask(widget.task , userProvider.currentUser!.id!);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
              ),
            ],
          ),
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Navigator.of(context).pushNamed(EditTask.routeName);
                },
                backgroundColor: Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: AppLocalizations.of(context)!.edit,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4)),
              ),
            ],
          ),
          child: widget.task.isDone == true ? Container(
            height: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 5,
                  margin: EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4)),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: ThemeApp.lightTheme.textTheme.titleMedium,
                      ),
                      Text(
                        widget.task.dateTime.toString(),
                        style: ThemeApp.lightTheme.textTheme.titleMedium
                            ?.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    firbaseProvider.taskToDone(widget.task , userProvider.currentUser!.id!);
                    firbaseProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
                  },
                  child: widget.task.isDone == true
                      ? Container(
                      margin: const EdgeInsets.all(16),
                      child: Text(
                        AppLocalizations.of(context)!.done,
                        style: ThemeApp.lightTheme.textTheme.titleMedium
                            ?.copyWith(color: AppColors.greenColor),
                      ))
                      : Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                      color: AppColors.primeryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.whiteColor,
                    ),
                  ),
                )
              ],
            ),
          ) : Container(
            height: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 5,
                  margin: EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: AppColors.primeryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4)),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: ThemeApp.lightTheme.textTheme.titleMedium,
                      ),
                      Text(
                        widget.task.dateTime.toString(),
                        style: ThemeApp.lightTheme.textTheme.titleMedium
                            ?.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    firbaseProvider.taskToDone(widget.task , userProvider.currentUser!.id!);
                    firbaseProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
                  },
                  child: widget.task.isDone == true
                      ? Container(
                      margin: const EdgeInsets.all(16),
                      child: Text(
                        AppLocalizations.of(context)!.done,
                        style: ThemeApp.lightTheme.textTheme.titleMedium
                            ?.copyWith(color: AppColors.greenColor),
                      ))
                      : Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                      color: AppColors.primeryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.whiteColor,
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

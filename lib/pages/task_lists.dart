import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/pages/task_list_item.dart';
import '../providers/firbase_provider.dart';
import '../providers/user_provider.dart';

class TaskLists extends StatefulWidget {
  static const String routeName = 'TaskListPage';

  @override
  State<TaskLists> createState() => _TaskListsState();
}

class _TaskListsState extends State<TaskLists> {
  @override
  Widget build(BuildContext context) {
    var fireBaseProvider = Provider.of<FireBaseProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if (userProvider.currentUser != null && userProvider.currentUser!.id != null) {
      if (fireBaseProvider.tasksList.isEmpty) {
        fireBaseProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
      }
    } else {
      return Center(child: Text('User not logged in or invalid ID'));
    }

    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => TaskListItem(task: fireBaseProvider.tasksList[index]),
        itemCount: fireBaseProvider.tasksList.length,
      ),
    );
  }
}

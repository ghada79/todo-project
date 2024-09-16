class Task {
  static const String collectionName = 'Tasks List';
  String id ;
  String title;
  DateTime dateTime ;
  bool isDone ;

  Task({this.id = '', required this.title , required this.dateTime , this.isDone = false});

  Task.fromFireStore(Map <String , dynamic> data) : this (
    id: data['id'] as String,
    title: data['title'] as String,
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    isDone: data['isDone'] as bool,
  );

  Map <String , dynamic> toFireStore(){
    return {
      'id' : id,
      'title' : title,
      'dateTime' : dateTime.millisecondsSinceEpoch,
      'isDone' : isDone
    };
  }

}
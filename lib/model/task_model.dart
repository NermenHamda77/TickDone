class Task{
  static String collectionName = "tasks";
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;
  Task({
    this.id = '' ,
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false
  });

  /// Named Constructor to convert from json to Task
  Task.fromFireStore(Map<String,dynamic> jsonData):this(
    id: jsonData['id'] as String,
    title: jsonData['title'] as String,
    description: jsonData['description'] as String,
    dateTime: DateTime.fromMillisecondsSinceEpoch(jsonData['dateTime']),
    isDone: jsonData['isDone'] as bool
  );

  /// method to convert from Task to json
  Map<String,dynamic> toFireStore(){
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'dateTime' : dateTime.millisecondsSinceEpoch,
      'isDone' : isDone,

    };
  }

}
class TaskModel{
   String uid;
   String description;
  bool isComplete;

  TaskModel({required this.uid,
    required this.description, this.isComplete = false});

}
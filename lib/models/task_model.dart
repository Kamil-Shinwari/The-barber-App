class TaskModel {
  String? taskName;
  String? startDate;
  String? endDate;
  String? userName;
  String? managerName;
  String? priority;
  String? description;
  String? file;
  String? image;
  int? progress;
  String? userImage;

  TaskModel(
      {this.taskName,
      this.startDate,
      this.endDate,
      this.userName,
      this.managerName,
      this.priority,
      this.description,
      this.file,
      this.image,
      this.progress,
      this.userImage});

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'startDate': startDate,
      'endDate': endDate,
      'userName': userName,
      'managerName': managerName,
      'priority': priority,
      'description': description,
      'file': file,
      'image': image,
      'userImage': userImage,
      'progress': 0,
      'status': "pending",
    };
  }
}

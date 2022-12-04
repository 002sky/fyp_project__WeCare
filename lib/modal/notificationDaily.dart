class notificationDaily {
  String taskName;
  String time;

  notificationDaily({
    required this.taskName,
    required this.time,
  });

  factory notificationDaily.fromJson(Map<String, dynamic> json) {
    return notificationDaily(
        taskName: json['taskName'] ?? '', time: json['time'] ?? '');
  }
}

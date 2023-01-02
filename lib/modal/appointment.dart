class Appointment {
  int id;
  String reason;
  String date;
  String time;
  int userID;
  bool? status;
  String? name;

  Appointment(
      {required this.id,
      required this.reason,
      required this.date,
      required this.time,
      required this.status,
      required this.userID,
      required this.name
      });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        id: json['id'],
        reason: json['reason'],
        date: json['date'],
        time: json['time'],
        status: json['status'],
        userID: json['userID'],
        name: json['userName']
        );
  }
}

class Report {
  String name;
  String report;
  String writtenTime;

  Report({required this.name, required this.report, required this.writtenTime});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        name: json['name'],
        report: json['report'],
        writtenTime: json['writtenTime']);
  }
}

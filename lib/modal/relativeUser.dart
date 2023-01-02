class RelativeUser {
  int id;
  String name;

  RelativeUser({required this.id, required this.name});

  factory RelativeUser.fromJson(Map<String, dynamic> json) {
    return RelativeUser(id: json['id'], name: json['name']);
  }
}

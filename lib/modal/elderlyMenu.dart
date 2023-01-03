class ElderlyMenu{
  int id;
  String elderlyName;

  ElderlyMenu({required this.id, required this.elderlyName});

  factory ElderlyMenu.fromJson(Map<String, dynamic> json) {

    return ElderlyMenu(id: json['id'], elderlyName: json['name']);
  }
}

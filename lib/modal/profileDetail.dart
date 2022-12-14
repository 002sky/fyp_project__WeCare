class ProfileDetail {
  final String id;
  final String name;
  final String DOB;
  final String gender;
  final String roomID;
  final String bedID;
  final String elderlyImage;
  final String desc;
  final int erID;

  ProfileDetail({
    required this.id,
    required this.name,
    required this.DOB,
    required this.gender,
    required this.roomID,
    required this.bedID,
    required this.elderlyImage,
    required this.desc,
    required this.erID,
  });

  factory ProfileDetail.fromJson(Map<String, dynamic> json) {
    return ProfileDetail(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      DOB: json['DOB'] ?? '',
      gender: json['gender'] ?? '',
      roomID: json['roomID'] ?? '',
      bedID: json['bedNo'] ?? '',
      desc: json['descrition'] ?? '',
      erID: json['erID'] ?? '',
      elderlyImage: json['elderlyImage'] ?? '',
    );
  }
}

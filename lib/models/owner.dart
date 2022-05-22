class Owner {
  late final String id;
  late final String ownerName;
  late final String fullName;
  late final String email;
  late final String password;
  late final String imagePath;
  late final bool isDarkMode;
  late final List<dynamic> restaurants;

  Owner(
      {required this.ownerName,
      required this.fullName,
      required this.email,
      required this.password});

  factory Owner.fromJSON(dynamic json) {
    Owner owner = Owner(
        ownerName: json['ownerName'] as String,
        fullName: json['fullName'],
        email: json['email'],
        password: json['password']);
    owner.id = json['_id'];
    return owner;
  }

  static Map<String, dynamic> toJson(Owner owner) {
    return {
      'onwerName': owner.ownerName,
      'fullName': owner.fullName,
      'email': owner.email,
      'password': owner.password,
    };
  }
}

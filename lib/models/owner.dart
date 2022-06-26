class Owner {
  late final String id;
  late final String ownerName;
  late final String fullName;
  late final String email;
  late final String password;
  late final String profilePic;
  late final String creationDate;
  late final List<dynamic> listRestaurants;
  late final List<String> role;

  Owner(
      {required this.ownerName,
      required this.fullName,
      required this.email,
      required this.password,
      required this.profilePic});

  factory Owner.fromJSON(dynamic json) {

    Owner owner = Owner(
        ownerName: json['ownerName'] as String,
        fullName: json['fullName'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        profilePic:json['profilePic'] as String,
    );

    owner.role = json['role'].cast<String>();    
    owner.id = json['_id'] as String;
    owner.listRestaurants =  json['listRestaurants'].cast<String>();
    owner.creationDate = json['creationDate'] as String;

    return owner;
  }

  static Map<String, dynamic> toJson(Owner owner) {
    return {
      'ownerName': owner.ownerName,
      'fullName': owner.fullName,
      'email': owner.email,
      'password': owner.password,
      'creationDate': owner.creationDate,
      'profilePic': owner.profilePic,
      'listRestaurants': owner.listRestaurants,
    };
  }
}

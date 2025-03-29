
class AdminUser {

  String? userID;
  String? email;
  String? name;
  String? createAt;

  AdminUser({
    this.userID,
    this.email,
    this.createAt,
    this.name,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['email'] = email;
    map['name'] = name ;
    map['createAt'] =  createAt;
    return map;
  }

  factory AdminUser.fromJson(dynamic json) {
    return AdminUser(
        userID: json['userID'],
        email:json['email'],
        name:json['name'],
        createAt: json['createAt']
    );
  }
}
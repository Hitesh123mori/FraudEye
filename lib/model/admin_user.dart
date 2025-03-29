
class AdminUser {

  String? adminID;
  String? email;
  String? name;
  String? createAt;

  AdminUser({
    this.adminID,
    this.email,
    this.createAt,
    this.name,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adminID'] = adminID;
    map['email'] = email;
    map['name'] = name ;
    map['createAt'] =  createAt;
    return map;
  }

  factory AdminUser.fromJson(dynamic json) {
    return AdminUser(
        adminID: json['adminID'],
        email:json['email'],
        name:json['name'],
        createAt: json['createAt']
    );
  }
}

class BankModel {

  String? userID;
  String? email;
  String? name;
  String? createAt;

  BankModel({
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

  factory BankModel.fromJson(dynamic json) {
    return BankModel(
        userID: json['userID'],
        email:json['email'],
        name:json['name'],
        createAt: json['createAt']
    );
  }
}
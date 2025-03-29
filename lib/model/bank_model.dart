
class BankModel {

  String? bankID;
  String? email;
  String? name;
  String? createAt;

  BankModel({
    this.bankID,
    this.email,
    this.createAt,
    this.name,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bankID'] = bankID;
    map['email'] = email;
    map['name'] = name ;
    map['createAt'] =  createAt;
    return map;
  }

  factory BankModel.fromJson(dynamic json) {
    return BankModel(
        bankID: json['userID'],
        email:json['email'],
        name:json['name'],
        createAt: json['createAt']
    );
  }
}
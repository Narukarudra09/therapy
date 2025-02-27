class UserModel {
  String phoneNumber;
  String userType;

  UserModel({required this.phoneNumber, required this.userType});

  Map<String, dynamic> toMap() {
    return {
      "phoneNumber": phoneNumber,
      "userType": userType,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : phoneNumber = map['phoneNumber'],
        userType = map['userType'];
}

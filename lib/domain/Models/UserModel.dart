import 'dart:convert';

class UserModel {
  String userID;
  String name;
  String email;
  String password;
  String photoID;
  String lastLogin;
  String phoneNumber;
  String lastAttend;
  String lastEleave;
  String address;
  UserModel({
    required this.userID,
    required this.name,
    required this.email,
    required this.password,
    required this.photoID,
    required this.lastLogin,
    required this.phoneNumber,
    required this.lastAttend,
    required this.lastEleave,
    required this.address,
  });

  // Convert UserModel object to a MAP that can be serialized to JSON
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'name': name,
      'photoID': photoID,
      'email': email,
      'password': password,
      'lastLogin': lastLogin,
      'lastAttend': lastAttend,
      'lastEleave': lastEleave,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.loadingUser() {
    return UserModel(
      userID: "",
      name: "Loading",
      photoID: // sample photo
          "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",
      email: "Loading",
      password: "Loading",
      address: "Loading",
      phoneNumber: "Loading",
      lastLogin: 'Loading',
      lastAttend: 'Loading',
      lastEleave: 'Loading',
    );
  }

  /// Create a UserModel object from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'],
      name: json['name'],
      photoID: json['photoID'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      lastLogin: json['lastLogin'],
      lastAttend: json['lastAttend'],
      lastEleave: json['lastEleave'],
    );
  }

  /// Convert the UserModel object to a JSON string
  String toJsonString() {
    Map<String, dynamic> jsonMap = toJson();
    return jsonEncode(jsonMap);
  }

  // Create a UserModel object from a JSON string
  factory UserModel.fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return UserModel.fromJson(jsonMap);
  }
}

import 'dart:convert';

import 'package:bakht/features/user/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String? name,
    int? phone,
    String? location,
    String? province,
    required bool guest,
    required String signUpISODate,
    required int lastLoginEpoch,
    required bool verified,
    String? authUserId,
    required double balanceGold,
    required double balanceSilver,
    required double balanceBronze,
  }) : super(
            id: id,
            guest: guest,
            lastLoginEpoch: lastLoginEpoch,
            signUpISODate: signUpISODate,
            verified: verified,
            location: location,
            phone: phone,
            province: province,
            name: name,
            authUserId: authUserId,
            balanceBronze: balanceBronze,
            balanceGold: balanceGold,
            balanceSilver: balanceSilver);

  factory UserModel.fromFirestoreDoc(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data() as Map;
    return UserModel(
        id: documentSnapshot.id,
        name: data["name"],
        guest: data["guest"],
        signUpISODate: data["signUpISODate"],
        lastLoginEpoch: data["lastLoginEpoch"],
        verified: data["verified"],
        province: data["province"],
        phone: data["phone"],
        location: data["location"],
        authUserId: data["authUserId"],
        balanceBronze: data["balanceBronze"].toDouble(),
        balanceSilver: data["balanceSilver"].toDouble() ,
        balanceGold: data["balanceGold"].toDouble(),
    );
  }

  factory UserModel.fromJson(String json) {
    Map data = jsonDecode(json);
    return UserModel(
        id: data["id"],
        name: data["name"],
        guest: data["guest"],
        signUpISODate: data["signUpISODate"],
        lastLoginEpoch: data["lastLoginEpoch"],
        verified: data["verified"],
        province: data["province"],
        phone: data["phone"],
        location: data["location"],
        authUserId: data["authUserId"],
      balanceBronze: data["balanceBronze"] ,
      balanceSilver: data["balanceSilver"] ,
      balanceGold: data["balanceGold"] ,
    );
  }

  factory UserModel.defaultGuest() {
    return UserModel(
      id: "id",
      name: "guest",
      guest: true,
      signUpISODate: DateTime.now().toIso8601String(),
      lastLoginEpoch: DateTime.now().millisecondsSinceEpoch,
      verified: false,
      balanceBronze: 10,
      balanceSilver: 0,
      balanceGold: 0,
    );
  }

  String toJson() {
    return jsonEncode({
      "id": id,
      "guest": guest,
      "lastLoginEpoch": lastLoginEpoch,
      "signUpISODate": signUpISODate,
      "verified": verified,
      "location": location,
      "phone": phone,
      "province": province,
      "name": name,
      "authUserId": authUserId,
      "balanceBronze": balanceBronze,
      "balanceSilver": balanceSilver,
      "balanceGold": balanceGold,
    });
  }

  Map<String, dynamic> toFirestoreDocumentData() {
    return {
      "id": id,
      "guest": guest,
      "lastLoginEpoch": lastLoginEpoch,
      "signUpISODate": signUpISODate,
      "verified": verified,
      "location": location,
      "phone": phone,
      "province": province,
      "name": name,
      "authUserId": authUserId,
      "balanceBronze": balanceBronze,
      "balanceSilver": balanceSilver,
      "balanceGold": balanceGold,
    };
  }

  @override
  String toString() {
    return {
      "id": id,
      "guest": guest,
      "lastLoginEpoch": lastLoginEpoch,
      "signUpISODate": signUpISODate,
      "verified": verified,
      "location": location,
      "phone": phone,
      "province": province,
      "name": name,
      "authUserId": authUserId,
      "balanceBronze": balanceBronze,
      "balanceSilver": balanceSilver,
      "balanceGold": balanceGold
    }.toString();
  }
}

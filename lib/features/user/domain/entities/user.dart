class User {
  String id;
  String? name;
  int? phone;
  String? location;
  String? province;
  bool guest;
  String signUpISODate;
  int lastLoginEpoch;
  bool verified;
  String? authUserId;
  double balanceGold;
  double balanceSilver;
  double balanceBronze;

  User(
      {required this.id,
         this.authUserId,
      this.name,
      this.phone,
      this.location,
      this.province,
      required this.guest,
      required this.signUpISODate,
      required this.verified,
      required this.lastLoginEpoch,
      required this.balanceGold,
        required this.balanceSilver,
        required this.balanceBronze,
      });
}

class User{
   String id;
   String? name;
   int? phone;
   String? location;
   String? province;
   bool guest;
   String signUpISODate;
   int lastLoginEpoch;
   bool verified;
  User({required this.id,
     this.name,
     this.phone,
     this.location,
     this.province,
    required this.guest,
    required this.signUpISODate,
    required this.verified,
    required this.lastLoginEpoch});


}
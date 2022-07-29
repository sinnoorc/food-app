class User {
  String firstName;
  String email;
  String phone;

  User({
    required this.firstName,
    required this.email,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["user_firstname"],
        email: json["user_email"],
        phone: json["user_phone"],
      );

  Map<String, dynamic> toJson() => {
        "user_firstname": firstName,
        "user_email": email,
        "user_phone": phone,
      };
}

class Country {

  String name, code, dialCode, flag;
  bool isBanned;

  Country(
      {required this.name,
      required this.code,
      required this.dialCode,
      required this.flag,
      required this.isBanned});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
      name: json["name"],
      code: json["code"],
      dialCode: json["dial_code"],
      flag: json["flag"],
      isBanned: json["is_banned"]);

  @override
  String toString() {
    return 'Country{name: $name, code: $code, dialCode: $dialCode}';
  }
}

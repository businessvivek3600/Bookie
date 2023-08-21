class Language {
  final String name;
  final String orgName;
  final String code;
  final String countryCode;
  final int active;
  final int dir;

  Language({
    required this.name,
    required this.orgName,
    required this.code,
    required this.countryCode,
    required this.active,
    required this.dir,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['name'] ?? '',
      orgName: json['eName'] ?? '',
      code: json['code'] ?? '',
      countryCode: json['countryCode'] ?? '',
      active: json['active'] ?? 0,
      dir: int.parse(json['dir'] ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'eName': orgName,
      'code': code,
      'countryCode': countryCode,
      'active': active,
      'dir': dir,
    };
  }
}

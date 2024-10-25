class AccountModel {
    AccountModel({
        required this.id,
        required this.name,
        required this.password,
        required this.email,
        required this.devicesToken,
        required this.followers,
        required this.following,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? name;
    final String? password;
    final String? email;
    final List<dynamic> devicesToken;
    final List<String> followers;
    final List<dynamic> following;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory AccountModel.fromJson(Map<String, dynamic> json){ 
        return AccountModel(
            id: json["_id"],
            name: json["name"],
            password: json["password"],
            email: json["email"],
            devicesToken: json["devicesToken"] == null ? [] : List<dynamic>.from(json["devicesToken"]!.map((x) => x)),
            followers: json["followers"] == null ? [] : List<String>.from(json["followers"]!.map((x) => x)),
            following: json["following"] == null ? [] : List<dynamic>.from(json["following"]!.map((x) => x)),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

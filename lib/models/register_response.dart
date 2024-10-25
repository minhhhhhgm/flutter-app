class RegisterResponse {
    RegisterResponse({
        required this.name,
        required this.password,
        required this.email,
        required this.devicesToken,
        required this.followers,
        required this.following,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? name;
    final String? password;
    final String? email;
    final List<dynamic> devicesToken;
    final List<dynamic> followers;
    final List<dynamic> following;
    final String? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory RegisterResponse.fromJson(Map<String, dynamic> json){ 
        return RegisterResponse(
            name: json["name"],
            password: json["password"],
            email: json["email"],
            devicesToken: json["devicesToken"] == null ? [] : List<dynamic>.from(json["devicesToken"]!.map((x) => x)),
            followers: json["followers"] == null ? [] : List<dynamic>.from(json["followers"]!.map((x) => x)),
            following: json["following"] == null ? [] : List<dynamic>.from(json["following"]!.map((x) => x)),
            id: json["_id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "email": email,
        "devicesToken": devicesToken.map((x) => x).toList(),
        "followers": followers.map((x) => x).toList(),
        "following": following.map((x) => x).toList(),
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };

}

class PostResponse {
    PostResponse({
        required this.likes,
        required this.id,
        required this.author,
        required this.content,
        required this.image,
        required this.createdAt,
        required this.v,
        required this.likeCount,
    });

    final List<dynamic> likes;
    final String? id;
    final Author? author;
    final String? content;
    final String? image;
    final DateTime? createdAt;
    final int? v;
    final int? likeCount;

    factory PostResponse.fromJson(Map<String, dynamic> json){ 
        return PostResponse(
            likes: json["likes"] == null ? [] : List<dynamic>.from(json["likes"]!.map((x) => x)),
            id: json["_id"],
            author: json["author"] == null ? null : Author.fromJson(json["author"]),
            content: json["content"],
            image: json["image"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            v: json["__v"],
            likeCount: json["likeCount"],
        );
    }

}

class Author {
    Author({
        required this.id,
        required this.name,
    });

    final String? id;
    final String? name;

    factory Author.fromJson(Map<String, dynamic> json){ 
        return Author(
            id: json["_id"],
            name: json["name"],
        );
    }

}

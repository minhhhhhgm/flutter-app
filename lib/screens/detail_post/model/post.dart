class Post {
    Post({
        required this.id,
        required this.author,
        required this.content,
        required this.createdAt,
        required this.v,
         required this.image,
    });

    final String? id;
    final String? image;

    final String? author;
    final String? content;
    final DateTime? createdAt;
    final int? v;

    factory Post.fromJson(Map<String, dynamic> json){ 
        return Post(
            id: json["_id"],
            author: json["author"],
            content: json["content"],
            image: json["image"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            v: json["__v"],
        );
    }

}

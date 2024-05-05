import 'package:fyp/features/blog/domain/entity/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    super.userName,
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageURL,
    required super.topics,
    required super.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': userName,
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageURL,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageURL,
    String? userName,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageURL: imageURL ?? this.imageURL,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      userName: userName ?? this.userName,
    );
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageURL: map['image_url'] as String,
      topics: List<String>.from(
        (map['topics'] ?? []),
      ),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }
}

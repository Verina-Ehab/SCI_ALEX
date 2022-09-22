
class Post {
  // final String id;
  final String title;
  // final String photo;
  final String content;
  final String createdAt;


  Post(
 {
    // required this.id,
    required this.title,
    // required this.photo,
    required this.content,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    return Post(
      // id: parsedJson['id'],
      title: parsedJson['title'],
      // photo: parsedJson['photo'],
      content: parsedJson['content'],
      createdAt: parsedJson['created_at'],
    );
  }


}

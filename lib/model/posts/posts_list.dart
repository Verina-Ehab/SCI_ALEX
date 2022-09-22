class PostsList{

  final List<dynamic> posts;

  PostsList({required this.posts});
  
  factory PostsList.fromJson(Map<String, dynamic> jsonData) {
    return PostsList(
      posts: jsonData['post'],
    );
  }
}
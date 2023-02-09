class Post {
  final int id;
  final String user_id;
  final String title;
  final String short_text;
  final String image;

  Post({
    required this.id,
    required this.user_id,
    required this.title,
    required this.short_text,
    required this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      user_id: json['user_id'],
      title: json['title'],
      short_text: json['short_text'],
      image: json['image'],
    );
  }
}
class PostDetail {
  final int id;
  final String user_id;
  final String title;
  final String short_text;
  final String content;
  final String image;

  PostDetail({
    required this.id,
    required this.user_id,
    required this.title,
    required this.short_text,
    required this.content,
    required this.image,
  });

  factory PostDetail.fromJson(Map<String, dynamic> json) {
    return PostDetail(
      id: json['id'],
      user_id: json['user_id'],
      title: json['title'],
      short_text: json['short_text'],
      content: json['content'],
      image: json['image'],
    );
  }
}
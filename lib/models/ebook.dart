class Ebook {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;

  Ebook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
  });

  factory Ebook.fromJson(Map<String, dynamic> json) {
    return Ebook(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverUrl: json['cover_url'] ?? '',
      downloadUrl: json['download_url'],
    );
  }
}

class Blog {
  final String id;
  final String imageUrl;
  final String title;
  bool isFavorite;

  Blog({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.isFavorite = false,
  });
}
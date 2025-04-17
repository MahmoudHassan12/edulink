enum ContentType { video, pdf, image }

class ContentItem {
  ContentItem({
    required this.title,
    required this.description,
    required this.type,
    required this.url,
  });
  final String title;
  final String description;
  final ContentType type;
  final String url;
}

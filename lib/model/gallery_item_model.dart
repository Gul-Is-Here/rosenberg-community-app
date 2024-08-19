class GalleryItem {
  final int id;
  final String name;
  final String url;

  GalleryItem({required this.id, required this.name, required this.url});

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }
}

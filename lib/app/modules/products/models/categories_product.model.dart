class CategoriesProductModel {
  late String slug;
  late String name;
  late String url;

  CategoriesProductModel({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory CategoriesProductModel.fromJson(Map<String, dynamic> json) {
    return CategoriesProductModel(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"slug": slug, "name": name, "url": url};
  }
}

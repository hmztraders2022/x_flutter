class MallProductModel {
  late int id;
  late String title;
  late double price;
  late String description;
  late List<String> images;

  MallProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
  });

  factory MallProductModel.fromJson(Map<String, dynamic> json) {
    return MallProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "price": price, "description": description, "images": images};
  }
}

class ProductModel {
  late int id;
  late String title;
  late double price;
  late String category;
  late String description;
  late String image;

  ProductModel({required this.id, required this.title, required this.price, required this.category, required this.description, required this.image});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = double.tryParse(json['price'].toString())!;
    category = json['category'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "price": price, "category": category, "description": description, "image": image};
  }
}

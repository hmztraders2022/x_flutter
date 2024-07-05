class ProductDetailModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double discountPercentage;
  final double price;
  final int stock;
  final double rating;
  final List<String> images;

  ProductDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.discountPercentage,
    required this.price,
    required this.stock,
    required this.rating,
    required this.images,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      discountPercentage: double.tryParse(json['discountPercentage'].toString())!,
      price: json['price'],
      stock: json['stock'],
      rating: double.tryParse(json['rating'].toString())!,
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'discountPercentage': discountPercentage,
      'price': price,
      'stock': stock,
      'rating': rating,
      'images': images,
    };
  }
}

class DetailProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double discountPercentage;
  final double price;
  final int stock;
  final double rating;
  final List<dynamic> images;

  DetailProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.discountPercentage,
    required this.price,
    required this.stock,
    required this.rating,
    required this.images,
  });

  factory DetailProductModel.fromJson(Map<String, dynamic> json) {
    return DetailProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      discountPercentage: double.tryParse(json['discountPercentage'].toString())!,
      price: json['price'],
      stock: json['stock'],
      rating: double.tryParse(json['rating'].toString())!,
      images: List<dynamic>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'discountPercentage': discountPercentage,
      'price': price,
      'stock': stock,
      'rating': rating,
      'images': images,
    };
  }
}

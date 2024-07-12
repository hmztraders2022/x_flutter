class TableKeuanganModel {
  final int id;
  final String name;
  final String email;

  TableKeuanganModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory TableKeuanganModel.fromJson(Map<String, dynamic> json) {
    return TableKeuanganModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

class TableKeuanganModelNew {
  final int id;
  final String title;
  final String tanggal;
  final int isActive;

  TableKeuanganModelNew({
    required this.id,
    required this.title,
    required this.tanggal,
    required this.isActive,
  });

  factory TableKeuanganModelNew.fromJson(Map<String, dynamic> json) {
    return TableKeuanganModelNew(
      id: json['id'],
      title: json['title'],
      tanggal: json['tanggal'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tanggal': tanggal,
      'isActive': isActive,
    };
  }
}

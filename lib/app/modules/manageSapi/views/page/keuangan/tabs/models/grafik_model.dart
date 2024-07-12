class GrafikModel {
  final String tanggal;
  final int sales;

  GrafikModel({required this.tanggal, required this.sales});

  factory GrafikModel.fromJson(Map<String, dynamic> json) {
    return GrafikModel(
      tanggal: json['tanggal'],
      sales: json['sales'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal,
      'sales': sales,
    };
  }
}

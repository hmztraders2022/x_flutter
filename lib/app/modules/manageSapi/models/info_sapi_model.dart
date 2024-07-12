class InfoSapiModel {
  final int idC;
  final DateTime dateCreated;
  final String subtitle;
  final int isActive;
  final int isExpired;
  final String desc;
  final String author;

  InfoSapiModel({
    required this.idC,
    required this.dateCreated,
    required this.subtitle,
    required this.isActive,
    required this.isExpired,
    required this.desc,
    required this.author,
  });

  factory InfoSapiModel.fromJson(Map<String, dynamic> json) {
    return InfoSapiModel(
      idC: json['idC'],
      dateCreated: DateTime.parse(json['dateCreated']),
      subtitle: json['subtitle'],
      isActive: json['isActive'],
      isExpired: json['isExpired'],
      desc: json['desc'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idC': idC,
      'dateCreated': dateCreated.toIso8601String(),
      'subtitle': subtitle,
      'isActive': isActive,
      'isExpired': isExpired,
      'desc': desc,
      'author': author,
    };
  }
}

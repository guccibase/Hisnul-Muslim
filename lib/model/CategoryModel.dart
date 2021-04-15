class CategoryModel {
  final String id;
  final String ar_title;
  final String en_title;
  final String fr_title;

  CategoryModel({this.id, this.ar_title, this.en_title, this.fr_title});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return new CategoryModel(
      id: json['_id'].toString(),
      ar_title: json['ar_title'],
      en_title: json['en_title'],
      fr_title: json['fr_title'],
    );
  }
}

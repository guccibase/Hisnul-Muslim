class ItemModel {
  final String id;
  final String ar_dua;
  final String ar_reference;
  final String en_reference;
  final String en_translation;
  final String group_id;

  ItemModel(
      {this.id,
      this.ar_dua,
      this.ar_reference,
      this.en_reference,
      this.en_translation,
      this.group_id});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["_id"].toString(),
      ar_dua: json["ar_dua"],
      ar_reference: json["ar_reference"],
      en_reference: json["en_reference"],
      en_translation: json["en_translation"],
      group_id: json["group_id"].toString(),
    );
  }
}

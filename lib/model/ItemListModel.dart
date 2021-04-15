import 'package:hisnul_muslim/model/ItemModel.dart';

class ItemListModel {
  final List<ItemModel> itemList;

  ItemListModel({this.itemList});

  factory ItemListModel.fromJson(List<dynamic> json, String groupId) {
    List<ItemModel> list = new List<ItemModel>();
    //list = json.map((model) => ItemModel.fromJson(model)).toList();

    json.forEach((element) {
      if (element["group_id"].toString() == groupId) {
        list.add(ItemModel.fromJson(element));
      }
    });

    return new ItemListModel(itemList: list);
  }
}

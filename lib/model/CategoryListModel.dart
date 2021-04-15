import 'package:hisnul_muslim/model/CategoryModel.dart';

class CategoryListModel {
  final List<CategoryModel> catList;

  CategoryListModel({
    this.catList,
  });

  factory CategoryListModel.fromJson(List<dynamic> parsedJson) {
    List<CategoryModel> photos = new List<CategoryModel>();
    photos = parsedJson.map((i) => CategoryModel.fromJson(i)).toList();
    return new CategoryListModel(catList: photos);
  }
}

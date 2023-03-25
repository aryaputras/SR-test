import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  Category({
    this.idCategory = "",
    this.strCategory = "",
    this.strCategoryThumb = "",
    this.strCategoryDescription = "",
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      idCategory: json['idCategory'] as String? ?? "",
      strCategory: json['strCategory'] as String? ?? "",
      strCategoryThumb: json['strCategoryThumb'] as String? ?? "",
      strCategoryDescription: json['strCategoryDescription'] as String? ?? "",
    );
  }

  @override
  List<Object> get props =>
      [idCategory, strCategory, strCategoryThumb, strCategoryDescription];
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icream/utils/constants.dart';

import '../models/category_model.dart';
import '../utils/strings.dart';

class CategoryProvider extends ChangeNotifier {
  final categoryController = StreamController<List<dynamic>>.broadcast();
  final homeCategoryController = StreamController<List<dynamic>>.broadcast();

  StreamSink<List<dynamic>> get homeICreamCategorySink =>
      homeCategoryController.sink;
  Stream<List<dynamic>> get homeICreamCategoryStream =>
      homeCategoryController.stream;

  StreamSink<List<dynamic>> get iCreamCategorySink => categoryController.sink;
  Stream<List<dynamic>> get iCreamCategoryStream => categoryController.stream;

  List<Map<String, dynamic>> iceCreamCategory = [];

  updateHomeICreamCategories() async {
    List<Categories> homeCategory;
    Future.delayed(const Duration(milliseconds: 600), () {
      homeCategory = categories;
      homeICreamCategorySink.add(homeCategory);
    });
  }

  updateICreamCategories() async {
    List<Map<String, dynamic>> iCreamCategory;
    Future.delayed(const Duration(milliseconds: 600), () {
      iCreamCategory = iceCreamCategory;
      iCreamCategorySink.add(iCreamCategory);
    });
  }

  filterICreamCategories(category) {
    var iceCreams = iCreamCategories
        .where((element) =>
            element['category'].toString().toLowerCase() ==
            category.toLowerCase())
        .toList();
    iceCreamCategory = iceCreams[0]['details'];
    print(iceCreamCategory.length);
  }
}

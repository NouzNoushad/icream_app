import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import '../services/auth_service.dart';
import '../utils/strings.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    updateICreamData();
  }

  TextEditingController searchController = TextEditingController();

  final iCreamController = StreamController<List<dynamic>>.broadcast();
  StreamSink<List<dynamic>> get iCreamSink => iCreamController.sink;
  Stream<List<dynamic>> get iCreamStream => iCreamController.stream;

  FocusNode searchFocusNode = FocusNode();
  AuthService authService = AuthService();

  bool searchingTastyICream = false;
  String searchValue = '';
  List iceCreamCategory = [];
  List searchByName = [];
  Placemark? place;

  updateICreamData() {
    List<Map<String, dynamic>> iCreams;
    Future.delayed(const Duration(milliseconds: 600), () {
      iCreams = iCreamCategories;
      iCreamController.sink.add(iCreams);
    });
  }

  onSearchingICreams(text) {
    searchValue = text;
    if (text.isEmpty) {
      searchingTastyICream = false;
    } else {
      searchingTastyICream = true;
    }
    notifyListeners();
  }

  searchICreams() {
    var allICreams = iCreamCategories
        .where((element) =>
            element['category'].toString().toLowerCase() ==
            'All Brands'.toLowerCase())
        .toList();
    searchByName = allICreams[0]['details'];
  }

  searchICreamByName() {
    iceCreamCategory = searchByName.where((search) {
      print(
          'searchText::::::::::::::: ${search['name'].toString().toLowerCase()}');
      return search['name']
          .toString()
          .toLowerCase()
          .contains(searchValue.toLowerCase());
    }).toList();
    print('search::::::::::::::: ${searchValue.toLowerCase()}');
    print('iceCreamCategory::::::::::::::: ${iceCreamCategory.length}');
  }

  @override
  void dispose() {
    iCreamController.close();
    searchController.dispose();
    super.dispose();
  }
}

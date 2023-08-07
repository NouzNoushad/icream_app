import 'package:flutter/material.dart';
import 'package:icream/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../icream_category/categories.dart';

class ICreamSearch extends StatefulWidget {
  const ICreamSearch({super.key});

  @override
  State<ICreamSearch> createState() => _ICreamSearchState();
}

class _ICreamSearchState extends State<ICreamSearch> {
  @override
  void initState() {
    var homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.searchICreams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, child) {
      value.searchICreamByName();
      return Expanded(
          child: CategoryICreams(
        iceCreamCategory: value.iceCreamCategory,
      ));
    });
  }
}

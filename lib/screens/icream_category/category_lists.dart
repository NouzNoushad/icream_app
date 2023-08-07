import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/screens/icream_category/categories.dart';
import 'package:icream/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/category_provider.dart';

class CategoryLists extends StatefulWidget {
  final String category;
  const CategoryLists({super.key, required this.category});

  @override
  State<CategoryLists> createState() => _CategoryListsState();
}

class _CategoryListsState extends State<CategoryLists> {
  late CategoryProvider categoryProvider;
  @override
  void initState() {
    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.updateICreamCategories();
    categoryProvider.filterICreamCategories(widget.category);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    categoryProvider.updateICreamCategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider.updateICreamCategories();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Column(children: [
          Container(
            width: size.width,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromRGBO(254, 11, 157, 1),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.category.toUpperCase(),
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(254, 11, 157, 1)),
                ),
              ],
            ),
          ),
          Expanded(child:
              Consumer<CategoryProvider>(builder: (context, category, child) {
            return StreamBuilder(
                stream: category.iCreamCategoryStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No ICreams Found',
                        ),
                      );
                    }
                    return CategoryICreams(
                      iceCreamCategory: category.iceCreamCategory,
                    );
                  }
                  return Shimmer.fromColors(
                    baseColor: Colors.pink.shade100,
                    highlightColor: Colors.pink.shade200,
                    child: const CategoryICreams(
                      iceCreamCategory: null,
                    ),
                  );
                });
          })),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/screens/widgets/location_container.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/category_provider.dart';
import '../../utils/colors.dart';
import 'category_lists.dart';

class ICreamCategory extends StatefulWidget {
  const ICreamCategory({super.key});

  @override
  State<ICreamCategory> createState() => _ICreamCategoryState();
}

class _ICreamCategoryState extends State<ICreamCategory> {
  late CategoryProvider categoryProvider;

  @override
  void initState() {
    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.updateHomeICreamCategories();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    categoryProvider.updateHomeICreamCategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider.updateHomeICreamCategories();

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Text(
              'Categories',
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          const LocationContainer(),
          Expanded(
            child: Container(
              color: const Color.fromRGBO(254, 11, 157, 0.04),
              child: StreamBuilder(
                  stream: categoryProvider.homeICreamCategoryStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'No ICreams Found',
                          ),
                        );
                      }
                      return HomeICreamCategories(
                        categories: snapshot.data,
                      );
                    }
                    return Shimmer.fromColors(
                        baseColor: Colors.pink.shade100,
                        highlightColor: Colors.pink.shade200,
                        child: const HomeICreamCategories(
                          categories: null,
                        ));
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}

class HomeICreamCategories extends StatelessWidget {
  final categories;
  const HomeICreamCategories({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
        itemCount: categories != null ? categories.length : 4,
        itemBuilder: (context, index) {
          var category =  categories != null ? categories[index] : [];
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CategoryLists(category: category.title!))),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(254, 11, 157, 0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 4, color: Colors.white),
              ),
              padding: const EdgeInsets.all(4),
              child: Column(children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      child: categories != null
                          ? Image.asset(
                              'assets/images/${category.image}',
                              height: size.height * 0.12,
                              width: size.width * 0.25,
                            )
                          : Container(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    categories != null ? category.title! : '',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  ),
                ),
              ]),
            ),
          );
        });
  }
}

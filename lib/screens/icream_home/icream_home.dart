import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/providers/home_provider.dart';
import 'package:icream/screens/icream_category/category_lists.dart';
import 'package:icream/screens/icream_home/icream_lists.dart';
import 'package:icream/screens/widgets/location_container.dart';
import 'package:icream/utils/colors.dart';
import 'package:icream/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/location_provider.dart';
import '../icream_search/icream_search.dart';
import 'icream_titles.dart';

class ICreamHome extends StatefulWidget {
  const ICreamHome({super.key});

  @override
  State<ICreamHome> createState() => _ICreamHomeState();
}

class _ICreamHomeState extends State<ICreamHome> {
  late LocationProvider locationProvider;
  late HomeProvider homeProvider;
  List<String> iCreams = ['Ice Creams', 'Ice Cream Bars', 'Candies', 'Cakes'];

  @override
  void initState() {
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    locationProvider.getCurrentPosition(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    homeProvider = context.watch<HomeProvider>();
    homeProvider.updateICreamData();
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    homeProvider.updateICreamData();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Consumer<HomeProvider>(builder: (context, value, child) {
          return Column(children: [
            Column(
              children: [
                Container(
                  height: size.height * 0.06,
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: value.searchController,
                    onChanged: (text) => value.onSearchingICreams(text),
                    focusNode: value.searchFocusNode,
                    onTapOutside: (event) => value.searchFocusNode.unfocus(),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1.5,
                              color: CustomColors.searchBorderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1.5,
                              color: CustomColors.searchBorderColor),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        hintText: 'Search your favorite',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          color: CustomColors.searchHintColor,
                        )),
                  ),
                ),
                const LocationContainer(),
              ],
            ),
            value.searchingTastyICream
                ? const ICreamSearch()
                : Expanded(
                    child: StreamBuilder<List<dynamic>>(
                        stream: value.iCreamStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No ICreams Found',
                                ),
                              );
                            }
                            return iCreamsList(size);
                          }
                          return Shimmer.fromColors(
                              baseColor: Colors.pink.shade100,
                              highlightColor: Colors.pink.shade200,
                              child: iCreamsList(size));
                          // return Center(
                          //   child: Lottie.asset(
                          //       'assets/lottie/ice-cream-animation.json'),
                          // );
                        }),
                  ),
          ]);
        }),
      ),
    );
  }

  Widget iCreamsList(size) => ListView(children: [
        Container(
          height: size.height * 0.08,
          color: Colors.pink.shade900,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.separated(
            itemCount: iCreams.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
              width: 6,
            ),
            itemBuilder: (context, index) {
              var iCream = iCreams[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoryLists(category: iCream))),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: Border.all(width: 1.5, color: Colors.white)),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    iCream,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          color: const Color.fromRGBO(254, 11, 157, 0.04),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
              children: iCreamCategories
                  .map((icream) => Column(
                        children: [
                          ICreamTitles(
                            size: size,
                            title: icream['category'],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ICreamLists(
                            iceCreams: icream['details'],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ))
                  .toList()),
        )
      ]);
}

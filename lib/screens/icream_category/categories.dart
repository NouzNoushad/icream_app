import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../icream_details/icream_details.dart';

class CategoryICreams extends StatelessWidget {
  final iceCreamCategory;
  const CategoryICreams({super.key, required this.iceCreamCategory});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: const Color.fromRGBO(254, 11, 157, 0.04),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6),
        itemCount: iceCreamCategory != null ? iceCreamCategory.length : 4,
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          var category =
              iceCreamCategory != null ? iceCreamCategory[index] : [];

          return Container(
            width: size.width * 0.5,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(254, 11, 157, 0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 4, color: Colors.white),
            ),
            padding: const EdgeInsets.all(6),
            child: Stack(children: [
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ICreamDetails(
                          iCream: category,
                        ))),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        // Image.network(
                        //   category['image'],
                        //   height: size.height * 0.2,
                        //   width: size.width * 0.45,
                        // ),
                        iceCreamCategory != null
                            ? CachedNetworkImage(
                                imageUrl: category['image'],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                iceCreamCategory != null
                                    ? category['name']
                                    : '',
                                style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)
                                    .copyWith(overflow: TextOverflow.ellipsis),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                width: size.width * 0.25,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      iceCreamCategory != null
                                          ? category['flavour']
                                          : '',
                                      style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)
                                          .copyWith(
                                              overflow: TextOverflow.ellipsis),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      iceCreamCategory != null
                                          ? '\$${category['price']}'
                                          : '',
                                      style: GoogleFonts.poppins(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(
                          width: 1.5,
                          color: const Color.fromRGBO(254, 11, 157, 0.06))),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Color.fromARGB(255, 255, 179, 204),
                    size: 22,
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}

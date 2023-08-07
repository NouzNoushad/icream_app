import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/providers/cart_provider.dart';
import 'package:icream/screens/icream_details/icream_details.dart';
import 'package:provider/provider.dart';

class ICreamLists extends StatelessWidget {
  final List iceCreams;
  const ICreamLists({super.key, required this.iceCreams});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    // var homeProvider = Provider.of<HomeProvider>(context);
    return Container(
      height: size.height * 0.42,
      color: Colors.transparent,
      margin: const EdgeInsets.only(left: 12),
      child: ListView.separated(
        itemCount: iceCreams.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final iceCream = iceCreams[index];

          return Container(
            width: size.width * 0.48,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(254, 11, 157, 0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 4, color: Colors.white),
            ),
            padding: const EdgeInsets.all(7),
            child: Stack(children: [
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ICreamDetails(
                          iCream: iceCream,
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
                        // Image.network(
                        //   iceCream['image'],
                        //   height: size.height * 0.2,
                        //   width: size.width * 0.45,
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        CachedNetworkImage(
                          imageUrl: iceCream['image'],
                          imageBuilder: (context, imageProvider) => Container(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                iceCream['name'],
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
                                      iceCream['flavour'],
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
                                      '\$${iceCream['price']}',
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
                child: GestureDetector(
                  onTap: () async {
                    await cartProvider.addICreamToCart(
                        context,
                        iceCream['image'],
                        iceCream['name'],
                        iceCream['flavour'],
                        iceCream['price'] + 0.0,
                        1);
                  },
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
              ),
            ]),
          );
        },
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/location_provider.dart';

class ICreamDetails extends StatefulWidget {
  final iCream;
  const ICreamDetails({super.key, required this.iCream});

  @override
  State<ICreamDetails> createState() => _ICreamDetailsState();
}

class _ICreamDetailsState extends State<ICreamDetails> {
  late LocationProvider locationProvider;

  @override
  void initState() {
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    locationProvider.getCurrentPosition(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        floatingActionButton: Container(
          width: size.width,
          height: size.height * 0.075,
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () async {
              await cartProvider.addICreamToCart(
                  context,
                  widget.iCream['image'],
                  widget.iCream['name'],
                  widget.iCream['flavour'],
                  widget.iCream['price'] + 0.0,
                  1);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(254, 11, 157, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 1.5, color: Colors.black))),
            child: Text(
              'Add To Cart',
              style: GoogleFonts.poppins(fontSize: 18, letterSpacing: 0.5),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 15),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1.2,
                          color: Color.fromRGBO(254, 11, 157, 0.12)))),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromRGBO(254, 11, 157, 1),
                      )),
                  Text(
                    widget.iCream['name'],
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(254, 11, 157, 0.2),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: [
                    Container(
                      color: const Color.fromRGBO(254, 11, 157, 0.06),
                      height: size.height * 0.42,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 1.5,
                                color: const Color.fromRGBO(254, 11, 157, 0.2)),
                          ),
                          height: size.height * 0.4,
                          width: size.width * 0.95,
                          child: CachedNetworkImage(
                            imageUrl: widget.iCream['image'],
                            imageBuilder: (context, imageProvider) => Container(
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
                          // child: Image.network(iCream['image']),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(254, 11, 157, 0.06),
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Column(children: [
                        const ICreamDetailsTitle(
                          title: 'Details',
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1.5,
                                color: const Color.fromRGBO(254, 11, 157, 0.2),
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ICreamSpecifications(
                                title: 'Name',
                                details: widget.iCream['name'],
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              ICreamSpecifications(
                                title: 'Weight',
                                details: '${widget.iCream['weight']}g',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              ICreamSpecifications(
                                  title: 'Price',
                                  details: '\$${widget.iCream['price']}',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: const Color.fromRGBO(207, 0, 0, 1)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const ICreamDetailsTitle(
                          title: 'Specifications',
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 1.5,
                                  color:
                                      const Color.fromRGBO(254, 11, 157, 0.2)),
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.all(8),
                          child: Column(children: [
                            ICreamSpecifications(
                              title: 'Brand',
                              details: widget.iCream['brand'],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            ICreamSpecifications(
                              title: 'Flavour',
                              details: widget.iCream['flavour'],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            ICreamSpecifications(
                              title: 'Weight',
                              details: '${widget.iCream['weight']}g',
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            ICreamSpecifications(
                              title: 'Country',
                              details: widget.iCream['country'],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            ICreamSpecifications(
                              title: 'Manufacturer',
                              details: widget.iCream['Manufacturer'],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const ICreamDetailsTitle(
                          title: 'Delivery',
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 1.5,
                                  color:
                                      const Color.fromRGBO(254, 11, 157, 0.2)),
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Express Delivery',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                locationProvider.place,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.09,
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class ICreamDetailsTitle extends StatelessWidget {
  final String? title;
  const ICreamDetailsTitle({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              width: 1.5, color: const Color.fromRGBO(254, 11, 157, 0.2)),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(8),
      child: Text(
        title!,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }
}

class ICreamSpecifications extends StatelessWidget {
  final String? title;
  final String? details;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  const ICreamSpecifications({
    super.key,
    this.title,
    this.details,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 14.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title!,
            style: GoogleFonts.poppins(
                fontWeight: fontWeight,
                fontSize: fontSize,
                color: Colors.black),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            details!,
            style: GoogleFonts.poppins(
                fontWeight: fontWeight, fontSize: fontSize, color: color),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class ICreamCartItems extends StatelessWidget {
  final snapshot;
  const ICreamCartItems({super.key, this.snapshot});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    int items = snapshot != null ? snapshot.data!.docs.length : 0;
    num total = snapshot != null
        ? snapshot.data!.docs.fold(0,
            (value, element) => value + (element['price'] * element['count']))
        : 0;
    print('######################## total, $total');
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              itemCount: snapshot != null ? snapshot.data!.docs.length : 4,
              separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
              itemBuilder: (context, index) {
                var iCreamCart =
                    snapshot != null ? snapshot.data!.docs[index] : [];

                return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(254, 11, 157, 0.06),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 4, color: Colors.white),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      height: size.height * 0.14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 4, color: Colors.white),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Row(children: [
                        Expanded(
                          child: Row(children: [
                            snapshot != null
                                ? Image.network(
                                    iCreamCart['image'],
                                    height: size.height * 0.2,
                                    width: size.width * 0.2,
                                  )
                                : Container(),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    snapshot != null ? iCreamCart['name'] : '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    snapshot != null
                                        ? iCreamCart['flavour']
                                        : '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    snapshot != null
                                        ? '\$${iCreamCart['price'] * iCreamCart['count']}'
                                        : '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await cartProvider.removeICreamFromCart(
                                    context, iCreamCart.id);
                              },
                              child: Container(
                                height: size.height * 0.05,
                                width: size.width * 0.1,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(254, 11, 157, 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                  // border: Border.all(
                                  //     width: 1, color: Colors.black)
                                ),
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.035,
                              width: size.width * 0.20,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(254, 11, 157, 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.all(2),
                              child: Row(children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        cartProvider.incrementCartICreamCount(
                                            iCreamCart.id, iCreamCart['count']),
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot != null
                                          ? iCreamCart['count'].toString()
                                          : '',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: const Color.fromRGBO(
                                              254, 11, 157, 0.4),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        cartProvider.decrementCartICreamCount(
                                            iCreamCart.id, iCreamCart['count']),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ]),
                    ));
              }),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(
                    width: 1.5, color: Color.fromRGBO(254, 11, 157, 0.12))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot != null ? 'Total Amount ( $items items )' : '',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    snapshot != null ? '\$$total' : '',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.065,
                width: size.width * 0.4,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(254, 11, 157, 1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              width: 1.5,
                              color: Colors.black,
                            ))),
                    child: Text(
                      'Checkout',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}

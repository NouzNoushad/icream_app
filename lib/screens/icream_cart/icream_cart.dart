import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/colors.dart';
import '../widgets/location_container.dart';
import 'icream_items.dart';

class ICreamCart extends StatefulWidget {
  const ICreamCart({super.key});

  @override
  State<ICreamCart> createState() => _ICreamCartState();
}

class _ICreamCartState extends State<ICreamCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 0, 12),
            child: Text(
              'Cart',
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          const LocationContainer(),
          Expanded(
            child: Container(
              color: const Color.fromRGBO(254, 11, 157, 0.04),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('iCreamCart')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Shimmer.fromColors(
                        baseColor: Colors.pink.shade100,
                        highlightColor: Colors.pink.shade200,
                        child: const ICreamCartItems(snapshot: null),
                      );
                    } else {
                      return ICreamCartItems(
                        snapshot: snapshot,
                      );
                    }
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}

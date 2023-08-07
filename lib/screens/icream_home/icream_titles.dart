import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/screens/icream_category/category_lists.dart';

class ICreamTitles extends StatelessWidget {
  final Size? size;
  final String? title;
  const ICreamTitles({super.key, this.size, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size!.height * 0.05,
      padding: const EdgeInsets.fromLTRB(20, 4, 0, 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 2, color: Color.fromRGBO(254, 11, 157, 0.06)),
          bottom:
              BorderSide(width: 2, color: Color.fromRGBO(254, 11, 157, 0.06)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategoryLists(category: title!))),
            child: Container(
              width: size!.width * 0.2,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(254, 11, 157, 0.06),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )),
              alignment: Alignment.center,
              child: Text(
                'Open All',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color.fromRGBO(254, 11, 157, 0.62),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

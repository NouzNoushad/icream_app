import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/location_provider.dart';
import '../../utils/colors.dart';

class LocationContainer extends StatefulWidget {
  const LocationContainer({super.key});

  @override
  State<LocationContainer> createState() => _LocationContainerState();
}

class _LocationContainerState extends State<LocationContainer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: CustomColors.lightGreenColor,
        border: Border.all(width: 1.5, color: Colors.white),
      ),
      child: Consumer<LocationProvider>(builder: (context, location, child) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Location',
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              Text(
                location.place,
                style:
                    GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ]);
      }),
    );
  }
}

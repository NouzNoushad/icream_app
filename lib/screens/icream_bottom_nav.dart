import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icream/providers/bottom_nav_provider.dart';
import 'package:icream/utils/colors.dart';
import 'package:provider/provider.dart';

class ICreamBottomNav extends StatelessWidget {
  const ICreamBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomNavProvider = Provider.of<BottomNavProvider>(context);
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GNav(
          selectedIndex: bottomNavProvider.selectedIndex,
          tabBackgroundColor: const Color.fromRGBO(254, 11, 157, 0.15),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          tabMargin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          gap: 4,
          textStyle: GoogleFonts.poppins(),
          onTabChange: (value) => bottomNavProvider.setNavIndex(value),
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.category_outlined,
              text: 'Category',
            ),
            GButton(
              icon: Icons.shopping_cart_outlined,
              text: 'Cart',
            ),
            GButton(
              icon: Icons.person_outlined,
              text: 'Profile',
            ),
          ],
        ),
      ),
      body: bottomNavProvider
          .selectBottomNavItems(bottomNavProvider.selectedIndex),
    );
  }
}

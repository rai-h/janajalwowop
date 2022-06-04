import 'package:flutter/material.dart';
import 'package:janajaldoot/controller/ui.controller.dart';
import 'package:provider/provider.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({Key? key}) : super(key: key);

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UiController>(builder: (context, notifier, _) {
      return BottomNavigationBar(
        selectedFontSize: 13,
        unselectedFontSize: 12,
        elevation: 20,
        iconSize: 28,
        currentIndex: notifier.navbarIndex,
        onTap: (int index) {
          setState(() {
            print(index);
            notifier.changeNavbarIndex(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        // selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        unselectedIconTheme: IconThemeData(color: Colors.lightBlue, size: 28),
        selectedIconTheme:
            const IconThemeData(size: 30, color: Colors.lightBlue),
        items: [
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue.shade100),
              child: const Icon(Icons.local_shipping_rounded),
            ),
            icon: const Icon(Icons.local_shipping_rounded),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
              activeIcon: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue.shade100),
                child: Image.asset(
                  'assets/images/icons/wow.png',
                  width: 29,
                ),
              ),
              icon: Image.asset(
                'assets/images/icons/wow.png',
                width: 27,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue.shade100),
              child: const Icon(Icons.currency_rupee),
            ),
            icon: const Icon(Icons.currency_rupee),
            label: 'Sales',
          ),
        ],
      );
    });
  }
}

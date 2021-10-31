import 'package:artstation/enums/enums.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Map<BottomNavItem, IconData> items;
  final BottomNavItem selectedItem;
  final Function(int) onTap;

  const BottomNavBar({
    Key key,
    @required this.items,
    @required this.selectedItem,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff1D1D1D),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.lightGreenAccent,
      unselectedItemColor: Colors.white,
      currentIndex: BottomNavItem.values.indexOf(selectedItem),
      onTap: onTap,
      items: items
          .map((item, icon) => MapEntry(
        item.toString(),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(icon, size: 40.0),
        ),
      ))
          .values
          .toList(),
    );
  }
}
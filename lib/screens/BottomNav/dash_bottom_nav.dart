import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

class DashBottomNav extends StatefulWidget {
  const DashBottomNav({super.key});

  @override
  State<DashBottomNav> createState() => _DashBottomNavState();
}

class _DashBottomNavState extends State<DashBottomNav> {
  @override
  Widget build(BuildContext context) {
    const List<TabItem> items = [
      TabItem(
        icon: Icons.home,
        title: 'Home',
      ),
      TabItem(
        icon: Icons.calendar_month_rounded,
        title: 'Bookings',
      ),
      TabItem(
        icon: Icons.menu,
        title: 'Others',
      ),
      TabItem(
        icon: Icons.chat,
        title: 'Chats',
      ),
      TabItem(
        icon: Icons.settings,
        title: 'Settings',
      ),
    ];
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return BottomBarInspiredInside(
          items: items,
          backgroundColor: Theme.of(context).colorScheme.background,
          color: Theme.of(context).colorScheme.secondary,
          colorSelected: Theme.of(context).colorScheme.primary,
          indexSelected: provider.bottomIndex,
          onTap: provider.setBottomIndex,
          chipStyle: ChipStyle(
              convexBridge: true,
              background:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1)),
          itemStyle: ItemStyle.circle,
          animated: false,
        );
      },
    );
  }
}

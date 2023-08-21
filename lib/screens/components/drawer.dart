import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/functions/functions.dart';
import 'package:my_global_tools/route_management/route_animation.dart';
import 'package:my_global_tools/route_management/route_name.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding:EdgeInsetsDirectional.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('John Doe'),
            accountEmail: Text('john.doe@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: Text(getLang.contact),
            onTap: () {
              // Handle navigation to the contact page
              context.pop(); // Close the drawer
              context.pushNamed(RouteName.contact);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: Text(getLang.gallery),
            onTap: () {
              // Handle navigation to the gallery page
              context.pop();
              context.pushNamed(RouteName.gallery, queryParameters: {
                'animation': RouteTransition.topRight.name
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(getLang.settings),
            onTap: () {
              // Handle navigation to the settings page
              context.pop(); // Close the drawer
              context.pushNamed(RouteName.appSetting);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(getLang.about),
            onTap: () {
              // Handle navigation to the about page
              context.pop(); // Close the drawer
              context.pushNamed(RouteName.about);
            },
          ),
          // Add some extra tiles
          ListTile(
            leading: const Icon(Icons.star),
            title: Text(getLang.extraTile1),
            onTap: () {
              // Handle navigation to the extra tile 1 page
              context.pop(); // Close the drawer
              // Replace '/extratile1' with the desired route name for extra tile 1
              // context.pushNamed(RouteName.extratile1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: Text(getLang.extraTile2),
            onTap: () {
              // Handle navigation to the extra tile 2 page
              context.pop(); // Close the drawer
              // Replace '/extratile2' with the desired route name for extra tile 2
              // context.pushNamed(RouteName.extratile2);
            },
          ),
        ],
      ),
    );
  }
}

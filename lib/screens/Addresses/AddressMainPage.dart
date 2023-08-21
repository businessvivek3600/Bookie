import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/route_management/route_animation.dart';
import 'package:my_global_tools/route_management/route_name.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';

import '../BottomNav/dash_setting_page.dart';

class AddressMainPage extends StatefulWidget {
  const AddressMainPage({super.key});

  @override
  _AddressMainPageState createState() => _AddressMainPageState();
}

class _AddressMainPageState extends State<AddressMainPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return buildAddressTile(index);
              },
              childCount: 50,
            ),
          ),
        ],
      ),
      // bottomNavigationBar: AnimatedContainer(
      //   duration: const Duration(milliseconds: 300),
      //   height: _isVisible ? kBottomNavigationBarHeight : 0.0,
      //   child: const BottomAppBar(
      //     color: Colors.blue,
      //     child: Center(
      //       child: Text('Bottom Widget',style: TextStyle(fontSize: 14)),
      //     ),
      //   ),
      // ),
    );
  }

  Widget buildAddressTile(int index) {
    return Container(
      margin: EdgeInsets.all(paddingDefault),
      padding: EdgeInsets.only(
          left: paddingDefault, right: paddingDefault, top: paddingDefault),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:
            index == 0 ? getTheme.colorScheme.primary.withOpacity(0.05) : null,
        border: Border.all(
          color: index == 0
              ? getTheme.colorScheme.primary.withOpacity(1)
              : getTheme.colorScheme.secondary.withOpacity(0.5),
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bodyLargeText('Chandan Kumar Singh', context),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  capText('Home', context, fontWeight: FontWeight.w600),
                  width10(),
                  if (index == 0)
                    Transform(
                        transform: Matrix4.identity()..scale(0.7),
                        child: Chip(
                          visualDensity: const VisualDensity(
                              horizontal: 0.0, vertical: -4),
                          backgroundColor:
                              getTheme.colorScheme.primary.withOpacity(0.1),
                          label: capText('Primary', context,
                              color: getTheme.colorScheme.primary),
                        )),
                ],
              ),
              capText('93 NORTH 9TH STREET, BROOKLYN NY 11211', context),
              capText('Brooklyn', context),
              capText('Bigtown BG23 4YZ', context),
              capText('Vincentown, NJ 08120', context),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: bodyMedText('Edit', context,
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.normal)),
                  TextButton(
                      onPressed: () {},
                      child: bodyMedText('Delete', context,
                          color: Theme.of(context).colorScheme.error,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ],
          ),
          if (index == 0)
            Positioned(
              right: 0,
              child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getTheme.colorScheme.primary),
                  child: const Icon(Icons.done, color: Colors.white, size: 15)),
            ),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: getWidth * 0.3,
      pinned: true,
      title: bodyLargeText('My Addresses', context),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingDefault * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bodyLargeText('Saved Addresses', context,
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.normal),
              ElevatedButton.icon(
                onPressed: () => context.pushNamed(RouteName.addNewAddress,
                    queryParameters: {'animation': RouteTransition.fade.name}),
                style: ElevatedButton.styleFrom(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                label: bodyMedText('Address', context),
                icon: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
      actions: const [ToggleBrightnessButton()],
      flexibleSpace: FlexibleSpaceBar(

        background: Stack(
          fit: StackFit.expand,
          children: [
            // Image.network(
            //   'https://img.freepik.com/premium-vector/city-cityscape-skyline-landscape-building-street-design-illustration_7081-385.jpg?w=360',
            //   fit: BoxFit.cover,
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //       colors: [
            //         Colors.transparent,
            //         Theme.of(context).colorScheme.background.withOpacity(0.5),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

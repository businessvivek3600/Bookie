import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/screens/BottomNav/dash_setting_page.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';

import '../../../route_management/route_name.dart';
import '../../../utils/picture_utils.dart';

class ServiceDetailsPage extends StatefulWidget {
  const ServiceDetailsPage(
      {super.key, required this.query, required this.shop});
  final String query;
  final String shop;

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  final searchController = TextEditingController();
  bool searchClosed = true;
  List<String> items = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Fig',
    'Grapes',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Pear',
    'Quince',
    'Raspberry',
    'Strawberry',
    'Watermelon',
  ];
  List<String> filteredItems = [];
  int tag = 1;
  @override
  void initState() {
    super.initState();
    searchController.text = widget.query;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleLargeText('Hair Cut Service', context),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Handle wishlist action
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Handle share action
            },
          ),
          const ToggleBrightnessButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.maxFinite,
              child: buildCachedNetworkImage(
                  'https://spa25.com/wp-content/uploads/2022/08/Men-Hair-Service-Category-Page.jpg',
                  fit: BoxFit
                      .cover), // Replace with actual banner image or color
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: bodyLargeText('Hair Cut Service', context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: capText('by HairStyle Studio', context),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const SizedBox(width: 4),
                  bodyMedText('4.8', context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: bodyMedText(
                'Available Shifts: 10:00 AM - 3:00 PM, 4:00 PM - 9:00 PM',
                context,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: bodyLargeText('Service Details', context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: capText(
                  'Get a stylish and trendy haircut at our HairStyle Studio. Our experienced hairdressers will give you the perfect look you desire.',
                  context),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: bodyLargeText('Reviews', context),
            ),
            // List of reviews
            _buildReviewItem(
                'John Doe', 'Great service! I loved my new haircut.', 5),
            _buildReviewItem('Jane Smith',
                'The hairdresser was very skilled. Highly recommended.', 4),
            // Add more review items
          ],
        ),
      ),
      floatingActionButton: FilledButton.tonalIcon(
        style: FilledButton.styleFrom(
            backgroundColor: getTheme.colorScheme.primary),
        onPressed: () {
          context.pushNamed(RouteName.slotBooking,
              queryParameters: {"service": widget.query, "shop": widget.shop});
        },
        label: bodyLargeText('Schedule', context, color: Colors.white),
        icon: const Icon(Icons.event, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildReviewItem(String username, String review, double rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person, color: Colors.grey),
              const SizedBox(width: 4),
              Text(username),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              const SizedBox(width: 4),
              Text('$rating/5.0'),
            ],
          ),
          const SizedBox(height: 4),
          Text(review),
        ],
      ),
    );
  }
}

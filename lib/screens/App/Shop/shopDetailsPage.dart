import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/text.dart';

import '../../../constants/asset_constants.dart';
import '../../../route_management/route_name.dart';
import '../../../utils/color.dart';
import '../../../utils/sized_utils.dart';

class ShopDetailPage extends StatelessWidget {
  const ShopDetailPage({super.key, required this.shop});
  final String shop;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleLargeText('Shop Detail', context),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // Handle bookmark action
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Handle share action
            },
          ),
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // Handle contact action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shop banner
            Container(
              height: 200,
              width: double.maxFinite,
              child: buildCachedNetworkImage(
                  'https://t4.ftcdn.net/jpg/03/78/83/15/360_F_378831540_10ShB9tnvs2quli24qe53ljhvsL07gjz.jpg',
                  fit: BoxFit
                      .cover), // Replace with actual banner image or color
            ),

            // Categories
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Add category widgets here

            // Popular services
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Popular Services',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  height20(),
                  Wrap(
                    children: [
                      ...List.generate(
                          5,
                          (index) => LayoutBuilder(builder: (context, bound) {
                                return GestureDetector(
                                  onTap: () => context.pushNamed(
                                      RouteName.service,
                                      queryParameters: {
                                        'service': 'Service $index',
                                        'shop': 'Shop Random'
                                      }),
                                  child: Column(
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: (getWidth -
                                                    40 -
                                                    paddingDefault * 2) /
                                                3,
                                            minWidth: (getWidth -
                                                    40 -
                                                    paddingDefault * 2) /
                                                3),
                                        margin: EdgeInsets.only(
                                            right: index % 2 == 0 && index != 0
                                                ? 0
                                                : 10,
                                            bottom: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            // borderRadius: BorderRadius.circular(10),
                                            color: generateRandomLightColor()
                                                .withOpacity(0.2)),
                                        child: assetImages(PNGAssets.appLogo),
                                      ),
                                      capText('Service $index', context),
                                      height10()
                                    ],
                                  ),
                                );
                              }))
                    ],
                  )
                ],
              ),
            ),
            // Add popular service tiles here

            // Description
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Description of the shop goes here...\nBarber Shop Signage Images – Browse 9,025 Stock Photos, Vectors, and Video | Adobe Stock Get this image on: Adobe Stock | Licence details Want to know where this information comes from? Learn more',
                style: TextStyle(fontSize: 16),
              ),
            ),

            // Location, address, contact info, ratings, bookings count
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Shop Location'),
              subtitle: Text('123 Shop Street, City, Country'),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('Contact'),
              subtitle: Text('Phone: +1 123-456-7890'),
            ),
            const ListTile(
              leading: Icon(Icons.star),
              title: Text('Ratings'),
              subtitle: Text('4.5 / 5.0 (500 Ratings)'),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Total Bookings'),
              subtitle: Text('1200 Bookings'),
            ),

            // Comments section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comments Section',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 200, child: _CommentList()),
                ],
              ),
            ),
            // Add comments section here
          ],
        ),
      ),
    );
  }
}

class Comment {
  final String username;
  final String avatarUrl;
  final String comment;
  final DateTime timestamp;

  Comment({
    required this.username,
    required this.avatarUrl,
    required this.comment,
    required this.timestamp,
  });
}

class _CommentList extends StatelessWidget {
  final List<Comment> comments = [
    Comment(
      username: 'User1',
      avatarUrl:
          'https://via.placeholder.com/50', // Replace with actual avatar URL
      comment: 'Great service! Highly recommended.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Comment(
      username: 'User2',
      avatarUrl:
          'https://via.placeholder.com/50', // Replace with actual avatar URL
      comment: 'Friendly staff and quick response.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
    // Add more comments
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(comments[index].avatarUrl),
            ),
            title: bodyMedText(comments[index].username, context),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                capText(comments[index].comment, context),
                capText(
                  _formatTimestamp(comments[index].timestamp),
                  context,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays >= 1) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

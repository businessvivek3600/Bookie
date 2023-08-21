import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  static const String routeName = '/gallery';

  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery Page')),
      body: Center(
        child: Text('This is the Gallery Page'),
      ),
    );
  }
}

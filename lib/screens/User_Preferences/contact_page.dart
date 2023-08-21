import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  static const String routeName = '/contact';

  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Page')),
      body: Center(
        child: Text('This is the Contact Page'),
      ),
    );
  }
}

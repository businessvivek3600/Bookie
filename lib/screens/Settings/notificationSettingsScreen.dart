import 'package:flutter/material.dart';
import 'package:my_global_tools/utils/text.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _emailNotification = true;
  bool _pushNotification = false;
  bool _smsNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleLargeText('Notification Settings', context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: bodyMedText('Email Notifications', context),
              trailing: Transform.scale(
                scale: 0.8,
                child: Switch.adaptive(
                  value: _emailNotification,
                  onChanged: (value) {
                    setState(() {
                      _emailNotification = value;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: bodyMedText('Push Notifications', context),
              trailing: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: _pushNotification,
                  onChanged: (value) {
                    setState(() {
                      _pushNotification = value;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: bodyMedText('SMS Notifications', context),
              trailing: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: _smsNotification,
                  onChanged: (value) {
                    setState(() {
                      _smsNotification = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

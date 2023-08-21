import 'package:flutter/material.dart';
import '/screens/BottomNav/dash_setting_page.dart';
import '/utils/sized_utils.dart';
import '/utils/text.dart';
import '../../widgets/circular_percent_indicator.dart';

class ProfileScreenPage extends StatefulWidget {
  const ProfileScreenPage({super.key});

  @override
  State<ProfileScreenPage> createState() => _ProfileScreenPageState();
}

class _ProfileScreenPageState extends State<ProfileScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleLargeText('My Profile', context),
        actions: const [ToggleBrightnessButton()],
      ),
      body: ListView(
        padding: EdgeInsets.all(paddingDefault),
        children: [
          buildUserCard(context),
          height20(spaceDefault),
          buildStatics(context),
          height20(spaceDefault),
          buildPersonalDetails(context),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: spaceDefault),
            title: bodyLargeText('Bookings', context),
            trailing: Container(
              constraints: const BoxConstraints(maxWidth: 100, minWidth: 70),
              width: 80,
              child: TextButton(
                  onPressed: () {},
                  child: capText('See All', context,
                      color: getTheme.colorScheme.primary)),
            ),
          ),
        ],
      ),
    );
  }

  Card buildStatics(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: Container(
        padding: EdgeInsets.all(paddingDefault),
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleLargeText('Statics', context,
                color: getTheme.colorScheme.primary),
            const Divider(),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      bodyLargeText('Total Services', context),
                      titleLargeText('320', context),
                    ],
                  ),
                  width20(),
                  ...List.generate(
                      7,
                      (index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CircularPercentIndicator(
                              radius: 30.0,
                              // lineWidth: 13.0,
                              animation: true,
                              percent: 0.7,
                              center: capText("70", context),
                              footer: capText("Medical", context),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.purple,
                            ),
                          ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Card buildPersonalDetails(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: Container(
        padding: EdgeInsets.all(paddingDefault),
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: paddingDefault),
              title: bodyLargeText('Email', context),
              subtitle: capText('codingmobile2023@gmail.com', context),
              trailing: Container(
                constraints: const BoxConstraints(maxWidth: 100, minWidth: 70),
                width: 70,
                child: TextButton(
                    onPressed: () {},
                    child: capText('Verify', context, color: Colors.red)),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     assetImages(PNGAssets.appLogo, width: 25),
                //     width5(),
                //     capText('Verified', context, color: Colors.green)
                //   ],
                // ),
              ),
            ),
            const MySeparator(),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: paddingDefault),
              title: bodyLargeText('Phone', context),
              subtitle: capText('+91 9135324545', context),
              trailing: Container(
                constraints: const BoxConstraints(maxWidth: 100, minWidth: 70),
                width: 70,
                child: TextButton(
                    onPressed: () {},
                    child: capText('Verify', context, color: Colors.red)),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     assetImages(PNGAssets.appLogo, width: 25),
                //     width5(),
                //     capText('Verified', context, color: Colors.green)
                //   ],
                // ),
              ),
            ),
            const MySeparator(),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: paddingDefault),
              title: bodyLargeText('Gender', context),
              subtitle: capText('Male', context),
              trailing: Container(
                constraints: const BoxConstraints(maxWidth: 100, minWidth: 70),
                width: 80,
                child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 15),
                    label: capText('Add', context,
                        color: getTheme.colorScheme.primary)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildUserCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      child: Container(
        padding: EdgeInsets.all(paddingDefault),
        decoration: const BoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                bodyLargeText('Chandan Kumar Singh', context),
                bodyMedText('codingmobile2023@gmail.com', context),
                bodyMedText('+91 9135324545', context),
                GestureDetector(
                    onTap: () {},
                    child: capText('Edit', context,
                        color: getTheme.colorScheme.primary,
                        decoration: TextDecoration.underline)),
              ],
            )),
            width10(),
            CircleAvatar(
              radius: getWidth * 0.1,
              backgroundImage: const NetworkImage(
                  'https://www.kindpng.com/picc/m/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png'),
            ),
          ],
        ),
      ),
    );
  }
}

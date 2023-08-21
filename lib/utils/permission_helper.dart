import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_global_tools/constants/app_const.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:permission_handler/permission_handler.dart';

enum ConfirmAction { cancel, accept }

class PermissionHelper {
  static Future<bool> requestPermissionSingle(
      BuildContext context, Permission permission, String title, String tips,
      {bool useDialog = true}) async {
    var status = await permission.status;
    var granted = status == PermissionStatus.granted;
    if (granted) return granted;
    if (useDialog) {
      // ignore: use_build_context_synchronously
      final action = await showDialog<ConfirmAction>(
          context: context,
          builder: (BuildContext context) {
            return buildPermissionDialog(context, title, tips);
          });
      if (action == ConfirmAction.accept) {
        granted = await requestSingle(permission);
      }
    } else {
      granted = await requestSingle(permission);
    }
    return granted;
  }

  static Widget buildPermissionDialog(
      BuildContext context, String title, String name) {
    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: titleLargeText(AppConst.appName, context,
                            textAlign: TextAlign.center, fontSize: 23,color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      bodyMedText('Allow permission', context,
                          textAlign: TextAlign.center),
                    ],
                  ),
                  height20(),
                  ...[
                    buildTile(
                        PermissionFor(
                            name: name,
                            desc: 'Take photo from camera',
                            image: PNGAssets.appLogo,
                            color: Colors.purpleAccent),
                        context)
                  ],
                  height30(),
                  FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop(ConfirmAction.accept);
                      },
                      child: const Text('Allow Permission')),
                ]),
          )
        ],
      ),
    );
    return CupertinoAlertDialog(
      title: Text('$name Not Available'),
      content: Text(
          'This function requires $name, please allow $title to access your $name？'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(ConfirmAction.cancel);
          },
        ),
        CupertinoDialogAction(
          child: const Text('Settings'),
          onPressed: () {
            Navigator.of(context).pop(ConfirmAction.accept);
          },
        ),
      ],
    );
  }

  static Future<bool> requestSingle(Permission request) async {
    PermissionStatus status = await request.request();
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return status == PermissionStatus.granted;
  }

  static Widget buildTile(PermissionFor permission, BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: permission.color,
            backgroundImage: assetImageProvider(permission.image,fit: BoxFit.contain),
          ),
          width10(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bodyLargeText('${permission.name} Access', context),
              capText(permission.desc, context),
            ],
          ))
        ],
      ),
    );
  }
}

class PermissionFor {
  final String name;
  final String desc;
  final String image;
  final Color color;
  PermissionFor({
    required this.name,
    required this.desc,
    required this.image,
    required this.color,
  });
}

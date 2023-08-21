import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/permission_helper.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/widget_animation_utils.dart';
import 'package:my_global_tools/widgets/FadeScaleTransitionWidget.dart';
import 'package:my_global_tools/widgets/fluid_dialog.dart';
import 'package:my_global_tools/utils/my_dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:permission_handler/permission_handler.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({Key? key}) : super(key: key);

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    final successAlert = buildButton(
      onTap: () => MyDialogs.showQuickSuccessDialog(context),
      title: 'Success',
      desc: 'Transaction Completed Successfully!',
      leadingImage: 'assets/gif/success.gif',
    );

    final errorAlert = buildButton(
      onTap: () => MyDialogs.showQuickErrorsDialog(context),
      title: 'Error',
      desc: 'Sorry, something went wrong',
      leadingImage: 'assets/gif/error.gif',
    );

    final warningAlert = buildButton(
      onTap: () => MyDialogs.showQuickWarningDialog(context),
      title: 'Warning',
      desc: 'You just broke protocol',
      leadingImage: 'assets/gif/warning.gif',
    );

    final infoAlert = buildButton(
      onTap: () => MyDialogs.showQuickInfoDialog(context,
          title: 'Info', desc: 'Buy two, get one free'),
      title: 'Info',
      desc: 'Buy two, get one free',
      leadingImage: 'assets/gif/info.gif',
    );

    final confirmAlert = buildButton(
      onTap: () => MyDialogs.showQuickConfirmDialog(context),
      title: 'Confirm',
      desc: 'Do you want to logout',
      leadingImage: 'assets/gif/confirm.gif',
    );

    final loadingAlert = buildButton(
      onTap: () => MyDialogs.showQuickLoadingDialog(context),
      title: 'Loading',
      desc: 'Fetching your data',
      leadingImage: 'assets/gif/loading.gif',
    );

    final customAlert = buildButton(
      onTap: () => MyDialogs.showQuickCustomDialog(context),
      title: 'Customs ',
      desc: 'Custom Widget Alert',
      leadingImage: 'assets/gif/Loading_icon.gif',
    );
    final panaraInfoDialog = buildButton(
      onTap: () => MyDialogs.showPanaraInfoDialog(context),
      title: 'show Panara Info Dialog ',
      desc: 'info Widget Alert',
      leadingImage: 'assets/gif/Loading_icon.gif',
    );
    final panaraSuccessDialog = buildButton(
      onTap: () => MyDialogs.showPanaraSuccessDialog(context,
          title: 'This is title.', desc: 'This is description.'),
      title: 'show Panara Success Dialog ',
      desc: 'info Widget Alert',
      leadingImage: 'assets/gif/Loading_icon.gif',
    );
    final panaraConfirmDialog = buildButton(
      onTap: () => MyDialogs.showPanaraConfirmDialog(context),
      title: 'show Panara Confirm Dialog ',
      desc: 'info Widget Alert',
      leadingImage: 'assets/gif/Loading_icon.gif',
    );
    final permissionDialog = buildButton(
      onTap: () => PermissionHelper.requestPermissionSingle(
          context, Permission.camera, 'Camera', 'Camera'),
      title: 'info ',
      desc: 'info Widget Alert',
      leadingImage: 'assets/gif/Loading_icon.gif',
    );
    final showCircleLoading = buildButton(
      onTap: () => MyDialogs.showCircleLoader(
          barrierDismissible: true,
          lottieFile: LottieAssets.fiveCircleLoader,
          bgColor: Colors.transparent,
          scaleFactor: 3),
      title: 'Circle Loading Dialog ',
      desc: 'For loading purpose',
      leadingImage: 'assets/gif/Loading_icon.gif',
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          "QuickAlert Demo",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: ListView(
        children: [
          height20(),
          successAlert,
          height20(),
          errorAlert,
          height20(),
          warningAlert,
          height20(),
          infoAlert,
          height20(),
          confirmAlert,
          height20(),
          loadingAlert,
          height20(),
          customAlert,
          height20(),
          const Divider(),
          bodyLargeText('Material Dialogs', context),
          height20(),
          SizedBox(height: 600, child: _TestPage()),
          const Divider(),
          bodyLargeText('Panara Dialog', context),
          height20(),
          panaraInfoDialog,
          height20(),
          panaraConfirmDialog,
          height20(),
          panaraSuccessDialog,
          height20(),
          FilledButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const FluidDialogTestPage())),
              child: titleLargeText('Fluid Dialog Page', context)),
          height20(),
          permissionDialog,
          height20(),
          Divider(),
          titleLargeText(
              'Loaders like: Circle, app logo and gif only', context),
          height20(),
          showCircleLoading,
          height20(),

        ],
      ),
    );
  }

  Widget buildButton({
    required onTap,
    required title,
    required desc,
    required leadingImage,
  }) {
    return MyCustomAnimatedWidget(
      animationsType: MyWidgetAnimationsType.fromTop,
      animationDuration: 1000,
      child: Card(
        shape: const StadiumBorder(),
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(backgroundImage: AssetImage(leadingImage)),
          title: bodyLargeText((title ?? "").toString().capitalize!, context),
          subtitle: bodyMedText((desc ?? "").toString().capitalize!, context),
          trailing: const Icon(Icons.keyboard_arrow_right_rounded),
        ),
      ),
    );
  }
}

class _TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestState();
  }
}

class TestState extends State<_TestPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          btn1(context),
          btn2(context),
          btn3(context),
          btn4(context),
        ],
      ),
    );
  }

  Widget btn1(BuildContext context) {
    return FilledButton(
      // color: Colors.grey[300],
      onPressed: () => Dialogs.materialDialog(
          msg: 'Are you sure ? you can\'t undo this',
          title: "Delete",
          context: context,
          dialogWidth: kIsWeb ? 0.3 : null,
          onClose: (value) => logD("returned value is '$value'"),
          actions: [
            IconsOutlineButton(
              onPressed: () {
                Get.back(result: ['Test', 'List']);
              },
              text: 'Cancel',
              iconData: Icons.cancel_outlined,
              textStyle: const TextStyle(color: Colors.grey),
              iconColor: Colors.grey,
            ),
            IconsButton(
              onPressed: () {
                Get.back();
              },
              text: "Delete",
              iconData: Icons.delete,
              color: Colors.red,
              textStyle: const TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]),
      child: const Text("Show Material Dialog"),
    );
  }

  Widget btn2(BuildContext context) {
    return FilledButton(
      // minWidth: 300,
      // color: Colors.grey[300],
      onPressed: () => Dialogs.bottomMaterialDialog(
          msg: 'Are you sure? you can\'t undo this action',
          title: 'Delete',
          context: context,
          actions: [
            MyCustomAnimatedWidget(
              animationsType: MyWidgetAnimationsType.fromRight,
              animationDuration: 800,
              child: IconsOutlineButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Cancel',
                iconData: Icons.cancel_outlined,
                textStyle: const TextStyle(color: Colors.grey),
                iconColor: Colors.grey,
              ),
            ),
            MyCustomAnimatedWidget(
              animationsType: MyWidgetAnimationsType.fromLeft,
              animationDuration: 800,
              child: IconsButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Delete',
                iconData: Icons.delete,
                color: Colors.red,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ),
          ]),
      child: const Text("Show Bottom Material Dialog"),
    );
  }

  Widget btn3(BuildContext context) {
    return FilledButton(
      // minWidth: 300,
      // color: Colors.grey[300],
      onPressed: () => Dialogs.materialDialog(
        msg: 'Congratulations, you won 500 points',
        title: 'Congratulations',
        lottieBuilder:
            assetLottie(LottieAssets.congratulation, fit: BoxFit.contain),
        dialogWidth: kIsWeb ? 0.3 : null,
        context: context,
        color: Colors.white,
        actions: [
          MyCustomAnimatedWidget(
            animationsType: MyWidgetAnimationsType.grow,
            animationDuration: 1000,
            offsetEnable: false,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Get.back();
              },
              label: titleLargeText('Claim', context, color: Colors.white),
              icon: const Icon(
                Icons.done,
                color: Colors.white,
              ),
              // color: Colors.blue,
              // textStyle: const TextStyle(color: Colors.white),
              // iconColor: Colors.white,
            ),
          ),
        ],
      ),
      child: const Text("Show animations Material Dialog"),
    );
  }

  Widget btn4(BuildContext context) {
    return FilledButton(
      // color: Colors.grey[300],
      // minWidth: 300,
      onPressed: () => Dialogs.bottomMaterialDialog(
        msg: 'Congratulations, you won 500 points',
        title: 'Congratulations',
        lottieBuilder:
            assetLottie(LottieAssets.congratulation, fit: BoxFit.contain),
        context: context,
        actions: [
          MyCustomAnimatedWidget(
            animationsType: MyWidgetAnimationsType.grow,
            animationDuration: 1000,
            offsetEnable: false,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                context.pop();
              },
              label: titleLargeText('Claim', context, color: Colors.white),
              icon: const Icon(
                Icons.done,
                color: Colors.white,
              ),
              // color: Colors.blue,
              // textStyle: const TextStyle(color: Colors.white),
              // iconColor: Colors.white,
            ),
          ),
        ],
      ),
      child: const Text("Show animations Bottom Dialog"),
    );
  }
}

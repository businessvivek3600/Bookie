import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget(
      {super.key, this.bgColor, this.textColor, this.callback, this.btnText});
  final Color? bgColor;
  final Color? textColor;
  final String? btnText;
  final void Function()? callback;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/90478-disconnect.zip',
                width: size.width * 0.7),
          ],
        ),
        titleLargeText('Oops!', context, fontSize: 32, color: textColor),
        bodyLargeText('No Internet Connection found', context,
            color: textColor),
        bodyLargeText('Check your connection', context, color: textColor),
        height10(),
        Padding(
          padding:EdgeInsetsDirectional.symmetric(horizontal: size.width * 0.3),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: callback ?? () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.all(8.0),
                      child: bodyLargeText(btnText ?? 'Go Back!', context,
                          textAlign: TextAlign.center),
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';

class CustomActivityList extends StatefulWidget {
  const CustomActivityList({super.key});

  @override
  State<CustomActivityList> createState() => _CustomActivityListState();
}

class _CustomActivityListState extends State<CustomActivityList> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Custom Activity')),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          ...List.generate(25, (index) {
            return _ActivityWidget(
              index: index,
              hasNext: index < 24,
            );
          }),
        ],
      ),
    );
  }
}

class _ActivityWidget extends StatelessWidget {
  _ActivityWidget(
      {super.key,
      required this.index,
      this.leadingWidget,
      this.leadingHeight = 20,
      this.titleWidget,
      this.subTitleWidget,
      this.trailingWidget,
      this.leadingShape,
      this.lineColor,
      this.lineLength = 5,
      this.lineGap = 5,
      this.hasNext = true});
  int index;
  Widget? leadingWidget;
  Widget? titleWidget;
  Widget? subTitleWidget;
  Widget? trailingWidget;
  BoxShape? leadingShape;
  Color? lineColor;
  double lineLength;
  double leadingHeight;
  double lineGap;

  /// check if next item is available to show the dot-lines
  final bool hasNext;
  @override
  Widget build(BuildContext context) {
    // final random = Random();
    double _leadingHeight = leadingHeight;
    Widget _leadingWidget = leadingWidget ??
        Container(
            width: leadingHeight,
            height: leadingHeight,
            decoration: BoxDecoration(
                shape: BoxShape.circle, border: Border.all(width: 1)));
    // Widget titleWidget = Text('Activity $index');
    // Widget subTitleWidget = Text('Sub-Activity $index');
    // Widget trailingWidget = const Icon(Icons.thumb_up);
    // BoxShape leadingShape =
    //     random.nextBool() ? BoxShape.circle : BoxShape.rectangle;
    // Color? lineColor = random.nextBool() ? Colors.blue : null;
    // double lineLength = random.nextDouble() * 10;
    //
    // // Randomly generate lineGap
    // double lineGap = random.nextDouble() * 10;
    //
    // final nextActivity = index < 25 - 1 ? const SizedBox() : null;

    return LayoutBuilder(builder: (context, bound) {
      infoLog(bound.toString(), bound.minHeight.toString());
      return Stack(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [_leadingWidget]),
                  width10(),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (titleWidget != null) titleWidget!,
                      if (subTitleWidget != null) subTitleWidget!,
                    ],
                  )),
                  if (trailingWidget != null) trailingWidget!,
                ],
              ),
              height30(),
            ],
          ),
          if (hasNext)
            Positioned(
              left: 0,
              top: _leadingHeight + 5,
              // bottom: 2,
              child: DottedLine(
                width: 20,
                // height: WidgetSizeHelper.getSize(context).height -
                //     (_leadingHeight + 5),
                height: 50,
                color: Colors.green,
                space: 5,
                strokeWidth: 3,
                strokeHeight: 10,
              ),
            ),
        ],
      );
    });
  }
}

class DottedLine extends StatelessWidget {
  Color color;
  double width;
  double height;
  double space;
  double strokeWidth;
  double strokeHeight;

  DottedLine({
    this.color = Colors.grey,
    this.width = 20.0,
    this.height = 20.0,
    this.space = 5.0,
    this.strokeWidth = 3.0,
    this.strokeHeight = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedLinePainter(
          color: color,
          width: width,
          height: height,
          strokeWidth: strokeWidth,
          strokeHeight: strokeHeight),
      size: Size(width, height),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  Color color;
  double width;
  double height;
  double space;
  double strokeWidth;
  double strokeHeight;
  _DottedLinePainter({
    required this.color,
    this.width = 20.0,
    this.height = 20.0,
    this.space = 5.0,
    this.strokeWidth = 3.0,
    this.strokeHeight = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startX = (size.width) / 2;
    double startY = 0;
    double endY = height;

    while (startY < size.height) {
      canvas.drawLine(
          Offset(startX, startY), Offset(startX, startY + strokeHeight), paint);
      startY += strokeHeight + space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ActivityItem {
  Widget? leading;
  Widget? title;
  Widget? subTitle;
  Widget? trailing;
  BoxShape? leadingShape;
  Color? lineColor;
  double lineLength;
  double lineGap;
  Size size;

  GlobalKey leadingKey;
  // GlobalKey trailingKey = GlobalKey();

  ActivityItem(
      {required this.leadingKey,
      this.leading,
      this.title,
      this.subTitle,
      this.trailing,
      this.leadingShape = BoxShape.circle,
      this.lineColor,
      this.lineLength = 5,
      this.lineGap = 5,
      required this.size});
}


class WidgetSizeHelper {
  static Size getSize(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    warningLog(renderBox.size.toString());
    return renderBox.size;
  }

  static Offset getOffset(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';

import '../BottomNav/dash_setting_page.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isIconMode = true;
  int primaryAccount = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isIconMode = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isIconMode = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: bodyLargeText('Bank Accounts', context,
                      fontWeight: FontWeight.bold),
                ),
                ...List.generate(4, (index) => buildAccountsTile(index * 100))
              ],
            ),
          ),
          SliverToBoxAdapter(child: height20()),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: bodyLargeText('UPI', context,
                      fontWeight: FontWeight.bold),
                ),
                ...List.generate(5, (index) => buildUpiTile(index * 100))
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: buildAddAccountButton(),
    );
  }

  Widget buildUpiTile(int index) {
    return buildSlidableTile(
      index,
      child: Container(
        margin: EdgeInsets.all(paddingDefault),
        padding: EdgeInsets.all(paddingDefault),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index == 0
              ? getTheme.colorScheme.primary.withOpacity(0.05)
              : null,
          border: Border.all(
            color: index == 0
                ? getTheme.colorScheme.primary.withOpacity(1)
                : getTheme.colorScheme.secondary.withOpacity(0.5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio<int>(
                value: index, groupValue: primaryAccount, onChanged: (val) {}),
            Expanded(
              child: bodyLargeText('chandan.s3@paytm', context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccountsTile(int index) {
    return buildSlidableTile(
      index,
      child: Container(
        margin: EdgeInsets.all(paddingDefault),
        padding: EdgeInsets.all(paddingDefault),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index == 0
              ? getTheme.colorScheme.primary.withOpacity(0.05)
              : null,
          border: Border.all(
            color: index == 0
                ? getTheme.colorScheme.primary.withOpacity(1)
                : getTheme.colorScheme.secondary.withOpacity(0.5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<int>(
                value: index, groupValue: primaryAccount, onChanged: (val) {}),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bodyLargeText('Bank Of India', context),
                        capText(
                            '93 NORTH 9TH STREET, BROOKLYN NY 11211', context),
                      ],
                    ),
                  ),
                  width10(),
                  SizedBox(
                    height: getWidth * 0.1,
                    width: getWidth * 0.1,
                    child: buildCachedNetworkImage(
                        'https://w7.pngwing.com/pngs/728/384/png-transparent-vadodara-bank-of-baroda-central-bank-of-india-online-banking-bank-angle-text-logo.png',
                        borderRadius: 5),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Slidable buildSlidableTile(int index, {required Widget child}) {
    return Slidable(
        key: ValueKey(index.toString()),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dragDismissible: false,
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            // SlidableAction(
            //   onPressed: (ctx) {},
            //   backgroundColor: Colors.transparent,
            //   foregroundColor: Colors.red,
            //   icon: Icons.delete,
            //   label: 'Delete',
            // ),
            SlidableAction(
              // An action can be bigger than the others.
              // flex: 2,
              onPressed: (ctx) {},
              backgroundColor: Colors.transparent,
              foregroundColor: const Color(0xFF7BC043),
              // icon: Icons.archive,
              label: 'Primary',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          openThreshold: 0.3,
          children: [
            SlidableAction(
                // An action can be bigger than the others.
                // flex: 2,
                onPressed: (ctx) {},
                backgroundColor: Colors.transparent,
                foregroundColor: getTheme.colorScheme.primary,
                icon: Icons.mode
                // label: 'Edit',
                ),
            SlidableAction(
              onPressed: (ctx) {},
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.red,
              icon: Icons.delete,
              // label: 'Delete',
            ),
          ],
        ),
        child: child);
  }

  AnimatedContainer buildAddAccountButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // width: !_isIconMode ? 60.0 : 100.0,
      child: !_isIconMode
          ? FloatingActionButton(
              key: const Key('icon'),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(Icons.add),
            )
          : FloatingActionButton.extended(
              key: const Key('label'),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              label: const Text('New', style: TextStyle(fontSize: 14)),
              icon: const Icon(Icons.add, size: 20),
            ),
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: titleLargeText('Accounts', context),
      actions: const [ToggleBrightnessButton()],
    );
  }
}

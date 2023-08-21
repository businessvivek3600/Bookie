import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/screens/BottomNav/dash_setting_page.dart';
import 'package:my_global_tools/utils/date_utils.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import '/utils/default_logger.dart';
import '/utils/sized_utils.dart';
import '/utils/text.dart';

import '../../../widgets/appbar_calender.dart';

class SlotBookingPage extends StatefulWidget {
  const SlotBookingPage({super.key, required this.service, required this.shop});
  final String service;
  final String shop;

  @override
  State<SlotBookingPage> createState() => _SlotBookingPageState();
}

class _SlotBookingPageState extends State<SlotBookingPage> {
  DateTime? selectedDate;
  Random random = Random();
  int selectedSlot = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedDate = DateTime.now();
    });
  }

  List<String> availableSlots = [
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 AM',
    '12:00 AM - 1:00 PM',
    '1:00 PM - 2:00 PM',
    '2:00 PM - 3:00 PM',
    '3:00 PM - 4:00 PM',
    '4:00 PM - 5:00 PM',
    '5:00 PM - 6:00 PM',
    '6:00 PM - 7:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        accent: getTheme.colorScheme.primary,
        backButton: true,
        fullCalendar: false,
        selectedDate: DateTime.now(),
        onDateChanged: (value) {
          setState(() {
            selectedDate = value;
          });
          Fluttertoast.showToast(
              msg:
                  'Selected date: ${MyDateUtils.formatDateTime(selectedDate!, 'dd MMM yyyy')}');
        },
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 30)),
        events: List.generate(
            5,
            (index) =>
                DateTime.now().add(Duration(days: index * random.nextInt(5)))),
      ),
      floatingActionButton: const ToggleBrightnessButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: paddingDefault),
        children: [
          // titleLargeText(widget.service, context),
          // bodyLargeText(widget.shop, context),
          // height10(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bodyLargeText('Select a Time Slot on ', context),
              bodyLargeText(
                  MyDateUtils.formatDate(selectedDate!, 'dd MMM yyyy'), context,
                  color: getTheme.colorScheme.primary),
            ],
          ),
          height10(),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              ...List.generate(
                  7,
                  (index) => _SlotItem(
                        time: availableSlots[index],
                        duration: 30,
                        isSelected: selectedSlot == index,
                        onTap: () {
                          setState(() {
                            selectedSlot = index;
                          });
                        },
                      ))
            ],
          ),
          heightDefault(),
          _StaffsList(),
          FilledButton(
            onPressed: () {
              // Handle booking button click
              logD('Selected slot: $selectedSlot');
              logD('Please select a slot.');
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                builder: (BuildContext context) {
                  return ServiceDetailsScreen(
                    staff: _Staff(
                      name: 'John Doe',
                      qualification: 'Masters in Computer Science',
                      rating: 4.5,
                      reviews: 128,
                    ),
                  );
                },
              );
            },
            child: const Text('Book Any'),
          ),
          const SizedBox(height: 16),
          height100(),
        ],
      ),
    );
  }
}

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key, required this.staff});
  final _Staff staff;

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  String selectedPaymentMode = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spaceDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // padding: EdgeInsets.all(spaceDefault),
                children: [
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: assetImages(PNGAssets.appLogo,
                              width: getWidth * 0.2)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleLargeText('Haircut Service', context),
                          bodyMedText('At HairStyle Studio', context,
                              color: Colors.grey),
                          SizedBox(height: 10),
                          bodyMedText('Slot: 10:AM - 11:00AM', context),
                          capText('On 13 Aug 2023', context,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                    ],
                  ),
                  _StaffCard(employee: widget.staff, booking: false),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Coupon',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Enter coupon code',
                              ),
                            ),
                          ),
                          width10(),
                          FilledButton(
                            onPressed: () {
                              // Apply coupon logic
                            },
                            child: const Text('Apply'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Price Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      PriceDetailRow(
                        label: 'Service Total',
                        amount: '\$30.00',
                      ),
                      PriceDetailRow(
                        label: 'Discount Coupon',
                        amount: '-\$5.00',
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      PriceDetailRow(
                        label: 'Total',
                        amount: '\$25.00',
                        isTotal: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            // Payment logic
                          },
                          child: const Text('Pay \$25.00'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PriceDetailRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isTotal;

  PriceDetailRow({
    required this.label,
    required this.amount,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _SlotItem extends StatelessWidget {
  final String time;
  final int duration;
  final bool isSelected;
  final VoidCallback onTap;

  _SlotItem({
    required this.time,
    required this.isSelected,
    required this.onTap,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isSelected
                ? getTheme.colorScheme.primary.withOpacity(0.2)
                : null,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: isSelected
                    ? getTheme.colorScheme.primary.withOpacity(0.2)
                    : getTheme.colorScheme.secondary.withOpacity(0.2))),
        child: Column(
          children: [
            capText(time, context, fontSize: 8),
            height5(),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.access_time_rounded, size: 10),
                width5(),
                capText('$duration min', context, fontSize: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StaffsList extends StatelessWidget {
  final List<_Staff> staffs = [
    _Staff(
      name: 'John Doe',
      qualification: 'Masters in Computer Science',
      rating: 4.5,
      reviews: 128,
    ),
    _Staff(
      name: 'Jane Smith',
      qualification: 'Bachelors in Engineering',
      rating: 4.2,
      reviews: 95,
    ),
    // Add more employees
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...staffs.map((e) {
          int index = staffs.indexOf(e);
          return _StaffCard(employee: staffs[index]);
        })
      ],
    );
  }
}

class _Staff {
  final String name;
  final String qualification;
  final double rating;
  final int reviews;

  _Staff({
    required this.name,
    required this.qualification,
    required this.rating,
    required this.reviews,
  });
}

class _StaffCard extends StatelessWidget {
  final _Staff employee;
  final bool booking;
  _StaffCard({required this.employee, this.booking = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(paddingDefault),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              border: booking
                  ? Border.all(color: getTheme.colorScheme.primary)
                  : null,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: getTheme.colorScheme.primary,
                child: Text(
                  employee.name.substring(0, 1),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              widthDefault(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bodyMedText(employee.name, context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      capText(employee.qualification, context),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.yellow, size: 15),
                          const SizedBox(width: 4),
                          capText(
                              '${employee.rating} (${employee.reviews} reviews)',
                              context),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
        if (booking)
          Positioned(
              bottom: 5,
              right: -10,
              child: Transform.scale(
                scale: 0.5,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Book'),
                ),
              ))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_global_tools/route_management/route_name.dart';
import 'package:my_global_tools/screens/BottomNav/dash_setting_page.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';

import '../../functions/functions.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // elevation: 0,
          title: titleLargeText('Bookings', context),
          actions: const [ToggleBrightnessButton()],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30.0),
              child: TabBar(
                  // isScrollable: true,
                  // labelColor: Colors.white,
                  // unselectedLabelColor: Colors.white70,
                  labelStyle:
                      getTheme.textTheme.bodyLarge?.copyWith(fontSize: 15),
                  indicatorColor: getTheme.colorScheme.primary,
                  onTap: (index) {},
                  tabs: const [
                    Tab(child: Text('Schedules')),
                    Tab(child: Text('Completed')),
                    Tab(child: Text('Missed')),
                    // Tab(
                    //     child: Text(
                    //   'Position',
                    //   style: GoogleFonts.ubuntu(),
                    // )),
                  ])),
        ),
        body: AppointmentPage(),
      ),
    );
  }
}

class Appointment {
  final String name;
  final String service;
  final String shop;
  final DateTime dateTime;

  Appointment({
    required this.name,
    required this.service,
    required this.shop,
    required this.dateTime,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppointmentPage(),
    );
  }
}

class AppointmentPage extends StatelessWidget {
  final List<Appointment> appointments = [
    Appointment(
      name: 'John Doe',
      service: 'Haircut',
      shop: 'HairStyle Studio',
      dateTime: DateTime.now().add(const Duration(days: 1)),
    ),
    Appointment(
      name: 'Jane Smith',
      service: 'Manicure',
      shop: 'NailArt Salon',
      dateTime: DateTime.now().add(const Duration(days: 3)),
    ),
    // Add more appointments
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spaceDefault),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return AppointmentCard(appointment: appointments[index]);
      },
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => context.pushNamed(RouteName.bookingDetail),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(paddingDefault),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // border: Border.all()
                color: getTheme.colorScheme.onPrimary,
                boxShadow: [
                  BoxShadow(
                    color: getTheme.colorScheme.secondary.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 9,
                    offset: const Offset(
                        5, 6), // Offset for right and bottom shadow
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      // backgroundColor: Colors.blue,
                      // radius: 30,
                      child: Text(
                        appointment.name.substring(0, 1),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bodyLargeText(appointment.service, context),
                        capText('At ${appointment.shop}', context,
                            color: Colors.grey),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        capText('Today', context, fontWeight: FontWeight.w500),
                        capText('11:45 AM', context),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton.filled(
                          onPressed: () {
                            // Call logic
                          },
                          style: IconButton.styleFrom(
                            backgroundColor:
                                getTheme.colorScheme.primary.withOpacity(0.1),
                          ),
                          color: getTheme.colorScheme.primary,
                          icon: const Icon(Icons.call),
                        ),
                        IconButton.filled(
                          style: IconButton.styleFrom(
                            backgroundColor:
                                getTheme.colorScheme.primary.withOpacity(0.1),
                          ),
                          onPressed: () {
                            // Chat logic
                          },
                          color: getTheme.colorScheme.primary,
                          icon: const Icon(Icons.chat),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: paddingDefault,
          right: paddingDefault,
          child: IconButton.filled(
            onPressed: () => openGoogleMapsDirections(30.7008, 76.7127),
            icon: const Icon(Icons.directions, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

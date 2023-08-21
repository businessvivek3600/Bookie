import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../functions/functions.dart';
import '/screens/BottomNav/dash_setting_page.dart';
import '/utils/sized_utils.dart';
import '/utils/text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../App/Booking/slot_booking.dart';

class BookingDetailPage extends StatelessWidget {
  final _BookingDetail booking = _BookingDetail(
    id: '123456',
    service: 'Haircut',
    shop: 'HairStyle Studio',
    slot: '10:00 AM - 11:00 AM',
    shopLocation:
        'Robert Robertson, 1234 NW Bobcat Lane, St. Robert, MO 65584-5678',
    hasCoupon: true,
    paymentDetails: '\$25.00 paid',
  );

  BookingDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleLargeText('Booking Details', context, maxLines: 1),
        // backgroundColor: getTheme.colorScheme.primary,
        actions: [
          const ToggleBrightnessButton(),
          IconButton.filled(
            onPressed: () {
              // Call logic
            },
            style: IconButton.styleFrom(
              backgroundColor: getTheme.colorScheme.primary.withOpacity(0.1),
            ),
            color: getTheme.colorScheme.primary,
            icon: const Icon(Icons.call),
          ),
          IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: getTheme.colorScheme.primary.withOpacity(0.1),
            ),
            onPressed: () {
              // Chat logic
            },
            color: getTheme.colorScheme.primary,
            icon: const Icon(Icons.chat),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConfirmationCard(context),
            _buildBookingInfo(context),
            const Divider(),
            _buildPaymentInfo(context),
            const Divider(),
            _buildShopLocation(context),
            height50(),
          ],
        ),
      ),
    );
  }

  Container _buildPaymentInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(spaceDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyLargeText('Payment Details', context,
              color: getTheme.colorScheme.primary),
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
          PriceDetailRow(
            label: 'Total',
            amount: '\$25.00',
            isTotal: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.download,
                        color: CupertinoColors.link, size: 15),
                    capText('Download Invoice', context,
                        color: CupertinoColors.link)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildConfirmationCard(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spaceDefault),
          margin: EdgeInsets.all(spaceDefault),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.greenAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              titleLargeText('Booking Confirmed', context,
                  fontSize: 22, color: Colors.green),
              const SizedBox(height: 10),
              bodyMedText(
                  'Congratulations! Your booking is confirmed.', context),
              height10(),
              bodyLargeText('Booking ID: #${booking.id}', context),
              bodyLargeText('Booked On: Today', context),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: spaceDefault, vertical: paddingDefault),
          decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: capText(
                      'This booking can be re-scheduled till 13-08-2023 03:45PM',
                      context)),
              width5(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 30,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                          fixedSize: const Size(70, 0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5)),
                      child: capText('ReSchedule', context,
                          maxLines: 1, color: Colors.white),
                    ),
                  ),
                  width5(),
                  SizedBox(
                    height: 30,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: const Size(50, 30),
                          padding: const EdgeInsets.all(5)),
                      child: capText('Cancel', context, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBookingInfo(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(paddingDefault),
      margin: EdgeInsets.all(paddingDefault),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyLargeText('Booking Details', context,
              color: getTheme.colorScheme.primary),
          height10(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bodyMedText('Service: ', context),
              bodyMedText(' ${booking.service}', context),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bodyMedText('Shop: ', context),
              bodyMedText(' ${booking.shop}', context),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bodyMedText('Slot: ', context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  bodyMedText('Today', context),
                  bodyMedText(' ${booking.slot}', context),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShopLocation(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingDefault),
      margin: EdgeInsets.all(paddingDefault),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleLargeText('Location', context,
              color: getTheme.colorScheme.primary),
          height10(),
          SizedBox(
              height: 200,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const _BookingMapLocationWidget(isSample: true))),
          height10(),
          capText(booking.shopLocation, context),
        ],
      ),
    );
  }

  Widget _buildCouponDetails() {
    if (!booking.hasCoupon) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Coupon Details', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Coupon Applied', style: TextStyle(color: Colors.green)),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Payment Details', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Text(booking.paymentDetails, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            // Handle cancel booking
          },
          child: const Text('Cancel Booking'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle edit booking
          },
          child: const Text('Edit Booking'),
        ),
      ],
    );
  }
}

class _BookingMapLocationWidget extends StatefulWidget {
  const _BookingMapLocationWidget({super.key, required this.isSample});
  final bool isSample;

  @override
  State<_BookingMapLocationWidget> createState() =>
      _BookingMapLocationWidgetState();
}

class _BookingMapLocationWidgetState extends State<_BookingMapLocationWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final LatLng _kMapCenter = const LatLng(30.7058, 76.6857);
  BitmapDescriptor? _markerIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition:
                CameraPosition(target: _kMapCenter, zoom: 15.0),
            markers: <Marker>{_createMarker()},
            scrollGesturesEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton.filled(
              onPressed: () => openGoogleMapsDirections(
                  _kMapCenter.latitude, _kMapCenter.longitude),
              icon: const Icon(Icons.directions, color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: widget.isSample
          ? null
          : FloatingActionButton.extended(
              onPressed: _goToTheLake,
              label: const Text('To the lake!'),
              icon: const Icon(Icons.directions_boat),
            ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: _kMapCenter,
        icon: _markerIcon!,
      );
    } else {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: _kMapCenter,
      );
    }
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size.square(48));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/red_square.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }
}

class _BookingDetail {
  final String id;
  final String service;
  final String shop;
  final String slot;
  final String shopLocation;
  final bool hasCoupon;
  final String paymentDetails;

  _BookingDetail({
    required this.id,
    required this.service,
    required this.shop,
    required this.slot,
    required this.shopLocation,
    this.hasCoupon = false,
    required this.paymentDetails,
  });
}

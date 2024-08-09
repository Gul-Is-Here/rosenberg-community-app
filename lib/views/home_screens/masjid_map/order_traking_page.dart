import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng destination = LatLng(29.506660, -95.762451);

  List<LatLng> polylineCoordinates = [];
  final Set<Polyline> _polylines = {};
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData _locationData = await location.getLocation();
    setState(() {
      currentLocation =
          LatLng(_locationData.latitude!, _locationData.longitude!);
    });
    _setPolyline();
  }

  Future<void> _setPolyline() async {
    if (currentLocation == null) return;

    // Simulate getting polyline points
    polylineCoordinates = [
      currentLocation!,
      const LatLng(29.506660, -95.762451),
      const LatLng(29.506660, -95.762451),
      const LatLng(29.506660, -95.762451),
      destination,
    ];

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 5,
        ),
      );
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            currentLocation!.latitude < destination.latitude
                ? currentLocation!.latitude
                : destination.latitude,
            currentLocation!.longitude < destination.longitude
                ? currentLocation!.longitude
                : destination.longitude,
          ),
          northeast: LatLng(
            currentLocation!.latitude > destination.latitude
                ? currentLocation!.latitude
                : destination.latitude,
            currentLocation!.longitude > destination.longitude
                ? currentLocation!.longitude
                : destination.longitude,
          ),
        ),
        50.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Way to Masjid",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation!,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('sourceLocation'),
                  position: currentLocation!,
                ),
                const Marker(
                  markerId: MarkerId('destination'),
                  position: destination,
                ),
              },
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}

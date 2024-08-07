import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation =
      LatLng(37.42796133580664, -122.085749655962);
  static const LatLng destination =
      LatLng(37.33466532813946, -122.00920104977547);

  List<LatLng> polylineCoordinates = [];
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _setPolyline();
  }

  Future<void> _setPolyline() async {
    // Simulate getting polyline points
    polylineCoordinates = [
      sourceLocation,
      const LatLng(37.42496133580664, -122.081749655962),
      const LatLng(37.41996133580664, -122.076749655962),
      const LatLng(37.41496133580664, -122.071749655962),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track order",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: sourceLocation,
          zoom: 14,
        ),
        markers: {
          const Marker(
            markerId: MarkerId('sourceLocation'),
            position: sourceLocation,
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

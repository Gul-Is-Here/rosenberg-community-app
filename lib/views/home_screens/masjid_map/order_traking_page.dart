import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(39.792690, -78.806200);
  static const LatLng destination = LatLng(29.506660, -95.762451);

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
      const LatLng(39.692690, -78.706200),
      const LatLng(39.592690, -78.606200),
      const LatLng(39.492690, -78.506200),
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

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController mapController;
  bool _isMapLoaded = false;

  final LatLng _center = const LatLng(51.5, -0.09);
  final List<Marker> _markers = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _isMapLoaded = true;
    });
  }

  void _onTap(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: InfoWindow(
            title: 'New Marker',
            snippet: 'Marker at ${position.latitude}, ${position.longitude}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
        ),
      );
    });
  }

  void _moveCamera() {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(40.7128, -74.0060), // New York City
          zoom: 14.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mapa',
          style: TextStyle(
            fontFamily: 'Averta',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF8CBE2A), // Color primario
        actions: [
          IconButton(
            icon: Icon(Icons.location_city),
            onPressed: _moveCamera,
            color: const Color(0xFFE97E03), // Color complementario
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
            markers: Set<Marker>.of(_markers),
            onTap: _onTap,
          ),
          if (!_isMapLoaded)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/ride_request_dialog.dart';

// Mapbox
const String MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoicmFqZW5kcmE5OTUwIiwiYSI6ImNtajhsajg0MDAxYnYzcHF0c3Z1bjM0OGIifQ.VQCWQADfuUyVO_6Qch8jUQ';
const String MAPBOX_STYLE = 'mapbox/streets-v11';

// NOTE: For geolocation to work properly add the following permissions:
// Android (android/app/src/main/AndroidManifest.xml):
//   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
// iOS (ios/Runner/Info.plist):
//   <key>NSLocationWhenInUseUsageDescription</key>
//   <string>We need your location to show nearby rides and your position on the map</string>

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool online = false;
  bool verificationPending = false; // adjust this depending on user
  bool _showRideRequest = false;
  String _locationStatus = 'Getting location...';

  LatLng _center = LatLng(17.3850, 78.4867); // default Hyderabad
  LatLng? _currentPosition;
  double _accuracy = 0.0;
  StreamSubscription<Position>? _positionStream;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
        setState(() => _locationStatus = 'Location permission denied');
        return;
      }

      final Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _currentPosition = LatLng(pos.latitude, pos.longitude);
        _center = _currentPosition!;
        _accuracy = pos.accuracy;
        _locationStatus = '${pos.latitude.toStringAsFixed(4)}, ${pos.longitude.toStringAsFixed(4)}';
      });

      _positionStream = Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 10)).listen((p) {
        setState(() {
          _currentPosition = LatLng(p.latitude, p.longitude);
          _center = _currentPosition!;
          _accuracy = p.accuracy;
          _locationStatus = '${p.latitude.toStringAsFixed(4)}, ${p.longitude.toStringAsFixed(4)}';
        });
      });
    } catch (e) {
      setState(() => _locationStatus = 'Error: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  void _toggleOnline(bool v) {
    setState(() => online = v);
    if (v) {
      Future.delayed(const Duration(milliseconds: 500), () { setState(() => _showRideRequest = true); });
    }
  }

  void _acceptRide() {
    setState(() => _showRideRequest = false);
    Navigator.pushNamed(context, '/trip_details');
  }

  void _rejectRide() { setState(() => _showRideRequest = false); }

  Future<void> _openGoogleMapsAtCurrent() async {
    if (_currentPosition == null) return;
    final lat = _currentPosition!.latitude;
    final lng = _currentPosition!.longitude;
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // subtle top gradient background to match screenshots
        Container(decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFF7F9FE), Colors.white], stops: [0, 0.4]))),

        // Map
        Positioned.fill(child: FlutterMap(
          options: MapOptions(center: _center, zoom: 14),
          children: [
            TileLayer(
              urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
              additionalOptions: {'accessToken': MAPBOX_ACCESS_TOKEN, 'id': MAPBOX_STYLE},
            ),
            if (_currentPosition != null)
              MarkerLayer(markers: [
                Marker(point: _currentPosition!, width: 48, height: 48, builder: (_) => const Icon(Icons.location_pin, color: Colors.blue, size: 44)),
              ]),
            if (_currentPosition != null)
              CircleLayer(circles: [CircleMarker(point: _currentPosition!, color: Colors.blue.withOpacity(0.08), borderStrokeWidth: 0, useRadiusInMeter: true, radius: _accuracy)]),
          ],
        )),

        // Top center logo
        SafeArea(child: Align(alignment: Alignment.topCenter, child: Padding(padding: const EdgeInsets.only(top: 10), child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('NEXO' + 'RYD', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(6)),
            child: Text(_locationStatus, style: const TextStyle(fontSize: 11, color: Colors.black54))
          )
        ])))),

        // Open Google Maps bubble
        Positioned(top: MediaQuery.of(context).size.height * 0.28, right: 18, child: GestureDetector(onTap: _openGoogleMapsAtCurrent, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]), child: Row(children: const [Icon(Icons.map, color: Colors.blue), SizedBox(width: 8), Text('Open Google Maps')])))),

        // Bottom sheet
        Align(alignment: Alignment.bottomCenter, child: DraggableScrollableSheet(
          initialChildSize: 0.25,
          minChildSize: 0.25,
          maxChildSize: 0.4,
          builder: (context, ctrl) => Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: ListView(controller: ctrl, children: [
              // Handle bar
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 12),

              // Stats Row
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(children: const [
                  Text('Today', style: TextStyle(color: Colors.black54, fontSize: 12)),
                  SizedBox(height: 4),
                  Text('₹450', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ]),
                Column(children: const [
                  Text('Rides', style: TextStyle(color: Colors.black54, fontSize: 12)),
                  SizedBox(height: 4),
                  Text('5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ]),
                Column(children: const [
                  Text('Hours', style: TextStyle(color: Colors.black54, fontSize: 12)),
                  SizedBox(height: 4),
                  Text('3.5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ]),
              ]),

              const SizedBox(height: 20),

              // Online/Offline Status Card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      verificationPending ? 'You are Offline' : (online ? 'You are Online' : 'You are Offline'),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    if (verificationPending) 
                      const Text('Your documents are under review. This usually\ntakes 1-2 days.', style: TextStyle(color: Colors.black54, fontSize: 12))
                    else
                      Text(
                        online ? 'Ready to accept rides' : 'Your documents are under review. This usually\ntakes 1-2 days.',
                        style: const TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                  ]),
                  Switch(value: !verificationPending && online, onChanged: verificationPending ? null : (v) => _toggleOnline(v)),
                ]),
              ),

              const SizedBox(height: 20),
            ]),
          ),
        )),

        // Ride request overlay
        if (_showRideRequest) Positioned.fill(child: RideRequestDialog(onAccept: _acceptRide, onReject: _rejectRide)),

      ]),
    );
  }
}
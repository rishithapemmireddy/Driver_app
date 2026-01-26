import 'dart:async';

import 'package:flutter/material.dart';

class RideRequestDialog extends StatefulWidget {
  final void Function() onAccept;
  final void Function() onReject;

  const RideRequestDialog({Key? key, required this.onAccept, required this.onReject}) : super(key: key);

  @override
  State<RideRequestDialog> createState() => _RideRequestDialogState();
}

class _RideRequestDialogState extends State<RideRequestDialog> {
  int secondsLeft = 25;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (secondsLeft > 0) secondsLeft--; else _timer?.cancel();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('New Ride Request', style: TextStyle(fontWeight: FontWeight.bold)), Text('${secondsLeft}s', style: const TextStyle(color: Colors.orange))]),
            const SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Column(children: const [Text('Distance', style: TextStyle(color: Colors.black54)), SizedBox(height: 6), Text('6.2 km', style: TextStyle(fontWeight: FontWeight.bold))]),
              Column(children: const [Text('Time', style: TextStyle(color: Colors.black54)), SizedBox(height: 6), Text('18min', style: TextStyle(fontWeight: FontWeight.bold))]),
              Column(children: const [Text('Fare', style: TextStyle(color: Colors.black54)), SizedBox(height: 6), Text('₹45', style: TextStyle(fontWeight: FontWeight.bold))]),
            ]),
            const SizedBox(height: 12),
            const Divider(),
            Align(alignment: Alignment.centerLeft, child: const Text('Trip Details', style: TextStyle(fontWeight: FontWeight.bold))),
            const SizedBox(height: 8),
            Column(children: const [
              ListTile(leading: Icon(Icons.circle, color: Colors.green, size: 12), title: Text('Block 2, Main Road, Ramraju Nagar, Hyderabad, Telengana'), contentPadding: EdgeInsets.symmetric(horizontal: 0)),
              ListTile(leading: Icon(Icons.location_on, color: Colors.red, size: 18), title: Text('Door No - 47/333/A, Block 7, Kukatpally, Main Junction, Hyderabad'), contentPadding: EdgeInsets.symmetric(horizontal: 0)),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: OutlinedButton(
                onPressed: widget.onReject,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                ),
                child: const Text('Reject', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
              )),
              const SizedBox(width: 12),
              Expanded(child: ElevatedButton(
                onPressed: widget.onAccept,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D5ED7),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                ),
                child: const Text('Accept', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white))
              )),
            ])
          ]),
        ),
      ),
    );
  }
}

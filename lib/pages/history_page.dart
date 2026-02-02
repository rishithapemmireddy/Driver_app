import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  Widget _rideCard({required String type, required String datetime, required String from, required String to, String? distance, required String amount}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(type, style: const TextStyle(color: Colors.black54)),
            Row(children: [Text(datetime, style: const TextStyle(color: Colors.black54)), const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.green.shade200)), child: const Text('Completed', style: TextStyle(color: Colors.green)))]),
          ]),
          const SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)), Container(width: 2, height: 40, color: Colors.grey.shade300)]),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('From', style: TextStyle(color: Colors.black54)), const SizedBox(height: 6), Text(from, style: const TextStyle(fontWeight: FontWeight.bold))])),
          ]),
          const SizedBox(height: 12),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle))]),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('To', style: TextStyle(color: Colors.black54)), const SizedBox(height: 6), Text(to, style: const TextStyle(fontWeight: FontWeight.bold))])),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            if (distance != null) Expanded(child: Text('Distance: $distance', style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600))),
            Text('₹$amount', style: const TextStyle(fontWeight: FontWeight.bold)),
          ])
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, foregroundColor: Colors.black, title: const Text('Rides History', style: TextStyle(color: Colors.black))),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        children: [
          _rideCard(type: 'Parcel', datetime: '30 Nov 2025, 10:30 AM', from: '5th Block, Road No-14, Indiranagar, Hyderabad', to: 'Block 7, Kukatpally, Hyderabad', distance: '6.2 km', amount: '45'),
          _rideCard(type: 'Bike', datetime: '30 Nov 2025, 10:30 AM', from: '5th Block, Road No-14, Indiranagar, Hyderabad', to: 'Block 7, Kukatpally, Hyderabad', amount: '45'),
          _rideCard(type: 'Parcel', datetime: '30 Nov 2025, 10:30 AM', from: '5th Block, Road No-14, Indiranagar, Hyderabad', to: 'Block 7, Kukatpally, Hyderabad', distance: '6.2 km', amount: '45'),
          _rideCard(type: 'Bike', datetime: '30 Nov 2025, 10:30 AM', from: '5th Block, Road No-14, Indiranagar, Hyderabad', to: 'Block 7, Kukatpally, Hyderabad', amount: '45'),
          const SizedBox(height: 80)
        ],
      ),
    );
  }
}

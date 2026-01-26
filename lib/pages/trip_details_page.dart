import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDetailsPage extends StatefulWidget {
  const TripDetailsPage({Key? key}) : super(key: key);

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  int tripState = 0; // 0 = Accept, 1 = Arrived, 2 = OTP Verification, 3 = Completed
  String cancelReason = '';

  Future<void> _openGoogleMaps() async {
    final Uri url = Uri.parse('https://www.google.com/maps');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _showOtpDialog() {
    showDialog(context: context, builder: (ctx) {
      return AlertDialog(
        title: const Text('Verify Customer OTP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Ask customer for their 4-digit OTP', style: TextStyle(color: Colors.black54, fontSize: 12)),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(4, (i) => 
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
              child: const Center(child: Text('', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            )
          )),
        ]),
        actions: [
          OutlinedButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(onPressed: () { setState(() { tripState = 3; }); Navigator.of(ctx).pop(); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade700), child: const Text('Confirm')),
        ],
      );
    });
  }

  void _showCancelDialog() {
    showDialog(context: context, builder: (ctx) {
      String selectedReason = '';
      return StatefulBuilder(builder: (ctx, setLocalState) {
        return AlertDialog(
          title: const Text('Why are you cancelling?', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Penalty Rules', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 12)),
                  const SizedBox(height: 8),
                  const Text('• After accepting: ₹10-30 (based on reason)\n• After arrival: ₹30-50 (based on reason)\n• Customer/Vehicle issues: No penalty\n• Max 3 cancellations per day\n• Frequent cancellations = Account suspension', style: TextStyle(fontSize: 11, color: Colors.black54)),
                ]),
              ),
              const SizedBox(height: 16),
              _cancelOption('Driver is taking too long', 'Driver is taking too long', selectedReason, (val) => setLocalState(() => selectedReason = val)),
              _cancelOption('Customer not responding', 'Customer not responding', selectedReason, (val) => setLocalState(() => selectedReason = val)),
              _cancelOption('Customer asked to cancel', 'Customer asked to cancel', selectedReason, (val) => setLocalState(() => selectedReason = val)),
              _cancelOption('Wrong pickup location', 'Wrong pickup location', selectedReason, (val) => setLocalState(() => selectedReason = val)),
              _cancelOption('Vehicle breakdown', 'Vehicle breakdown', selectedReason, (val) => setLocalState(() => selectedReason = val)),
              _cancelOption('Accepted by mistake', 'Accepted by mistake', selectedReason, (val) => setLocalState(() => selectedReason = val)),
              _cancelOption('Other reason', 'Other reason', selectedReason, (val) => setLocalState(() => selectedReason = val)),
            ]),
          ),
          actions: [
            OutlinedButton(onPressed: () => Navigator.of(ctx).pop(), style: OutlinedButton.styleFrom(foregroundColor: Colors.blue), child: const Text('Keep Ride')),
            ElevatedButton(onPressed: () { Navigator.of(ctx).pop(); Navigator.of(context).pop(); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Cancel')),
          ],
        );
      });
    });
  }

  Widget _cancelOption(String label, String value, String selected, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Radio<String>(value: value, groupValue: selected, onChanged: (val) => onChanged(val ?? '')),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Map placeholder background
        Container(color: Colors.grey.shade300),
        
        Align(alignment: Alignment.topLeft, child: SafeArea(child: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()))),
        
        // Open Google Maps button
        Align(alignment: Alignment.topCenter, child: Padding(padding: const EdgeInsets.only(top: 100.0), child: GestureDetector(onTap: _openGoogleMaps, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.map, color: Colors.blue, size: 20), const SizedBox(width: 8), const Text('Open Google Maps', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600))]),)))),

        Align(
          alignment: Alignment.bottomCenter,
          child: DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.25,
            maxChildSize: 0.75,
            builder: (context, ctrl) => Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
              child: ListView(controller: ctrl, children: [
                // Passenger Info
                Row(children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.orange.shade200, shape: BoxShape.circle),
                    child: Center(child: Text('RK', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.orange.shade700))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('Venkat Rao', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const Text('+91 9534339439', style: TextStyle(color: Colors.black54, fontSize: 12)),
                    ]),
                  ),
                  IconButton(icon: Icon(Icons.call, color: Colors.green.shade600), onPressed: () {}),
                  IconButton(icon: Icon(Icons.chat, color: Colors.blue.shade600), onPressed: () {}),
                ]),

                const SizedBox(height: 16),

                // Trip Details Header
                const Text('Trip Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 12),

                // Pickup Location
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(children: [
                    Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                    Container(width: 2, height: 30, color: Colors.grey.shade300),
                  ]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('Block 2, Main Road, Ramraju Nagar, Hyderabad, Telengana', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    ]),
                  ),
                ]),

                const SizedBox(height: 8),

                // Dropoff Location
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('Door No - 47/333/A, Block 7, Kukatpally, Main Junction, Hyderabad', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    ]),
                  ),
                ]),

                const SizedBox(height: 16),

                // Distance and Fare
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(8)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                      Text('Distance', style: TextStyle(color: Colors.black54, fontSize: 12)),
                      SizedBox(height: 4),
                      Text('6.2 km', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ]),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: const [
                      Text('Fare', style: TextStyle(color: Colors.black54, fontSize: 12)),
                      SizedBox(height: 4),
                      Text('₹45', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ]),
                  ]),
                ),

                const SizedBox(height: 20),

                // Action Buttons based on trip state
                if (tripState == 0) ...[
                  Row(children: [
                    Expanded(child: OutlinedButton(onPressed: _showCancelDialog, style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)), child: const Text('Reject'))),
                    const SizedBox(width: 12),
                    Expanded(child: ElevatedButton(onPressed: () => setState(() => tripState = 1), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade700, padding: const EdgeInsets.symmetric(vertical: 12)), child: const Text('Accept'))),
                  ]),
                ] else if (tripState == 1) ...[
                  Row(children: [
                    Expanded(child: OutlinedButton(onPressed: _showCancelDialog, style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)), child: const Text('Cancel Ride'))),
                    const SizedBox(width: 12),
                    Expanded(child: ElevatedButton(onPressed: () => setState(() => tripState = 2), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade600, padding: const EdgeInsets.symmetric(vertical: 12)), child: const Text('I have Arrived'))),
                  ]),
                ] else if (tripState == 2) ...[
                  Row(children: [
                    Expanded(child: OutlinedButton(onPressed: _showCancelDialog, style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)), child: const Text('Cancel Ride'))),
                    const SizedBox(width: 12),
                    Expanded(child: ElevatedButton(onPressed: _showOtpDialog, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade600, padding: const EdgeInsets.symmetric(vertical: 12)), child: const Text('Verify OTP & Start'))),
                  ]),
                ] else if (tripState == 3) ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => Navigator.of(context).pop(), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('Complete Ride')),
                  ),
                ],

                const SizedBox(height: 20),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}

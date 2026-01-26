import 'package:flutter/material.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  Widget _planCard(String title, String price, bool selected) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: selected ? const BorderSide(color: Color(0xFF1553C2), width: 2) : BorderSide.none),
      elevation: selected ? 6 : 2,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), Text('₹$price', style: const TextStyle(fontSize: 18, color: Color(0xFF1553C2)))]),
          const SizedBox(height: 12),
          const Text('• 10% discount on all rides - Forever'),
          const Text('• Lifetime validity'),
          const Text('• Free cancellation'),
          const Text('• No surge pricing'),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, foregroundColor: Colors.black, title: const Text('Subscription Plans', style: TextStyle(color: Colors.black))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const Align(alignment: Alignment.centerLeft, child: Text('Select your subscription plan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
          const SizedBox(height: 12),
          _planCard('Starter', '299 /30days', false),
          const SizedBox(height: 12),
          _planCard('Executive', '499 /30days', true),
          const SizedBox(height: 12),
          _planCard('Premium', '999 /30days', false),
          const Spacer(),
        ]),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
        child: Row(children: [
          Expanded(child: Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle), child: const Icon(Icons.account_balance_wallet, color: Colors.white)), const SizedBox(width: 8), const Text('UPI')])),
          const SizedBox(width: 12),
          ElevatedButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Subscribed (mock)'))); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1553C2), padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text('Pay ₹499', style: TextStyle(fontSize: 16)))
        ]),
      ),
    );
  }
}

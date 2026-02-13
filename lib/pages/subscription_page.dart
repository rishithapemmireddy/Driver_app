import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late String selectedPlan;
  late int selectedPrice;

  final List<Map<String, dynamic>> plans = [
    {'title': 'Starter', 'price': 299, 'period': '/30days'},
    {'title': 'Executive', 'price': 499, 'period': '/30days'},
    {'title': 'Premium', 'price': 999, 'period': '/30days'},
  ];

  @override
  void initState() {
    super.initState();
    selectedPlan = plans[1]['title'];
    selectedPrice = plans[1]['price'];
  }

  Widget _planCard(String title, int price, String period, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: selected ? const BorderSide(color: Color(0xFF1553C2), width: 2) : BorderSide.none),
        elevation: selected ? 6 : 2,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), Text('₹$price $period', style: const TextStyle(fontSize: 18, color: Color(0xFF1553C2)))]),
            const SizedBox(height: 12),
            const Text('• 10% discount on all rides - Forever'),
            const Text('• Lifetime validity'),
            const Text('• Free cancellation'),
            const Text('• No surge pricing'),
          ]),
        ),
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
          _planCard(plans[0]['title'], plans[0]['price'], plans[0]['period'], selectedPlan == plans[0]['title'], () {
            setState(() {
              selectedPlan = plans[0]['title'];
              selectedPrice = plans[0]['price'];
            });
          }),
          const SizedBox(height: 12),
          _planCard(plans[1]['title'], plans[1]['price'], plans[1]['period'], selectedPlan == plans[1]['title'], () {
            setState(() {
              selectedPlan = plans[1]['title'];
              selectedPrice = plans[1]['price'];
            });
          }),
          const SizedBox(height: 12),
          _planCard(plans[2]['title'], plans[2]['price'], plans[2]['period'], selectedPlan == plans[2]['title'], () {
            setState(() {
              selectedPlan = plans[2]['title'];
              selectedPrice = plans[2]['price'];
            });
          }),
          const Spacer(),
        ]),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
        child: Row(children: [
          Expanded(child: Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle), child: const Icon(Icons.account_balance_wallet, color: Colors.white)), const SizedBox(width: 8), const Text('UPI')])),
          const SizedBox(width: 12),
          ElevatedButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Subscribed to $selectedPlan - ₹$selectedPrice (mock)'))); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1553C2), padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: Text('Pay ₹$selectedPrice', style: const TextStyle(fontSize: 16, color: Colors.white)))
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MakePaymentPage extends StatelessWidget {
  final int amount;
  const MakePaymentPage({Key? key, this.amount = 195}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Make Payment', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('- ₹$amount', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Low Wallet Balance', style: TextStyle(color: Colors.red)),
                ]),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
        child: Row(children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                // Removed green background, changed to grey
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                child: Row(children: [
                  // Changed icon background from green to grey
                  Container(
                    padding: const EdgeInsets.all(8), 
                    decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle), 
                    child: const Icon(Icons.account_balance_wallet, color: Colors.white)
                  ),
                  const SizedBox(width: 12),
                  const Text('UPI'),
                  const Spacer(),
                  const Icon(Icons.chevron_right)
                ]),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {
              // simulate payment
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment completed')));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1553C2), 
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14), 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
            ),
            // Changed text color to white
            child: Text('Pay ₹$amount', style: const TextStyle(fontSize: 16, color: Colors.white)),
          )
        ]),
      ),
    );
  }
}
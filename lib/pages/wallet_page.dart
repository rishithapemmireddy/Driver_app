import 'package:flutter/material.dart';
import 'make_payment_page.dart';
import 'payout_methods_page.dart';
import 'subscription_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2D6BE6), Color(0xFF1A4FC6)]),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Current Balance', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          const Text('- ₹195', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const MakePaymentPage())); },
            icon: const Icon(Icons.arrow_upward, color: Colors.red),
            label: const Text('Pay Commission', style: TextStyle(color: Colors.red)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTransactionRow(String title, String subtitle, String amount) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.grey.shade200, child: Icon(Icons.currency_rupee, color: Colors.black87)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildBottomPayBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Row(children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              // Removed green background
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                // Changed icon container from green to grey
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
          onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const MakePaymentPage())); },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1553C2), 
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14), 
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
          ),
          // Changed text color to white
          child: const Text('Pay ₹195', style: TextStyle(fontSize: 16, color: Colors.white)),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Wallet', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue[800],
            labelColor: Colors.blue[800],
            unselectedLabelColor: Colors.black54,
            tabs: const [Tab(icon: Icon(Icons.account_balance_wallet_outlined), text: 'Wallet'), Tab(icon: Icon(Icons.show_chart), text: 'Earnings')],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    _buildBalanceCard(context),
                    ListTile(
                      leading: const Icon(Icons.account_balance, color: Color(0xFF1553C2)),
                      title: const Text('Payout Methods'),
                      subtitle: const Text('Add bank to receive withdrawals'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PayoutMethodsPage())); },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Text('Transaction History', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    _buildTransactionRow('Ride completed - Online payment', '10:39 PM\nCommission: ₹0   GST: ₹4', '+₹85'),
                    const Divider(),
                    _buildTransactionRow('Ride completed - Cash collected', '10:39 PM\nCommission: ₹24   GST: ₹4', '₹120'),
                    const Divider(),
                    _buildTransactionRow('Ride completed - Online payment', '10:39 PM\nCommission: ₹0   GST: ₹4', '+₹85'),
                  ],
                ),
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF2D6BE6), Color(0xFF1A4FC6)]),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,4))],
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                        Text("This Week's Earnings", style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 8),
                        Text('₹721', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        Row(children: [
                          Expanded(child: Card(color: Color(0xFF3C7BF0),child: Padding(padding: EdgeInsets.all(12), child: Column(children:[Text('Total Rides', style: TextStyle(color: Colors.white70)), SizedBox(height:8), Text('8', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])))),
                          SizedBox(width: 12),
                          Expanded(child: Card(color: Color(0xFF3C7BF0),child: Padding(padding: EdgeInsets.all(12), child: Column(children:[Text('Avg per Ride', style: TextStyle(color: Colors.white70)), SizedBox(height:8), Text('₹90', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])))),
                        ])
                      ]),
                    ),
                    const SizedBox(height: 20),
                    const Text('Daily Breakdown', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: const Icon(Icons.subscriptions, color: Color(0xFF1553C2)),
                      title: const Text('Subscription Plans'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionPage())); },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: _buildBottomPayBar(context),
    );
  }
}
import 'package:flutter/material.dart';
import 'payout_methods_page.dart';
import 'subscription_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Widget _buildListCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,2))],
      ),
      child: Column(children: children),
    );
  }

  Widget _tile(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 44, 16, 20),
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xFF0D5ED7)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                CircleAvatar(radius: 30, backgroundColor: Colors.white24, child: const Icon(Icons.person, size: 30, color: Colors.white)),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text('Rajesh Kumar', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('+91 98765 43210', style: TextStyle(color: Colors.white70)),
                ])
              ]),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: const Text('Member since Nov 2023', style: TextStyle(color: Colors.white)),
              ),
            ]),
          ),

          // rating card (use translate to achieve overlap without negative margin)
          Transform.translate(
            offset: const Offset(0, -30),
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,2))]),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: const [
                Column(children: [Icon(Icons.star, color: Colors.amber), SizedBox(height: 6), Text('4.8', style: TextStyle(fontWeight: FontWeight.bold)), Text('Rating', style: TextStyle(color: Colors.black54))]),
                Column(children: [Text('135', style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 6), Text('Rides', style: TextStyle(color: Colors.black54))])
              ]),
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Text('ACCOUNT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54))),
                _buildListCard([
                  _tile(Icons.person_outline, 'Edit Profile'),
                  const Divider(height: 1),
                  _tile(Icons.location_on_outlined, 'Documents', onTap: () { Navigator.pushNamed(context, '/profile_photo'); }),
                  const Divider(height: 1),
                  _tile(Icons.credit_card_outlined, 'Bank Details', onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PayoutMethodsPage())); }),
                  const Divider(height: 1),
                  _tile(Icons.subscriptions_outlined, 'Subscription Plans', onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionPage())); }),
                ]),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Text('PREFERENCES', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54))),
                _buildListCard([
                  _tile(Icons.notifications_none_outlined, 'Notifications'),
                  const Divider(height: 1),
                  _tile(Icons.shield_outlined, 'Privacy & Safety'),
                ]),
                const SizedBox(height: 80)
              ],
            ),
          )
        ],
      ),
    );
  }
}

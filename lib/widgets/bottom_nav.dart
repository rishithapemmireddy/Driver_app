import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.blue[800];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE6E9EE), width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: color,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 26), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined, size: 26), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.history, size: 26), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 26), label: 'Profile'),
        ],
      ),
    );
  }
}

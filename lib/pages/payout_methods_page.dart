import 'package:flutter/material.dart';

class PayoutMethodsPage extends StatefulWidget {
  const PayoutMethodsPage({Key? key}) : super(key: key);

  @override
  State<PayoutMethodsPage> createState() => _PayoutMethodsPageState();
}

class BankAccount {
  final String holderName;
  final String accountNumber;
  final String ifsc;
  final String bankName;
  BankAccount({required this.holderName, required this.accountNumber, required this.ifsc, required this.bankName});
}

class _PayoutMethodsPageState extends State<PayoutMethodsPage> {
  BankAccount? _bank;

  void _showAddBankSheet() {
    final holderController = TextEditingController();
    final accountController = TextEditingController();
    final confirmController = TextEditingController();
    final ifscController = TextEditingController();
    String bankName = 'Auto fill from IFSC Code';

    void updateBankNameFromIFSC(String ifsc) {
      // mock autofill based on IFSC prefix
      if (ifsc.toUpperCase().startsWith('HDFC')) bankName = 'HDFC Bank';
      else if (ifsc.toUpperCase().startsWith('ICIC')) bankName = 'ICICI Bank';
      else if (ifsc.trim().isEmpty) bankName = 'Auto fill from IFSC Code';
      else bankName = 'Unknown Bank';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return StatefulBuilder(builder: (context, setLocalState) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(child: Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)))),
                const SizedBox(height: 12),
                const Center(child: Text('Add Bank Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                const SizedBox(height: 16),
                TextField(
                  controller: holderController,
                  decoration: InputDecoration(labelText: 'Account Holder Name *', hintText: 'As per bank records', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: accountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Account Number *', hintText: 'Enter account number', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: confirmController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Confirm Account Number *', hintText: 'Enter confirm account number', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: ifscController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(labelText: 'IFSC Code *', hintText: 'Enter ifsc code', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                  onChanged: (v) { setLocalState((){ updateBankNameFromIFSC(v); }); },
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                  child: Text(bankName, style: const TextStyle(color: Colors.black87)),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    final holder = holderController.text.trim();
                    final acc = accountController.text.trim();
                    final conf = confirmController.text.trim();
                    final ifsc = ifscController.text.trim();
                    if (holder.isEmpty || acc.isEmpty || conf.isEmpty || ifsc.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields')));
                      return;
                    }
                    if (acc != conf) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account numbers do not match')));
                      return;
                    }
                    final bn = ifsc.toUpperCase().startsWith('HDFC') ? 'HDFC Bank' : (ifsc.toUpperCase().startsWith('ICIC') ? 'ICICI Bank' : 'Bank');
                    setState(() {
                      _bank = BankAccount(holderName: holder, accountNumber: acc, ifsc: ifsc.toUpperCase(), bankName: bn);
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bank account added')));
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF1553C2)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const SizedBox(width: double.infinity, child: Center(child: Text('Add Bank Account', style: TextStyle(color: Color(0xFF1553C2), fontSize: 16))))
                ),
                const SizedBox(height: 16),
              ]),
            ),
          );
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, foregroundColor: Colors.black, title: const Text('Payout Methods', style: TextStyle(color: Colors.black))),
      body: Column(children: [
        const SizedBox(height: 20),
        if (_bank == null)
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                const Icon(Icons.account_balance, size: 36, color: Color(0xFF1553C2)),
                const SizedBox(height: 12),
                const Text('No Bank Account Added', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Add a bank account to receive withdrawals', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 12),
                ElevatedButton(
  onPressed: _showAddBankSheet,
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1553C2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: const Padding(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    child: Text(
      'Add Bank Account',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
),

              ]),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(_bank!.holderName, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 6), Text('${'XXXX XXXX ' + (_bank!.accountNumber.length >= 4 ? _bank!.accountNumber.substring(_bank!.accountNumber.length-4) : _bank!.accountNumber)}', style: const TextStyle(letterSpacing: 1.5))]), PopupMenuButton(itemBuilder: (c) => [const PopupMenuItem(child: Text('Edit')), const PopupMenuItem(child: Text('Remove'))])]),
                  const SizedBox(height: 8),
                  Text('IFSC Code : ${_bank!.ifsc}', style: const TextStyle(color: Colors.black54)),
                ]),
              ),
            ),
          ),
        const SizedBox(height: 16),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: const Color(0xFFF2F8FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Verification Process', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• Verified via penny drop (₹1 deposit test)'),
              Text('• Verification typically takes 2-5 seconds'),
              Text('• Withdrawals are blocked until verification is complete'),
              Text('• At least one verified method is mandatory'),
            ]),
          ),
        )
      ]),
    );
  }
}

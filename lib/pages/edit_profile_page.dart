import 'package:flutter/material.dart';
import '../models/app_data.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final appData = AppData();
  
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late String _selectedGender;

  final Color logoBlue = const Color(0xFF154FB9);
  final Color darkBlueButton = const Color(0xFF084594);
  final Color secondaryText = const Color(0xFF5E6D82);
  final Color scaffoldBg = const Color(0xFFF9FBFF);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: appData.userData.fullName);
    _emailController = TextEditingController(text: appData.userData.email);
    _phoneController = TextEditingController(text: appData.userData.phoneNumber);
    _addressController = TextEditingController(text: appData.userData.address);
    _selectedGender = appData.userData.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: logoBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Full Name"),
            _field(_nameController, Icons.person_outline, "Enter your name"),
            
            _label("Email Address"),
            _field(_emailController, Icons.email_outlined, "Enter your email"),
            
            _label("Mobile Number"),
            _field(_phoneController, Icons.phone_outlined, "Enter your mobile number"),
            
            _label("Gender"),
            Row(
              children: [
                _genderBtn("Male"),
                const SizedBox(width: 10),
                _genderBtn("Female"),
                const SizedBox(width: 10),
                _genderBtn("Others"),
              ],
            ),
            
            const SizedBox(height: 20),
            _label("Address"),
            _field(_addressController, Icons.location_on_outlined, "Enter your address", isLarge: true),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  appData.updateUserProfile(
                    fullName: _nameController.text,
                    email: _emailController.text,
                    phoneNumber: _phoneController.text,
                    gender: _selectedGender,
                    address: _addressController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated successfully!')),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: logoBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF5E6D82)),
      ),
    );
  }

  Widget _field(TextEditingController controller, IconData icon, String hint, {bool isLarge = false}) {
    return TextField(
      controller: controller,
      maxLines: isLarge ? 3 : 1,
      cursorColor: logoBlue,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey, size: 22),
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: logoBlue, width: 1.5),
        ),
      ),
    );
  }

  Widget _genderBtn(String title) {
    bool isSelected = _selectedGender == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGender = title),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? logoBlue : Colors.grey.shade100,
              width: 1.5,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? logoBlue : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

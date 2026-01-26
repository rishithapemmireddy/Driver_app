import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/step_indicator.dart';

class ProfilePhotoPage extends StatefulWidget {
  const ProfilePhotoPage({super.key});

  @override
  State<ProfilePhotoPage> createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  Uint8List? _capturedImage;
  final ImagePicker _picker = ImagePicker();
  
  final Color logoBlue = const Color(0xFF154FB9);
  final Color darkBlueButton = const Color(0xFF084594);
  final Color secondaryText = const Color(0xFF5E6D82);
  final Color scaffoldBg = const Color(0xFFF9FBFF);

  final String _defaultUrl = "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=1000";

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
      );
      if (photo != null) {
        final Uint8List bytes = await photo.readAsBytes();
        setState(() {
          _capturedImage = bytes;
        });
      }
    } catch (e) {
      debugPrint("Camera error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile Photo",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Take a photo of yourself for verification",
              style: TextStyle(color: secondaryText, fontSize: 12),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 20),
            child: Text(
              "Step 3 of 4",
              style: TextStyle(color: logoBlue, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StepIndicator(currentStep: 3),
          ),
          
          const SizedBox(height: 40),
          
          Expanded(
            child: Center(
              child: Container(
                width: 300,
                height: 420,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F5FA),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 260,
                      height: 330,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.elliptical(130, 165)),
                        border: Border.all(color: Colors.white, width: 6),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.elliptical(130, 165)),
                        child: _capturedImage != null
                            ? Image.memory(_capturedImage!, fit: BoxFit.cover)
                            : Image.network(_defaultUrl, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 25),
                    
                    GestureDetector(
                      onTap: _takePhoto,
                      child: Text(
                        _capturedImage == null ? "Retake Photo" : "Retake Photo",
                        style: TextStyle(
                          color: logoBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),

          // --- Next Button (Always Enabled) ---
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                // Removed the check so it's always clickable
                onPressed: () => Navigator.pushNamed(context, '/upload_docs'), 
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBlueButton,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
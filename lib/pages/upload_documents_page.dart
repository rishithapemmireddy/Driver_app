import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/step_indicator.dart';

class UploadDocumentsPage extends StatefulWidget {
  const UploadDocumentsPage({super.key});

  @override
  State<UploadDocumentsPage> createState() => _UploadDocumentsPageState();
}

class _UploadDocumentsPageState extends State<UploadDocumentsPage> {
  final ImagePicker _picker = ImagePicker();
  
  // Branding Colors from your code
  final Color logoBlue = const Color(0xFF154FB9);
  final Color darkBlueButton = const Color(0xFF084594);
  final Color secondaryText = const Color(0xFF5E6D82);
  final Color scaffoldBg = const Color(0xFFF9FBFF);

  // Initial file status mapping
  Map<String, String> selectedFiles = {
    "Aadhar Card": "Upload aadhar card file",
    "Driving Licence": "Upload driving licence file",
    "Insurance": "Upload insurance file",
    "Bike RC": "Upload bike rc file",
  };

  // Method to handle file selection from gallery
  Future<void> _pickFile(String key) async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          selectedFiles[key] = file.name;
        });
      }
    } catch (e) {
      debugPrint("File picker error: $e");
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
              "Upload Documents",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Upload the following documents",
              style: TextStyle(color: secondaryText, fontSize: 12),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 20),
            child: Text(
              "Step 4 of 4",
              style: TextStyle(color: logoBlue, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // --- Step Progress Bar ---
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StepIndicator(currentStep: 4),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selectedFiles.keys.map((key) => _buildUploadField(key)).toList(),
              ),
            ),
          ),

          // --- Submit Button (Always Enabled) ---
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.pushNamed(context, '/pending');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBlueButton,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  "Submit for Verification",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom widget for the upload rows
  Widget _buildUploadField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label, 
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF5E6D82))
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _pickFile(label),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD3E2FF), 
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: const Text(
                      "Choose file", 
                      style: TextStyle(color: Color(0xFF154FB9), fontWeight: FontWeight.bold, fontSize: 13)
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    selectedFiles[label]!, 
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 14), 
                    overflow: TextOverflow.ellipsis
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
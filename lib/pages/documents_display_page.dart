import 'package:flutter/material.dart';
import '../models/app_data.dart';

class DocumentsDisplayPage extends StatelessWidget {
  const DocumentsDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appData = AppData();
    final logoBlue = const Color(0xFF154FB9);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Documents",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: appData.userData.documents.entries.map((entry) {
          final docName = entry.key;
          final docStatus = entry.value;
          final isUploaded = docStatus != "Not uploaded" && !docStatus.contains("Upload");

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUploaded ? Colors.green.shade100 : Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isUploaded ? Icons.check_circle : Icons.file_upload_outlined,
                      color: isUploaded ? Colors.green : Colors.orange,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          docName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isUploaded ? docStatus : "Not uploaded",
                          style: TextStyle(
                            fontSize: 13,
                            color: isUploaded ? Colors.green : Colors.grey.shade600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isUploaded ? Colors.green.shade50 : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isUploaded ? "Uploaded" : "Pending",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isUploaded ? Colors.green : Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String fullName;
  String email;
  String phoneNumber;
  String gender;
  String address;
  String profilePhoto;
  Map<String, String> documents;
  double rating;
  int totalRides;
  String memberSince;

  UserData({
    this.fullName = '',
    this.email = '',
    this.phoneNumber = '',
    this.gender = 'Male',
    this.address = '',
    this.profilePhoto = '',
    this.rating = 4.8,
    this.totalRides = 135,
    this.memberSince = 'Nov 2023',
    Map<String, String>? documents,
  }) : documents = documents ??
            {
              "Aadhar Card": "Not uploaded",
              "Driving Licence": "Not uploaded",
              "Insurance": "Not uploaded",
              "Bike RC": "Not uploaded",
            };
}

class AppData {
  static final AppData _instance = AppData._internal();

  late UserData userData;

  factory AppData() {
    return _instance;
  }

  AppData._internal() {
    userData = UserData();
  }

  // Method to update user profile and save to Firestore
  Future<bool> updateUserProfile({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String gender,
    required String address,
  }) async {
    userData.fullName = fullName;
    userData.email = email;
    userData.phoneNumber = phoneNumber;
    userData.gender = gender;
    userData.address = address;

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid ?? phoneNumber;
      final docRef =
          FirebaseFirestore.instance.collection('driver_users').doc(uid);
      await docRef.set({
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'address': address,
        'profilePhoto': userData.profilePhoto,
        'rating': userData.rating,
        'totalRides': userData.totalRides,
        'memberSince': userData.memberSince,
        'documents': userData.documents,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to update a document
  void updateDocument(String documentName, String fileName) {
    userData.documents[documentName] = fileName;
  }

  // Method to get a document
  String getDocument(String documentName) {
    return userData.documents[documentName] ?? 'Not uploaded';
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/client_profile.dart';
import '../models/freelancer_profile.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create client profile
  Future<void> createClientProfile(ClientProfile profile) async {
    try {
      print('ProfileService: Starting client profile creation for UID: ${profile.uid}');
      print('ProfileService: Client profile data: ${profile.toMap()}');
      
      await _firestore.collection('client_profiles').doc(profile.uid).set(profile.toMap());
      print('ProfileService: Client profile document created successfully');
      
      // Update user document with client profile reference
      await _firestore.collection('users').doc(profile.uid).update({
        'clientProfileId': profile.uid,
        'isProfileComplete': true,
      });
      print('ProfileService: User document updated with client profile reference');
    } catch (e, stackTrace) {
      print('ProfileService: Error creating client profile:');
      print('ProfileService: Error message: $e');
      print('ProfileService: Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Create freelancer profile
  Future<void> createFreelancerProfile(FreelancerProfile profile) async {
    try {
      print('ProfileService: Starting freelancer profile creation for UID: ${profile.uid}');
      print('ProfileService: Freelancer profile data: ${profile.toMap()}');
      
      await _firestore.collection('freelancer_profiles').doc(profile.uid).set(profile.toMap());
      print('ProfileService: Freelancer profile document created successfully');
      
      // Update user document with freelancer profile reference
      await _firestore.collection('users').doc(profile.uid).update({
        'freelancerProfileId': profile.uid,
        'isProfileComplete': true,
      });
      print('ProfileService: User document updated with freelancer profile reference');
    } catch (e, stackTrace) {
      print('ProfileService: Error creating freelancer profile:');
      print('ProfileService: Error message: $e');
      print('ProfileService: Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get client profile
  Future<ClientProfile?> getClientProfile(String uid) async {
    try {
      print('ProfileService: Fetching client profile for UID: $uid');
      final doc = await _firestore.collection('client_profiles').doc(uid).get();
      
      if (doc.exists) {
        print('ProfileService: Client profile found');
        return ClientProfile.fromMap(doc.data()!);
      }
      print('ProfileService: No client profile found for UID: $uid');
      return null;
    } catch (e, stackTrace) {
      print('ProfileService: Error getting client profile:');
      print('ProfileService: Error message: $e');
      print('ProfileService: Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get freelancer profile
  Future<FreelancerProfile?> getFreelancerProfile(String uid) async {
    try {
      print('ProfileService: Fetching freelancer profile for UID: $uid');
      final doc = await _firestore.collection('freelancer_profiles').doc(uid).get();
      
      if (doc.exists) {
        print('ProfileService: Freelancer profile found');
        return FreelancerProfile.fromMap(doc.data()!);
      }
      print('ProfileService: No freelancer profile found for UID: $uid');
      return null;
    } catch (e, stackTrace) {
      print('ProfileService: Error getting freelancer profile:');
      print('ProfileService: Error message: $e');
      print('ProfileService: Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Update client profile
  Future<void> updateClientProfile(ClientProfile profile) async {
    try {
      print('ProfileService: Starting client profile update for UID: ${profile.uid}');
      print('ProfileService: Updated client profile data: ${profile.toMap()}');
      
      await _firestore.collection('client_profiles').doc(profile.uid).update(profile.toMap());
      print('ProfileService: Client profile updated successfully');
    } catch (e, stackTrace) {
      print('ProfileService: Error updating client profile:');
      print('ProfileService: Error message: $e');
      print('ProfileService: Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Update freelancer profile
  Future<void> updateFreelancerProfile(FreelancerProfile profile) async {
    try {
      print('ProfileService: Starting freelancer profile update for UID: ${profile.uid}');
      print('ProfileService: Updated freelancer profile data: ${profile.toMap()}');
      
      await _firestore.collection('freelancer_profiles').doc(profile.uid).update(profile.toMap());
      print('ProfileService: Freelancer profile updated successfully');
    } catch (e, stackTrace) {
      print('ProfileService: Error updating freelancer profile:');
      print('ProfileService: Error message: $e');
      print('ProfileService: Stack trace: $stackTrace');
      rethrow;
    }
  }
} 
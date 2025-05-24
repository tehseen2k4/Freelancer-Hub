import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum UserRole {
  client,
  freelancer,
}

class UserModel {
  final String uid;
  final String email;
  final UserRole role;
  final DateTime createdAt;
  final DateTime lastLoginAt;
  final bool isProfileComplete;
  final String? clientProfileId;  // Reference to ClientModel
  final String? freelancerProfileId;  // Reference to FreelancerModel
  final bool isActive;

  UserModel({
    required this.uid,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.lastLoginAt,
    this.isProfileComplete = false,
    this.clientProfileId,
    this.freelancerProfileId,
    this.isActive = true,
  });

  // Convert UserModel to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role.toString().split('.').last, // Convert enum to string
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLoginAt': Timestamp.fromDate(lastLoginAt),
      'isProfileComplete': isProfileComplete,
      'clientProfileId': clientProfileId,
      'freelancerProfileId': freelancerProfileId,
      'isActive': isActive,
    };
  }

  // Create UserModel from Firebase document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == map['role'],
        orElse: () => UserRole.client,
      ),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastLoginAt: (map['lastLoginAt'] as Timestamp).toDate(),
      isProfileComplete: map['isProfileComplete'] ?? false,
      clientProfileId: map['clientProfileId'],
      freelancerProfileId: map['freelancerProfileId'],
      isActive: map['isActive'] ?? true,
    );
  }

  // Create UserModel from Firebase User
  factory UserModel.fromFirebaseUser(User user, UserRole role) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      role: role,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );
  }

  // Create a copy of UserModel with updated fields
  UserModel copyWith({
    String? uid,
    String? email,
    UserRole? role,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isProfileComplete,
    String? clientProfileId,
    String? freelancerProfileId,
    bool? isActive,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      clientProfileId: clientProfileId ?? this.clientProfileId,
      freelancerProfileId: freelancerProfileId ?? this.freelancerProfileId,
      isActive: isActive ?? this.isActive,
    );
  }

  // Helper method to check if user has a profile
  bool hasProfile() {
    return role == UserRole.client 
        ? clientProfileId != null 
        : freelancerProfileId != null;
  }

  // Helper method to get profile ID based on role
  String? getProfileId() {
    return role == UserRole.client 
        ? clientProfileId 
        : freelancerProfileId;
  }
} 
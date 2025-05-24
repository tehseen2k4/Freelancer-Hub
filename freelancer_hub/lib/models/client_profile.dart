import 'package:cloud_firestore/cloud_firestore.dart';

class ClientProfile {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String companyName;
  final String companySize;
  final String industry;
  final String? website;
  final String bio;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClientProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.companyName,
    required this.companySize,
    required this.industry,
    this.website,
    required this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert ClientProfile to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
      'companyName': companyName,
      'companySize': companySize,
      'industry': industry,
      'website': website,
      'bio': bio,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create ClientProfile from Firebase document
  factory ClientProfile.fromMap(Map<String, dynamic> map) {
    return ClientProfile(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      companyName: map['companyName'] ?? '',
      companySize: map['companySize'] ?? '',
      industry: map['industry'] ?? '',
      website: map['website'],
      bio: map['bio'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Create a copy of ClientProfile with updated fields
  ClientProfile copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? location,
    String? companyName,
    String? companySize,
    String? industry,
    String? website,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClientProfile(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      companyName: companyName ?? this.companyName,
      companySize: companySize ?? this.companySize,
      industry: industry ?? this.industry,
      website: website ?? this.website,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  final String id;
  final String userId;  // Reference to UserModel
  final String fullName;
  final String email;
  final String phone;
  final String location;
  final DateTime memberSince;
  final String companyName;
  final String companySize;
  final String industry;
  final String website;
  final String profileImageUrl;
  final int totalProjects;
  final int totalFreelancers;
  final double rating;
  final Map<String, dynamic> preferences;

  ClientModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.location,
    required this.memberSince,
    required this.companyName,
    required this.companySize,
    required this.industry,
    this.website = '',
    this.profileImageUrl = '',
    this.totalProjects = 0,
    this.totalFreelancers = 0,
    this.rating = 0.0,
    this.preferences = const {},
  });

  // Convert ClientModel to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'location': location,
      'memberSince': Timestamp.fromDate(memberSince),
      'companyName': companyName,
      'companySize': companySize,
      'industry': industry,
      'website': website,
      'profileImageUrl': profileImageUrl,
      'totalProjects': totalProjects,
      'totalFreelancers': totalFreelancers,
      'rating': rating,
      'preferences': preferences,
    };
  }

  // Create ClientModel from Firebase document
  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      memberSince: (map['memberSince'] as Timestamp).toDate(),
      companyName: map['companyName'] ?? '',
      companySize: map['companySize'] ?? '',
      industry: map['industry'] ?? '',
      website: map['website'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      totalProjects: map['totalProjects'] ?? 0,
      totalFreelancers: map['totalFreelancers'] ?? 0,
      rating: (map['rating'] ?? 0.0).toDouble(),
      preferences: Map<String, dynamic>.from(map['preferences'] ?? {}),
    );
  }

  // Create a copy of ClientModel with updated fields
  ClientModel copyWith({
    String? id,
    String? userId,
    String? fullName,
    String? email,
    String? phone,
    String? location,
    DateTime? memberSince,
    String? companyName,
    String? companySize,
    String? industry,
    String? website,
    String? profileImageUrl,
    int? totalProjects,
    int? totalFreelancers,
    double? rating,
    Map<String, dynamic>? preferences,
  }) {
    return ClientModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      memberSince: memberSince ?? this.memberSince,
      companyName: companyName ?? this.companyName,
      companySize: companySize ?? this.companySize,
      industry: industry ?? this.industry,
      website: website ?? this.website,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      totalProjects: totalProjects ?? this.totalProjects,
      totalFreelancers: totalFreelancers ?? this.totalFreelancers,
      rating: rating ?? this.rating,
      preferences: preferences ?? this.preferences,
    );
  }
} 
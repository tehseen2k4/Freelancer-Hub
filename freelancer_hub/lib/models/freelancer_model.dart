import 'package:cloud_firestore/cloud_firestore.dart';

class FreelancerModel {
  final String id;
  final String userId;  // Reference to UserModel
  final String fullName;
  final String email;
  final String phone;
  final String location;
  final DateTime memberSince;
  final String title;
  final String skills;
  final String experience;
  final double hourlyRate;
  final String profileImageUrl;
  final int totalProjects;
  final double rating;
  final int yearsOfExperience;
  final Map<String, dynamic> preferences;

  FreelancerModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.location,
    required this.memberSince,
    required this.title,
    required this.skills,
    required this.experience,
    required this.hourlyRate,
    this.profileImageUrl = '',
    this.totalProjects = 0,
    this.rating = 0.0,
    this.yearsOfExperience = 0,
    this.preferences = const {},
  });

  // Convert FreelancerModel to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'location': location,
      'memberSince': Timestamp.fromDate(memberSince),
      'title': title,
      'skills': skills,
      'experience': experience,
      'hourlyRate': hourlyRate,
      'profileImageUrl': profileImageUrl,
      'totalProjects': totalProjects,
      'rating': rating,
      'yearsOfExperience': yearsOfExperience,
      'preferences': preferences,
    };
  }

  // Create FreelancerModel from Firebase document
  factory FreelancerModel.fromMap(Map<String, dynamic> map) {
    return FreelancerModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      memberSince: (map['memberSince'] as Timestamp).toDate(),
      title: map['title'] ?? '',
      skills: map['skills'] ?? '',
      experience: map['experience'] ?? '',
      hourlyRate: (map['hourlyRate'] ?? 0.0).toDouble(),
      profileImageUrl: map['profileImageUrl'] ?? '',
      totalProjects: map['totalProjects'] ?? 0,
      rating: (map['rating'] ?? 0.0).toDouble(),
      yearsOfExperience: map['yearsOfExperience'] ?? 0,
      preferences: Map<String, dynamic>.from(map['preferences'] ?? {}),
    );
  }

  // Create a copy of FreelancerModel with updated fields
  FreelancerModel copyWith({
    String? id,
    String? userId,
    String? fullName,
    String? email,
    String? phone,
    String? location,
    DateTime? memberSince,
    String? title,
    String? skills,
    String? experience,
    double? hourlyRate,
    String? profileImageUrl,
    int? totalProjects,
    double? rating,
    int? yearsOfExperience,
    Map<String, dynamic>? preferences,
  }) {
    return FreelancerModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      memberSince: memberSince ?? this.memberSince,
      title: title ?? this.title,
      skills: skills ?? this.skills,
      experience: experience ?? this.experience,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      totalProjects: totalProjects ?? this.totalProjects,
      rating: rating ?? this.rating,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      preferences: preferences ?? this.preferences,
    );
  }
} 
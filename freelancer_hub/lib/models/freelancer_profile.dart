import 'package:cloud_firestore/cloud_firestore.dart';

class FreelancerProfile {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String title;
  final List<String> skills;
  final int yearsOfExperience;
  final double hourlyRate;
  final String? bio;
  final DateTime createdAt;
  final DateTime updatedAt;

  FreelancerProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.title,
    required this.skills,
    required this.yearsOfExperience,
    required this.hourlyRate,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert FreelancerProfile to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
      'title': title,
      'skills': skills,
      'yearsOfExperience': yearsOfExperience,
      'hourlyRate': hourlyRate,
      'bio': bio,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create FreelancerProfile from Firebase document
  factory FreelancerProfile.fromMap(Map<String, dynamic> map) {
    return FreelancerProfile(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      title: map['title'] ?? '',
      skills: List<String>.from(map['skills'] ?? []),
      yearsOfExperience: map['yearsOfExperience'] ?? 0,
      hourlyRate: (map['hourlyRate'] ?? 0.0).toDouble(),
      bio: map['bio'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Create a copy of FreelancerProfile with updated fields
  FreelancerProfile copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? location,
    String? title,
    List<String>? skills,
    int? yearsOfExperience,
    double? hourlyRate,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FreelancerProfile(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      title: title ?? this.title,
      skills: skills ?? this.skills,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 
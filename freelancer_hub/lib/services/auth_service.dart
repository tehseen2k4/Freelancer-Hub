import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  UserModel? get currentUser {
    final user = _auth.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebaseUser(user, UserRole.client); // Default role, will be updated from Firestore
  }

  // Auth state changes stream
  Stream<UserModel?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      
      // Get user data from Firestore
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) return null;
      
      return UserModel.fromMap(userDoc.data()!);
    });
  }

  // Sign in with email and password
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password, UserRole role) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user data from Firestore
      final userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      if (!userDoc.exists) {
        throw Exception('User profile not found');
      }

      final userData = userDoc.data()!;
      final userRole = UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == userData['role'],
        orElse: () => UserRole.client,
      );

      if (userRole != role) {
        throw Exception('Invalid user role');
      }

      return UserModel.fromMap(userData);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found with this email');
        case 'wrong-password':
          throw Exception('Wrong password provided');
        case 'invalid-email':
          throw Exception('Invalid email address');
        case 'user-disabled':
          throw Exception('This account has been disabled');
        default:
          throw Exception('An error occurred during sign in');
      }
    }
  }

  // Register with email and password
  Future<UserModel> registerWithEmailAndPassword(
      String email, String password, UserRole role) async {
    try {
      print('AuthService: Starting registration process');
      print('AuthService: Email: $email');
      print('AuthService: Role: $role');
      
      print('AuthService: Creating user with Firebase Auth...');
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('AuthService: Firebase Auth user created successfully');
      print('AuthService: User ID: ${userCredential.user?.uid}');

      // Create user document in Firestore
      print('AuthService: Creating user document in Firestore...');
      final user = UserModel.fromFirebaseUser(userCredential.user!, role);
      print('AuthService: User model created with role: ${user.role}');
      
      print('AuthService: Saving user data to Firestore...');
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
      print('AuthService: User document saved successfully');

      return user;
    } on FirebaseAuthException catch (e) {
      print('AuthService: Firebase Auth Exception occurred:');
      print('AuthService: Error code: ${e.code}');
      print('AuthService: Error message: ${e.message}');
      print('AuthService: Stack trace: ${e.stackTrace}');
      
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('Email is already registered');
        case 'invalid-email':
          throw Exception('Invalid email address');
        case 'weak-password':
          throw Exception('Password is too weak');
        case 'operation-not-allowed':
          throw Exception('Email/password accounts are not enabled. Please contact support.');
        case 'network-request-failed':
          throw Exception('Network error. Please check your internet connection.');
        default:
          throw Exception('An error occurred during registration: ${e.message}');
      }
    } catch (e, stackTrace) {
      print('AuthService: Unexpected error during registration:');
      print('AuthService: Error: $e');
      print('AuthService: Stack trace: $stackTrace');
      throw Exception('An unexpected error occurred during registration: $e');
    }
  }

  // Create user profile
  Future<void> createUserProfile({
    required String uid,
    required UserRole role,
    required Map<String, dynamic> profileData,
  }) async {
    try {
      final collection = role == UserRole.client ? 'client_profiles' : 'freelancer_profiles';
      final profileRef = await _firestore.collection(collection).add(profileData);
      
      // Update user document with profile reference
      await _firestore.collection('users').doc(uid).update({
        'isProfileComplete': true,
        '${role == UserRole.client ? 'clientProfileId' : 'freelancerProfileId'}': profileRef.id,
      });
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found with this email');
        case 'invalid-email':
          throw Exception('Invalid email address');
        default:
          throw Exception('Failed to send password reset email');
      }
    }
  }
} 
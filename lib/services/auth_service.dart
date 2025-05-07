import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_talk/services/logger_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late SharedPreferences _prefs;

  AuthService() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      // 1. Create user with Firebase Auth
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Save user details to Firestore
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'fullName': fullName,
          'level': 1,
          'xp': 0,
          'timeSpent': 0,
          'conversations': 0,
          'streak': 0,
          'achievements': {
            'first_chat': false,
            'thirty_minutes': false,
            'three_day_streak': false,
          },
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Save auth state
        await _prefs.setBool('isLoggedIn', true);
        await _prefs.setString('userId', userCredential.user!.uid);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      Logger.error('Sign up error', e);
      rethrow;
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Sign in with Firebase Auth
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Check if user exists in Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      // 3. If user doesn't exist in Firestore, create their document
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // Save auth state
      await _prefs.setBool('isLoggedIn', true);
      await _prefs.setString('userId', userCredential.user!.uid);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      Logger.error('Sign in error', e);
      rethrow;
    }
  }

  // Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google sign in aborted');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      // Create or update user document in Firestore
      if (userCredential.user != null) {
        await _createOrUpdateUserDocument(userCredential.user!);

        // Save auth state
        await _prefs.setBool('isLoggedIn', true);
        await _prefs.setString('userId', userCredential.user!.uid);
      }

      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);

      // Clear auth state
      await _prefs.setBool('isLoggedIn', false);
      await _prefs.remove('userId');
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    return _prefs.getBool('isLoggedIn') ?? false;
  }

  // Restore auth state
  Future<void> restoreAuthState() async {
    if (await isLoggedIn()) {
      final userId = _prefs.getString('userId');
      if (userId != null) {
        try {
          final userDoc =
              await _firestore.collection('users').doc(userId).get();
          if (userDoc.exists) {
            // Auth state will be restored automatically by Firebase
            return;
          }
        } catch (e) {
          Logger.error('Error restoring auth state', e);
        }
      }
    }
    // If anything fails, clear the stored state
    await _prefs.setBool('isLoggedIn', false);
    await _prefs.remove('userId');
  }

  // Create or update user document in Firestore
  Future<void> _createOrUpdateUserDocument(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    final userData = {
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
      'lastSignIn': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
      'level': 1,
      'xp': 0,
      'timeSpent': 0,
      'conversations': 0,
      'streak': 0,
      'achievements': {
        'first_chat': false,
        'thirty_minutes': false,
        'three_day_streak': false,
      },
    };

    try {
      await userDoc.set(userData, SetOptions(merge: true));
    } catch (e) {
      print('Error creating/updating user document: $e');
      rethrow;
    }
  }

  // Get user data from Firestore
  Future<DocumentSnapshot> getUserData(String userId) async {
    try {
      return await _firestore.collection('users').doc(userId).get();
    } catch (e) {
      print('Error getting user data: $e');
      rethrow;
    }
  }

  // Update user data in Firestore
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      Logger.error('Update user data error', e);
      rethrow;
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Logger.error('Password reset error', e);
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Logger.error('Password Reset Error', e);
      rethrow;
    }
  }
}

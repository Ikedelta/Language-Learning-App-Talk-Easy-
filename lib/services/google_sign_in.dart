import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
    signInOption: SignInOption.standard, // This forces the account picker
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // First sign out to clear any cached credentials
      await _googleSignIn.signOut();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign-In was cancelled by user');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception('Could not get auth details from Google');
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await _updateUserData(userCredential.user!);
        return userCredential;
      } else {
        throw Exception('Failed to sign in with Google - No user returned');
      }
    } catch (e) {
      print('Google Sign-In Error: $e');
      rethrow; // Rethrow to handle in the UI
    }
  }

  Future<void> _updateUserData(User user) async {
    final userRef = _firestore.collection('users').doc(user.uid);
    final userDoc = await userRef.get();

    if (!userDoc.exists) {
      // Create new user document
      await userRef.set({
        'uid': user.uid,
        'email': user.email,
        'fullName': user.displayName ?? 'Google User',
        'photoURL': user.photoURL,
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
        'lastLogin': FieldValue.serverTimestamp(),
      });
    } else {
      // Update existing user document
      await userRef.update({
        'lastLogin': FieldValue.serverTimestamp(),
        'email': user.email,
        'fullName':
            user.displayName ?? userDoc.data()?['fullName'] ?? 'Google User',
        'photoURL': user.photoURL,
      });
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String email,
    required String password,
    required String username,
}) async {
    try {

      // maka create og acct sa user gamit ang firebase authentication
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim()
      );

      //ma save ang user sa FIRESTORE
      await _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username.trim(),
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      throw Exception('Registration failed: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
}

    //maka logout ang user
    Future<void> signOut() async{
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  //e load ang data sa current user (email and username)
  Future<Map<String, String?>> getUserData() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        return {'username': null, 'email': null};
      }

      final doc = await _firebaseFirestore.collection('users').doc(user.uid).get();
      final data = doc.data();
      final username = doc.exists ? (data?['username'] as String?) : null;
      final email = user.email;

      return {'username': username, 'email': email};
    } catch (e) {
      print('Error fetching user data: $e');
      return {'username': null, 'email': null};
    }
  }
}
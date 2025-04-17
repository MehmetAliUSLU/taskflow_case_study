// lib/repositories/auth_repository.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Firebase Authentication işlemlerini sarmalayan repository
class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  /// Mevcut oturum açmış kullanıcıyı döner
  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  /// Kullanıcının oturum açıp açmadığını kontrol eder
  Future<bool> isSignedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  /// Oturum açmış kullanıcının UID’sini döner
  Future<String?> getUserId() async {
    return _firebaseAuth.currentUser?.uid;
  }

  /// E-posta/şifre ile kayıt olur
  Future<UserCredential> registerWithEmail({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// E-posta/şifre ile oturum açar
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Google hesabı ile oturum açar
  Future<UserCredential?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await _firebaseAuth.signInWithCredential(credential);
  }

  /// Oturumu kapatır
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}

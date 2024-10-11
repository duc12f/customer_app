import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instance của FirebaseAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Lấy user hiện tại
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Đăng nhập
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kiểm tra email đã xác thực chưa
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        await _firebaseAuth.signOut(); // Đăng xuất nếu email chưa xác thực
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email before logging in.',
        );
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'An error occurred during login');
    }
  }

  // Đăng ký tài khoản
  Future<UserCredential?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Sau khi đăng ký, gửi email xác thực
      await sendEmailVerification();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'An error occurred during registration');
    }
  }

  // Gửi email xác thực
  Future<void> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;

    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
      } catch (e) {
        throw Exception('Error sending verification email');
      }
    }
  }

  // Kiểm tra email đã được xác thực chưa
  Future<bool> isEmailVerified() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.reload(); // Cập nhật lại trạng thái của user
      return user.emailVerified;
    }
    return false;
  }

  // Đăng xuất
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

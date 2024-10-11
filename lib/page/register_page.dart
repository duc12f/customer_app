import 'package:bandoan/components/my_button2.dart';
import 'package:bandoan/components/mytext_filed.dart';
import 'package:bandoan/service/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> register() async {
    final authService = AuthService();

    if (passwordController.text == confirmPasswordController.text) {
      try {
        // Đăng ký tài khoản
        await authService.signUpWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );

        // Gửi email xác nhận
        await authService.sendEmailVerification();

        // Đăng xuất ngay lập tức để không tự động vào app
        await FirebaseAuth.instance.signOut();

        // Hiển thị thông báo yêu cầu xác thực email
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Verify your email"),
              content: const Text(
                "A verification email has been sent to your email. Please verify your account before logging in.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng dialog
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        // Hiển thị thông báo lỗi nếu xảy ra lỗi
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Error"),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng dialog
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      }
    } else {
      // Hiển thị thông báo khi mật khẩu không khớp
      if (mounted) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text("Passwords don't match"),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.lock_open_rounded,
              size: 50,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            const SizedBox(height: 16),
            Text(
              "Let's create an account for you",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            const SizedBox(height: 30),

            // Email field
            MyTextFiled(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),

            const SizedBox(height: 30),

            // Password field
            MyTextFiled(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),

            const SizedBox(height: 30),

            // Confirm Password field
            MyTextFiled(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              obscureText: true,
            ),

            const SizedBox(height: 30),

            // Sign Up button
            MyButton2(
              onPressed: register,
              text: 'Sign Up',
            ),

            const SizedBox(height: 20),

            // Already have an account? Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Login now',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

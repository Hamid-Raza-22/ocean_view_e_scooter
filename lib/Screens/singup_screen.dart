import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late AnimationController _buttonController;
  late Animation<double> _buttonAnimation;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _slideController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _slideAnimation = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));
    _buttonController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _buttonAnimation = CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut);
    _fadeController.forward();
    _slideController.forward();
    _buttonController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _buttonController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUpWithEmail() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('UserWithEmailAndPassword').doc(_emailController.text).set({
        // 'town_name': _nameController.text,
        // 'town_address': _addressController.text,
        // 'owner_name': _ownerController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        // 'image': imageUrl,
        // 'phone': _contactNumberController.text, // Storing phone number
      });

      Get.snackbar(" Login Successful", "", backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      Get.offNamed('/login');
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      Get.offNamed('/home');
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
      print(e.toString());
    }
  }




  Future<void> _signInWithFacebook() async {
    try {
      // Attempt to log in the user using Facebook
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Get the access token as a string
        final String? token = result.accessToken?.tokenString;

        // Ensure that the token is not null before proceeding
        if (token != null) {
          // Create a Facebook Auth credential using the token
          final OAuthCredential credential = FacebookAuthProvider.credential(token);

          // Use the credential to sign in with Firebase
          await _auth.signInWithCredential(credential);

          // Navigate to the home page on successful login
          Get.offNamed('/home');
        } else {
          Get.snackbar("Error", "Failed to retrieve access token.", backgroundColor: Colors.red);
        }
      } else {
        Get.snackbar("Error", result.message ?? "Unknown error", backgroundColor: Colors.red);
      }
    } catch (e) {
      // Show an error message if the login fails
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 76),
                FadeTransition(opacity: _fadeAnimation, child: SizedBox(width: 100, height: 80, child: Image.asset('assets/images/e_bikeLogo.png'))),
                const SizedBox(height: 20),
                SlideTransition(position: _slideAnimation, child: const Text('Welcome', style: TextStyle(fontFamily: 'Inter', fontSize: 40, fontWeight: FontWeight.w600, height: 1.75, color: Colors.white))),
                const SizedBox(height: 20),
                _buildInputField(context, label: 'Email', hintText: 'Enter your email', isPassword: false, controller: _emailController),
                const SizedBox(height: 20),
                _buildInputField(context, label: 'Password', hintText: 'Enter your password', isPassword: true, controller: _passwordController),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _signUpWithEmail,
                  child: _buildSignUpButton(),
                ),
                const SizedBox(height: 10),
                const Text("OR", style: TextStyle(fontFamily: 'Kanit', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon('assets/icons/google.png', _signInWithGoogle),
                    const SizedBox(width: 30),
                    _buildSocialIcon('assets/icons/facebook.png', _signInWithFacebook),
                         const SizedBox(width: 30),
                    _buildSocialIcon('assets/icons/instagram.png', _signInWithFacebook),
                         const SizedBox(width: 30),
                    _buildSocialIcon('assets/icons/twitter.png', _signInWithFacebook),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context, {required String label, required String hintText, required bool isPassword, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label:', style: const TextStyle(fontFamily: 'Inter', fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white)),
        const SizedBox(height: 10),
        Container(
          width: 350,
          height: 70,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF00E276), width: 2)),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 20), hintText: hintText, hintStyle: const TextStyle(color: Colors.grey)),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      width: 200,
      height: 70,
      decoration: BoxDecoration(color: const Color(0xFF00E276), borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 3))]),
      alignment: Alignment.center,
      child: const Text('Sign Up', style: TextStyle(fontFamily: 'Inter', fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  Widget _buildSocialIcon(String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(assetPath, width: 30, height: 30),
    );
  }
}

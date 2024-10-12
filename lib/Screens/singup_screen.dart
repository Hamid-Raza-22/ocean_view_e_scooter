import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  void initState() {
    super.initState();

    // Initialize the fade animation controller
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Slide animation for the text
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start from bottom
      end: Offset.zero, // End at original position
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Button scale animation
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _buttonAnimation = CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeInOut,
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _buttonController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _buttonController.dispose();
    super.dispose();
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
                const SizedBox(height: 76), // Space from top

                // Fade-in animation for the logo image
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: 100,
                    height: 80,
                    child: Image.asset('assets/images/e_bikeLogo.png'),
                  ),
                ),
                const SizedBox(height: 20),

                // Welcome text with slide-in animation
                SlideTransition(
                  position: _slideAnimation,
                  child: const Text(
                    'Welcome',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      height: 1.75,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Email Input
                _buildInputField(
                  context,
                  label: 'Email',
                  hintText: 'Enter your email',
                  isPassword: false,
                ),
                const SizedBox(height: 20),

                // Password Input
                _buildInputField(
                  context,
                  label: 'Password',
                  hintText: 'Enter your password',
                  isPassword: true,
                ),
                const SizedBox(height: 20),

                // // Confirm Password Input
                // _buildInputField(
                //   context,
                //   label: 'Confirm Password',
                //   hintText: 'Re-enter your password',
                //   isPassword: true,
                // ),
                //const SizedBox(height: 40),

                // Don't have an account text
                GestureDetector(
                  onTap: () {
                    Get.offNamed('/signup');
                  },
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Sign Up Button with scale animation
                ScaleTransition(
                  scale: _buttonAnimation,
                  child: _buildSignUpButton(),
                ),
                const SizedBox(height: 10), // Space before social icons
                const Text(
                  "OR",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                // Social Media Icons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon('assets/icons/google.png', () {
                      // Handle Google sign-up
                    }),
                    const SizedBox(width: 30), // Spacing between icons
                    _buildSocialIcon('assets/icons/facebook.png', () {
                      // Handle Facebook sign-up
                    }),
                    const SizedBox(width: 30), // Spacing between icons
                    _buildSocialIcon('assets/icons/instagram.png', () {
                      // Handle Instagram sign-up
                    }),
                    const SizedBox(width: 30), // Spacing between icons
                    _buildSocialIcon('assets/icons/twitter.png', () {
                      // Handle Twitter sign-up
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context,
      {required String label, required String hintText, required bool isPassword}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),

        // Input field
        Container(
          width: 350,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF00E276), width: 2),
          ),
          child: TextField(
            obscureText: isPassword,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: () {
        // Add your sign-up logic here
        Get.offNamed('/login'); // Navigate to login after sign-up
      },
      child: Container(
        width: 200,
        height: 70,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [Color(0xFF00E276), Color(0xFF007A3D)],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          color: const Color(0xFF00E276),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'Sign Up',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        assetPath,
        width: 30, // Set the size of the icons
        height: 30,
      ),
    );
  }
}

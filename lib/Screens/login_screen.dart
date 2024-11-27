import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  late AnimationController _buttonController;
  late Animation<double> _buttonAnimation;

  bool _hasEmailError = false; // State variable for email error
  bool _hasPasswordError = false; // State variable for password error
  String _email = ''; // To store user input for email
  String _password = ''; // To store user input for password

  bool isValid = false;
  bool isAdmin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize FirebaseAuth
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

  final List<Map<String, String>> validCredentials = [
    {"email": "oceanview@escooter.com", "password": "ocean123"},
    {"email": "adminhamid@escooter.com", "password": "admin123"}, // Add admin credentials here
    // Add more valid credentials as needed
  ];

  void _validateInputs() async {
    setState(() {
      _hasEmailError = false;
      _hasPasswordError = false;

      if (_email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_email)) {
        _hasEmailError = true;
      }
      if (_password.isEmpty || _password.length < 6) {
        _hasPasswordError = true;
      }
    });
    // Identify admin by email
    if (_email == "adminhamid@escooter.com" && _password == "admin123") {
      isAdmin = true;
    }
    // Navigate based on user type
    if (isAdmin == true) {
      Get.offNamed('/adminPanel'); // Navigate to admin panel
    } else {
      if (!_hasEmailError && !_hasPasswordError) {
        try {
          UserCredential userCredential = await _auth
              .signInWithEmailAndPassword(
            email: _email,
            password: _password,
          );
          Get.offNamed('/home'); // Navigate to user home

        } catch (e) {
          setState(() {
            _hasEmailError = true;
            _hasPasswordError = true;
          });
        }
      }
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
                const SizedBox(height: 76), // Space from top

                // Fade-in animation for the logo image
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: 100,
                    height: 80,
                    child: Image.asset('assets/images/e_bikeLogo.png'),
                  ),
                ),
                const SizedBox(height: 20),

                // Welcome text with slide-in animation
                SlideTransition(
                  position: _slideAnimation,
                  child: Text(
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
                  hasError: _hasEmailError, // Pass email error state
                  onChanged: (value) {
                    _email = value; // Store email input
                  },
                ),
                const SizedBox(height: 20),

                // Password Input
                _buildInputField(
                  context,
                  label: 'Password',
                  hintText: 'Enter your password',
                  isPassword: true,
                  hasError: _hasPasswordError, // Pass password error state
                  onChanged: (value) {
                    _password = value; // Store password input
                  },
                ),
                const SizedBox(height: 40),

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

                // Sign In Button with scale animation
                ScaleTransition(
                  scale: _buttonAnimation,
                  child: _buildSignInButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context,
      {required String label, required String hintText, required bool isPassword, required bool hasError, required Function(String) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: hasError ? Colors.red : Colors.white, // Change label color based on error state
          ),
        ),
        const SizedBox(height: 10),

        // Input field
        Container(
          width: 350,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: hasError ? Colors.red : Color(0xFF00E276), width: 2), // Change border color based on error state
          ),
          child: TextField(
            obscureText: isPassword,
            style: TextStyle(color: Colors.white),
            onChanged: onChanged, // Capture input changes
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return GestureDetector(
      onTap: () {
        _validateInputs(); // Call validation on tap
      },
      child: Container(
        width: 200,
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFF00E276), // Green background
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          'Sign In',
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
}

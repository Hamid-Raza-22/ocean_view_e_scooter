import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_view_e_scooters/Designs/arrow_painter.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  GetStartedPageState createState() => GetStartedPageState();
}

class GetStartedPageState extends State<GetStartedPage> with TickerProviderStateMixin {

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

    // Slide animation for text
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
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: const Text(
          'Ocean View E-Scooters',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.black, // Ensure the app bar matches the background
        elevation: 0, // Remove app bar shadow for a clean look
        centerTitle: true, // Centers the title in the AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40), // Space from top

              // Fade-in animation for the first image (e-bike logo)
              FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  'assets/images/e_bikeLogo.png', // Replace with your image
                  width: 100.0,
                  height: 80.0,
                ),
              ),

              const SizedBox(height: 40), // Spacing between images

              // Fade-in animation for the second image (bike image)
              FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  'assets/images/e_bike.png', // Replace with your second image
                  width: MediaQuery.of(context).size.width * 0.9, // Make it responsive
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 10), // Space before the text

              // Slide-in animation for the "Rent an E-Scooter" Text
              SlideTransition(
                position: _slideAnimation,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Rent an E-', // First part of the text
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Scooter', // Second part of the text
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00F27E),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30), // Spacing before button

              // Scale animation for "Get Started" button
              ScaleTransition(
                scale: _buttonAnimation,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to LoginScreen when tapped
                    Get.offNamed('/login');
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // Rectangle Button with improved layout and padding
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding for balance
                        width: MediaQuery.of(context).size.width * 0.9, // Make button responsive
                        height: 68.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00F27E), // Background color (#00F27E)
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(40.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15), // Softer shadow for better appearance
                              offset: const Offset(0, 4), // Subtle downward shadow for depth
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Ellipse with arrow
                              Container(
                                width: MediaQuery.of(context).size.width * 0.12, // Responsive ellipse size
                                height: MediaQuery.of(context).size.width * 0.12,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0B0230), // Background color for the ellipse
                                  shape: BoxShape.circle, // Makes the container a circle
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(0.8), // Orange shadow with some opacity
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: const Offset(1, 1), // Shadow positioning
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: CustomPaint(
                                    painter: ArrowPainter(), // Custom arrow painter
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.05, // Responsive arrow size
                                      height: MediaQuery.of(context).size.width * 0.05,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              // "Get Started" Text
                              Text(
                                'Get Started...',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: MediaQuery.of(context).size.width * 0.07, // Responsive font size
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40), // Space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}

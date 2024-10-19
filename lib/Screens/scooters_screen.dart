import 'dart:ui';

import 'package:flutter/material.dart';

class ScootersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Scooters',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: screenHeight * 0.08,
      ),
      body: Stack(
        children: [
          // Background Rectangle with Gradient and Blur
          Positioned(
            top: screenHeight * 0.25, // Adjust based on screen height
            left: screenWidth * 0.3, // Adjust based on screen width
            child: Transform.rotate(
              angle: -36.83 * 3.14159 / 180, // Convert degrees to radians
              child: Container(
                width: screenWidth * 0.85, // Adjust the width of the rectangle
                height: screenHeight * 0.6, // Adjust the height of the rectangle
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(0, 242, 126, 0.72),
                      Color.fromRGBO(0, 232, 65, 0.9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20), // Rounded corners for a modern look
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Apply blur effect
                  child: Container(
                    color: Colors.transparent, // Transparency to let gradient show
                  ),
                ),
              ),
            ),
          ),

          // Main Content
          Column(
            children: [
              // Image Section
              Container(
                height: screenHeight * 0.32,
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.03,
                ),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black.withOpacity(0.6), width: 1.5),
                  // borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/orangeEBike.png',
                    fit: BoxFit.cover,
                    //height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),

              // Information and Pricing Section
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(53, 63, 84, 0.7),
                        Color.fromRGBO(34, 40, 52, 0.8),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.03), // Balanced top spacing
                        Text(
                          'GT Sport',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: screenWidth * 0.065,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Text(
                          'The E-TWOW GT Line Scooters are high-performance electric scooters designed for urban commuters seeking speed, convenience, and eco-friendly travel.',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: screenWidth * 0.033,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.85),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: screenWidth * 0.10,
                            height: screenWidth * 0.12,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF484C),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 6,
                                  offset: Offset(1, 3),
                                ),
                              ],
                            ),
                            child: Icon(Icons.battery_3_bar_sharp, color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '0.03 PKR per MIN',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,

                                    ),
                                  ),

                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    'Unlock fee',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Text(
                                    'PKR 1.00',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: screenWidth * 0.055,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.withOpacity(1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                    side: BorderSide(
                                        color: Colors.white.withOpacity(0.6), width: 1),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.06, vertical: screenHeight * 0.015),
                                ),
                                onPressed: () {
                                  // Action for Unlock Now
                                },
                                child: Text(
                                  'Unlock Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth * 0.0295,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

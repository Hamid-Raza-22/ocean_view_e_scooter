import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_view_e_scooters/Utilities/global_variables.dart';
import 'Components/custom_button.dart';
import 'Components/custom_manu_option.dart';

class ViewProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white.withOpacity(0.8)),
            onPressed: () => Get.offNamed("/home"),
          ),

          title: const Text(
            'View Profile',
            style: TextStyle(color: Colors.white,),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CustomButton(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.5,
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.25,
                height: 50,
                icon: Icons.edit,
                iconSize: 16,
                iconColor: Colors.black,
                buttonText: 'Edit',
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                gradientColors: const [buttonColorGreen, buttonColorGreen],
                // Custom gradient
                onTap: () {
                  debugPrint("Navigating to Past Promo Page");
                  Get.offNamed('/editProfile');
                },
                borderRadius: 15.0,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    offset: Offset(0, 5),
                    blurRadius: 10,

                  ),
                ],
              ),
            )
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
       child:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade800,
                ),
                child: ClipOval(
                  child: Image.asset(
                    hamidImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Matt Scott',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 1),
            const Text(
              '+27 (63) 833 9927',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 1), // Space between phone number and email

            // Email Address
            const Text(
              'hamidraza.engr@gmail.com',
              // Replace with dynamic email if needed
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 40),
            CustomManuOption(
              title: 'Account Settings',
              onTap: () => Navigator.pushNamed(context, '/accountSettings'),
            ),
            CustomManuOption(
              title: 'Ride Agreement',
              onTap: () => Navigator.pushNamed(context, '/rideAgreement'),
            ),
            CustomManuOption(
              title: 'Terms and Conditions',
              onTap: () => Navigator.pushNamed(context, '/termsConditions'),
            ),
            CustomManuOption(
              title: 'Privacy Policy',
              onTap: () => Navigator.pushNamed(context, '/privacyPolicy'),
            ),
          ],
        ),
      ),)
    );
  }
}

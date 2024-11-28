import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_view_e_scooters/Views/CustomWidgets/custom_appbar.dart';
import '../Utilities/global_variables.dart';
import 'Components/custom_button.dart';
import 'Components/custom_editable_menu_option.dart';
import 'Components/custom_editable_phone.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:CustomAppBar(
        title: 'Edit Profile',
        onBackPressed: () => Get.offNamed('/viewProfile'),
      ),
      body:
      SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(

          children: [
            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  const SizedBox(height: 40),
                  CustomEditableMenuOption(
                    label: 'Account Name',
                    initialValue: 'John Doe',
                    onChanged: (value) {
                      print('Account Name updated to: $value');
                    },
                  ),
                  CustomEditableMenuOption(
                    label: 'Email Address',
                    initialValue: 'user@example.com',
                    onChanged: (value) {
                      print('Email Address updated to: $value');
                    },
                  ),
                  CustomEditablePhoneNumberOption(
                    label: 'Phone Number',
                    initialValue: '+27 (63) 833 9927',
                    onChanged: (value) {
                      if (kDebugMode) {
                        print('Phone Number updated to: $value');
                      }
                    },
                  ),
                ],
              ),
            ),),
            CustomButton(
              top: MediaQuery.of(context).size.height * 0.8,
              left: MediaQuery.of(context).size.width * 0.05,
              width: MediaQuery.of(context).size.width * 0.9,
              height: 55,
              buttonText: 'CONTINUE',
              // icon: Icons.edit,
              // iconSize: 16,
              // iconColor: Colors.white,
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              gradientColors: const [buttonColorGreen, buttonColorGreen], // Custom gradient
              onTap: () {
                debugPrint("Navigating to Past Promo Page");
                Get.offNamed('/viewProfile');
              },
              borderRadius: 15.0,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  offset: Offset(0,5),
                  blurRadius: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

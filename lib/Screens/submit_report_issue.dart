import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_view_e_scooters/Views/CustomWidgets/custom_appbar.dart';
import '../Utilities/global_variables.dart';
import 'Components/custom_button.dart';
import 'Components/custom_editable_menu_option.dart';
import 'Components/custom_editable_phone.dart';

class SubmitReportIssue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:CustomAppBar(
        title: 'Submit Report Issue',
        onBackPressed: () => Get.offNamed('/reportIssues'),
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

                    const SizedBox(height: 40),
                    CustomEditableMenuOption(
                      width: MediaQuery.of(context).size.width * 0.9,
                      left: MediaQuery.of(context).size.width * 0.05,

                      height: 80,
                      label: 'Scan a vehicle or type its ID here',
                      initialValue: '',
                      onChanged: (value) {
                        print('Account Name updated to: $value');
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity, // Ensures full width
                      child: Text(
                        "Describe the Issue",
                        textAlign: TextAlign.left, // Align text to the left
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    CustomEditableMenuOption(
                      bottom: 100,
                      height: 200,
                      right: 40,
                      width: MediaQuery.of(context).size.width * 0.9,

                      label: 'Enter your comments',
                      initialValue: '',
                      onChanged: (value) {
                        print('Comments updated to: $value');
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
              buttonText: 'SUBMIT',
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

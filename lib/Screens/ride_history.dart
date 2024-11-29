import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_view_e_scooters/Views/CustomWidgets/custom_appbar.dart';
import '../Services/PayFast/payfast.dart';
import 'Components/PaymentForm.dart';
import 'Components/custom_button.dart';

class RideHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Ride History',
        onBackPressed: () => Get.offNamed('/home'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
              children: [
                const SizedBox(height: 1),
                SizedBox(
                  width: double.infinity, // Ensures full width
                  child: Text(
                    "No Record",
                    textAlign: TextAlign.center, // Align text to the center
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: double.infinity, // Ensures full width
                  child: Text(
                    "Please take a ride to start to see your stats",
                    textAlign: TextAlign.center, // Align text to the center
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_view_e_scooters/Views/CustomWidgets/custom_appbar.dart';
import '../Services/PayFast/payfast.dart';
import 'Components/PaymentForm.dart';
import 'Components/custom_button.dart';


class PaymentMethods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:CustomAppBar(
        title: 'Payments',
        onBackPressed: () => Get.offNamed('/home'),
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

                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity, // Ensures full width
                      child: Text(
                        "Payment Methods",
                        textAlign: TextAlign.left, // Align text to the left
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    CustomButton(
                      top: MediaQuery.of(context).size.height * 0.8,
                      left: MediaQuery.of(context).size.width * 0.05,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 55,
                      buttonText: 'Add Payment Method',
                      icon: Icons.add,
                      iconSize: 20,
                      iconColor: Colors.greenAccent,
                      spacing:10,
                      iconPosition: IconPosition.left,
                      textAlign: TextAlign.start,
                      textStyle: const TextStyle(

                        color: Colors.greenAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      gradientColors: const [Colors.black, Colors.black], // Custom gradient
                      onTap: () async {
                        debugPrint("Opening PayFast for payment");

                       // await showPaymentDetailsBottomSheet(context);
                        //await launchPayFastPayment();  // Open PayFast payment page
                        showStripeStyleBottomSheet(context);  // Open bottom sheet for payment details

                      },
                      borderRadius: 15.0,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0,5),
                          blurRadius: 10,
                        ),
                      ],

                    ),

                  ],
                ),
              ),),
           CustomButton(
              top: MediaQuery.of(context).size.height * 0.8,
              left: MediaQuery.of(context).size.width * 0.05,
              width: MediaQuery.of(context).size.width * 0.9,
              height: 55,
              buttonText: 'Transaction History',
              icon: Icons.arrow_forward_ios_rounded,
              iconSize: 20,
              iconColor: Colors.black,
              spacing: 25,
              iconPosition: IconPosition.right,
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              gradientColors: const [Colors.white, Colors.white], // Custom gradient
              onTap: () {
                debugPrint("Navigating to Past Promo Page");
                Get.offNamed('/transactionHistory');
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

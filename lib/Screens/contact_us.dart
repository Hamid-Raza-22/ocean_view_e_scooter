import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ocean_view_e_scooters/Views/CustomWidgets/custom_appbar.dart';
import '../Utilities/global_variables.dart';
import '../Utilities/global_variables.dart';
import '../Utilities/global_variables.dart';
import 'Components/custom_button.dart';
import 'Components/custom_editable_menu_option.dart';
import 'Components/custom_editable_phone.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Contact Us',
        onBackPressed: () => Get.offNamed('/help'),
      ),
      body:
      SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Stack(

          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: Image.asset(
                        eBikeLogo,
                        // Replace with your image
                        width: 100.0,
                        height: 100.0,
                      ),

                    ),
                    const SizedBox(height: 70),
                    buildCustomButton(
                      context: context,
                      buttonText: 'support@oceanviewscooter.com',
                      icon: Icons.mail_outline_rounded,
                      gradientColors: [
                        Colors.grey.shade200,
                        Colors.grey.shade200
                      ],

                      onTap: () => Get.offNamed('/contactUS'),
                    ),
                    const SizedBox(height: 50),
                    buildCustomButton(
                      context: context,
                      buttonText: '+27 (63)8339927',
                      icon: Icons.phone,
                      gradientColors: [
                        Colors.grey.shade200,
                        Colors.grey.shade200
                      ],

                      onTap: () => Get.offNamed('/contactUS'),
                    ),
                    const SizedBox(height: 50),
                    buildCustomButton(
                      context: context,
                      buttonText: 'Contact us on Whatsapp',
                      icon: FontAwesomeIcons.whatsapp,
                      iconColor: Colors.green,

                      gradientColors: [
                        Colors.grey.shade200,
                        Colors.grey.shade200
                      ],

                      onTap: () => Get.offNamed('/contactUS'),
                    ),
                  ],
                ),
              ),),

          ],
        ),
      ),
    );
  }
    CustomButton buildCustomButton({
      required BuildContext context,
      required String buttonText,
      required IconData icon,
      required VoidCallback onTap,
      Color? iconColor,
      IconPosition iconPosition = IconPosition.left,
      List<Color> gradientColors = const [Colors.grey, Colors.grey],

    }) {
      return CustomButton(

        width: MediaQuery.of(context).size.width * 1.2,
        height: MediaQuery.of(context).size.height* 0.09,
        buttonText: buttonText,
        icon: icon,

        iconSize: 25,
        iconColor: Colors.black,
        iconPosition: iconPosition,
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        gradientColors: gradientColors,
        onTap: onTap,
        borderRadius: 15.0,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            offset: const Offset(0, 5),
            blurRadius: 10,
          ),
        ],
        iconBackgroundColor: Colors.white, // New parameter
      );
  }
}

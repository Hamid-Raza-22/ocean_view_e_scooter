import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_view_e_scooters/Utilities/global_variables.dart';
import '../Views/CustomWidgets/custom_appbar.dart';
import 'Components/custom_button.dart';
import 'Components/custom_manu_option.dart';

class ReportIssues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Report Issues',
        onBackPressed: () => Get.offNamed('/home'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const SizedBox(height: 60),
            CustomManuOption(
              title: 'Problem Report',
              onTap: () => Navigator.pushNamed(context, '/accountSettings'),
            ),
            CustomManuOption(
              title: 'Suggestion',
              onTap: () => Navigator.pushNamed(context, '/rideAgreement'),
            ),
            CustomManuOption(
              title: 'Accident Report',
              onTap: () => Navigator.pushNamed(context, '/termsConditions'),
            ),
            CustomManuOption(
              title: 'Account Billing',
              onTap: () => Navigator.pushNamed(context, '/privacyPolicy'),
            ),
            CustomManuOption(
              title: 'Refund / Deposit',
              onTap: () => Navigator.pushNamed(context, '/privacyPolicy'),
            ),
            CustomManuOption(
              title: 'Request A parking Zone',
              onTap: () => Navigator.pushNamed(context, '/privacyPolicy'),
            ),
          ],
        ),
      ),
    );
  }
}

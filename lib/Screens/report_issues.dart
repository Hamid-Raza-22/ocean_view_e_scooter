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
              onTap: () => Get.offNamed('/submitReportIssues'),
            ),
            CustomManuOption(
              title: 'Suggestion',
              onTap: () => Get.offNamed('/submitReportIssues'),
            ),
            CustomManuOption(
              title: 'Accident Report',
              onTap: () => Get.offNamed('/submitReportIssues'),
            ),
            CustomManuOption(
              title: 'Account Billing',
              onTap: () => Get.offNamed('/submitReportIssues'),
            ),
            CustomManuOption(
              title: 'Refund / Deposit',
              onTap: () => Get.offNamed('/submitReportIssues'),
            ),
            CustomManuOption(
              title: 'Request A parking Zone',
              onTap: () => Get.offNamed('/submitReportIssues'),
            ),
          ],
        ),
      ),
    );
  }
}

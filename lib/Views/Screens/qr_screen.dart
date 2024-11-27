import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ViewModel/qr_viewmodel.dart';
import '../Components/qr_screen_body.dart';
import '../CustomWidgets/custom_appbar.dart'; // Import the new QrScreenBody

class QrScreen extends StatelessWidget {
  // Initialize the controller and text controller
  final QrViewModel controller = Get.put(QrViewModel());
  final TextEditingController _manualInputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Scan to Ride',
        onBackPressed: () => Get.offNamed('/getStarted'),
      ),
      body: QrScreenBody(
        controller: controller, // Pass controller to body
        manualInputController: _manualInputController, // Pass manual input controller
        focusNode: _focusNode, // Pass focus node to body
      ),
    );
  }
}

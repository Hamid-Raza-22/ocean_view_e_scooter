import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ViewModel/qr_viewmodel.dart';
import '../Components/bottom_controls.dart';
import '../Components/manual_input_field.dart';
import '../Components/qr_icon.dart';
import '../Components/qr_scanner.dart';

class QrScreenBody extends StatelessWidget {
  final QrViewModel controller;
  final TextEditingController manualInputController;
  final FocusNode focusNode;

  const QrScreenBody({
    super.key,
    required this.controller,
    required this.manualInputController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const QrIcon(),
          const SizedBox(height: 20),
          QrScanner(
            scannerController: controller.scannerController,
            onScanned: controller.setScannedCode,
          ),
          const SizedBox(height: 20),
          ManualInputField(
            controller: manualInputController,
            focusNode: focusNode,
            onSubmit: controller.setManualCode,
          ),
          const SizedBox(height: 20),
          Obx(() => BottomControls(
            isFlashOn: controller.isFlashOn.value,
            toggleFlash: controller.toggleFlash,
            onKeyboardTap: () => focusNode.requestFocus(),
            onUnlock: () {
              if (controller.scannedCode.isNotEmpty) {
                debugPrint("Scanned Code: ${controller.scannedCode.value}");
              }
            },
          )),
        ],
      ),
    );
  }
}

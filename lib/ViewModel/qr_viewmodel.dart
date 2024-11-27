import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrViewModel extends GetxController {
  var scannedCode = ''.obs; // Reactive state for scanned code
  var isFlashOn = false.obs; // Reactive state for flashlight
  final MobileScannerController scannerController = MobileScannerController();

  // Updates the scanned QR code
  void setScannedCode(String code) {
    scannedCode.value = code;
  }

  // Toggles the flashlight state
  void toggleFlash() {
    isFlashOn.value = !isFlashOn.value;
    scannerController.toggleTorch(); // MobileScannerController toggles the torch
  }

  @override
  void onClose() {
    scannerController.dispose(); // Dispose the controller when not needed
    super.onClose();
  }
  // Updates the scanned code with manual input
  void setManualCode(String manualCode) {
    if (manualCode.isNotEmpty) {
      scannedCode.value = manualCode; // Update the reactive state
    }
  }
}

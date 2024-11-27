import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScreen extends StatefulWidget {
  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final _manualInputController = TextEditingController();
  final _scrollController = ScrollController();
  final _scannerController = MobileScannerController();
  final _focusNode = FocusNode();
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_scrollToTop);
  }

  @override
  void dispose() {
    _manualInputController.dispose();
    _scrollController.dispose();
    _scannerController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_focusNode.hasFocus) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _scannerController.toggleTorch();
    });
  }

  void _handleScan(String code) {
    Get.snackbar(
      "QR Code",
      "Scanned: $code",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _handleManualEntry() {
    final code = _manualInputController.text.trim();
    if (code.isNotEmpty) {
      Get.snackbar(
        "Manual Entry",
        "Code Entered: $code",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Scan to Ride',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white.withOpacity(0.8)),
          onPressed: () => Get.offNamed('/getStarted'),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildQrIcon(),
                  const SizedBox(height: 40),
                  _buildQrScanner(),
                  const SizedBox(height: 20),
                  _buildDivider(),
                  const SizedBox(height: 20),
                  _buildDivider2(),
                  const SizedBox(height: 20),
                   _buildManualInputField(),
                  const SizedBox(height: 30),
                  _buildBottomControls(),
                ],
              ),
            ),
          ),

         // _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildQrIcon() {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.qr_code_2, size: 50, color: Colors.white),
      ),
    );
  }

  Widget _buildQrScanner() {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.8), width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: MobileScanner(
            controller: _scannerController,
            fit: BoxFit.cover,
            onDetect: (capture) {
              for (final barcode in capture.barcodes) {
                if (barcode.rawValue != null) {
                  _handleScan(barcode.rawValue!);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Text(
      'OR',
      style: TextStyle(
        fontFamily: 'Kanit',
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }
  Widget _buildDivider2() {
    return Text(
      'Enter the vehicle’s ID to unlock',
      style: TextStyle(
        fontFamily: 'Kanit',
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }

  Widget _buildManualInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _manualInputController,
        focusNode: _focusNode,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: 'Enter QR Code Manually',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(
              icon: Icons.keyboard_alt_rounded,
              onTap: () => FocusScope.of(context).requestFocus(_focusNode),
            ),
            _buildUnlockButton(),
            _buildIconButton(
              icon: _isFlashOn
                  ? Icons.flashlight_off_rounded
                  : Icons.flashlight_on_rounded,
              onTap: _toggleFlash,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _buildUnlockButton() {
    return ElevatedButton(
      onPressed: _handleManualEntry,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 45),
      ),
      child: const Text(
        'UNLOCK',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

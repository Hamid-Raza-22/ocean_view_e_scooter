import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends StatelessWidget {
  final MobileScannerController scannerController;
  final Function(String) onScanned;
  final double borderRadius;
  final Color borderColor;

  const QrScanner({
    super.key,
    required this.scannerController,
    required this.onScanned,
    this.borderRadius = 20,
    this.borderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor.withOpacity(0.8), width: 3),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: MobileScanner(
            controller: scannerController, // Bind controller here
            fit: BoxFit.cover,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  onScanned(barcode.rawValue!);
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

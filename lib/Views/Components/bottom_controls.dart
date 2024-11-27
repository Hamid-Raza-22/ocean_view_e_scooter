import 'package:flutter/material.dart';

class BottomControls extends StatelessWidget {
  final bool isFlashOn;
  final VoidCallback toggleFlash;
  final VoidCallback onKeyboardTap;
  final VoidCallback onUnlock;

  const BottomControls({
    super.key,
    required this.isFlashOn,
    required this.toggleFlash,
    required this.onKeyboardTap,
    required this.onUnlock,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onKeyboardTap,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.keyboard_alt_rounded, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: onUnlock,
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
          ),
          GestureDetector(
            onTap: toggleFlash,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFlashOn ? Icons.flashlight_off_rounded : Icons.flashlight_on_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

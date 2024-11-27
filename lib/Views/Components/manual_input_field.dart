import 'package:flutter/material.dart';

class ManualInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String) onSubmit;
  final String hintText;

  const ManualInputField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.onSubmit,
    this.hintText = 'Enter QR Code Manually',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          onSubmitted: onSubmit,
        ),
      ),
    );
  }
}

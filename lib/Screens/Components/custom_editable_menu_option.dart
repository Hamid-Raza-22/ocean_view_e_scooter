
import 'package:flutter/material.dart';

class CustomEditableMenuOption extends StatelessWidget {
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const CustomEditableMenuOption({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: initialValue);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(3, 5),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: label, // Label text will float above the text field
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

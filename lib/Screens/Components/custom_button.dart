import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;
  final dynamic buttonText;
  final TextStyle? textStyle;
  final VoidCallback onTap;
  final double borderRadius;
  final List<Color> gradientColors;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final IconData? icon; // New parameter for the icon
  final double? iconSize; // Icon size parameter
  final Color? iconColor; // Icon color parameter
  final double spacing; // Spacing between icon and text

  const CustomButton({
    super.key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.width,
    this.height,
    this.buttonText,
    required this.onTap,
    this.textStyle,
    this.borderRadius = 20.0,
    this.gradientColors = const [Color(0xFF00C853), Color(0xFF64DD17)],
    this.boxShadow,
    this.margin,
    this.padding,
    this.icon,
    this.iconSize = 24.0,
    this.iconColor,
    this.spacing = 8.0, // Default spacing
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width ?? MediaQuery.of(context).size.width * 0.9,
          height: height ?? 60.0,
          margin: margin,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: iconSize,
                    color: iconColor ?? Colors.white,
                  ),
                  SizedBox(width: spacing),
                ],
            if (buttonText != null) ...[
                Text(
                  buttonText,
                  style: textStyle ??
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                ),]
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// CustomButton(
//   top: MediaQuery.of(context).size.height * 0.8,
//   left: MediaQuery.of(context).size.width * 0.05,
//   width: MediaQuery.of(context).size.width * 0.9,
//   height: 55,
//   buttonText: 'CONTINUE',
  // icon: Icons.edit,
  // iconSize: 16,
//   // iconColor: Colors.white,
//   textStyle: const TextStyle(
//     color: Colors.black,
//     fontSize: 16,
//     fontWeight: FontWeight.bold,
//   ),
//   gradientColors: const [buttonColorGreen, buttonColorGreen], // Custom gradient
//   onTap: () {
//     debugPrint("Navigating to Past Promo Page");
//     Get.offNamed('/viewProfile');
//   },
//   borderRadius: 15.0,
//   boxShadow: [
//     BoxShadow(
//       color: Colors.blue.withOpacity(0.3),
//       offset: Offset(0,5),
//       blurRadius: 10,
//     ),
//   ],
// ),

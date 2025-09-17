import 'package:flutter/material.dart';
import 'package:ruba_sm/core/widgets/custom_texts.dart';

class CustomIconButtonNew extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Widget? icon;
  final Color borderColor;
  final double borderWidth;
  final double verticalPadding;
  final double fontSize;
  final FontWeight fontWeight;
  final double? horizontalPadding;
  final Size? minSize;
  final Size? maxSize;
  final bool? isEnabled;
  final bool isLoading;
  final Color? loaderColor;

  const CustomIconButtonNew({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.icon,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.verticalPadding = 12,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.horizontalPadding,
    this.minSize,
    this.maxSize,
    this.isEnabled = true,
    this.isLoading = false,
    this.loaderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled! ? onPressed : null,
      style: ElevatedButton.styleFrom(
        minimumSize: minSize,
        maximumSize: maxSize,
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding ?? 0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor, width: borderWidth),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextIBM(
            title: text,
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontWeight,
          ),
          if (icon != null) ...[const SizedBox(width: 8), icon!],
        ],
      ),
    );
  }
}

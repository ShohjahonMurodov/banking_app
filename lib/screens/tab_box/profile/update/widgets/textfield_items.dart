import 'package:banking_app/utils/app_colors.dart';
import 'package:banking_app/utils/size_utils.dart';
import 'package:flutter/material.dart';

class TextFieldItems extends StatelessWidget {
  const TextFieldItems({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: AppColors.c_7F8192,
        fontSize: 16.w,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: AppColors.c_7F8192,
          fontSize: 14.w,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: AppColors.c_F5F6FA,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

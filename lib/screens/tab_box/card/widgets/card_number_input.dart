import 'package:banking_app/utils/app_colors.dart';
import 'package:banking_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardNumberInput extends StatefulWidget {
  const CardNumberInput({
    super.key,
    required this.controller,
    this.maskTextInputFormatter,
    required this.focusNode,
  });

  final MaskTextInputFormatter? maskTextInputFormatter;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  State<CardNumberInput> createState() => _CardNumberInputState();
}

class _CardNumberInputState extends State<CardNumberInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      onChanged: (value) {
        if (value.replaceAll(" ", "").length == 16) {
          widget.focusNode.unfocus();
        }
        setState(() {});
      },
      inputFormatters: widget.maskTextInputFormatter != null
          ? [widget.maskTextInputFormatter!]
          : null,
      controller: widget.controller,
      style: TextStyle(
        color: AppColors.c_7F8192,
        fontSize: 16.w,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: "Card Number",
        hintStyle: TextStyle(
          color: AppColors.c_7F8192,
          fontSize: 14.w,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: const Color(0xFF23265A),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: const Color(0xFF858BE9),
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: const Color(0xFF858BE9),
            width: 1.w,
          ),
        ),
      ),
    );
  }
}

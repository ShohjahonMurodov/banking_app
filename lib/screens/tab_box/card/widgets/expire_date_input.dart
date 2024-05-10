import 'package:banking_app/utils/app_colors.dart';
import 'package:banking_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ExpireDateInput extends StatefulWidget {
  const ExpireDateInput({
    super.key,
    required this.controller,
    this.maskTextInputFormatter,
    required this.focusNode,
  });

  final MaskTextInputFormatter? maskTextInputFormatter;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  State<ExpireDateInput> createState() => _ExpireDateInputState();
}

class _ExpireDateInputState extends State<ExpireDateInput> {
  @override
  void initState() {
    widget.controller.addListener(() {});
    super.initState();
  }

  _validateExpireDate(String dateText) {
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year % 100;

    List<String> list = dateText.split("/");

    int monthNumber = int.parse(list[0]);
    int yearNumber = int.parse(list[1]);

    if (monthNumber > 12) {
      widget.controller.clear();
      return;
    }

    if (yearNumber < currentYear) {
      widget.controller.clear();
      return;
    }

    if ((monthNumber < currentMonth) && yearNumber == currentYear) {
      widget.controller.clear();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      onChanged: (value) {
        if (value.length == 5) {
          _validateExpireDate(value);
          widget.focusNode.unfocus();
        }
        setState(() {});
      },
      inputFormatters: [widget.maskTextInputFormatter!],
      controller: widget.controller,
      style: TextStyle(
        color: AppColors.c_7F8192,
        fontSize: 16.w,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: "Expire Date",
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

import 'package:banking_app/utils/app_colors.dart';
import 'package:banking_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AmountInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<double> amount;

  const AmountInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.amount,
  });

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
      ],
      onChanged: (v) {
        int amountInt = int.parse(v);
        widget.amount.call(double.parse(v));
        String amountText = NumberFormat.decimalPattern("uz").format(amountInt);
        debugPrint("AMOUNT:$amountText");
        widget.controller.value = TextEditingValue(text: amountText);
        setState(() {});
      },
      decoration: InputDecoration(
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  widget.controller.clear();
                },
                icon: const Icon(Icons.clear),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        hintText: "Summa (UZS)",
        hintStyle: TextStyle(color: AppColors.white, fontSize: 24.w),
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.w, color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.w, color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(color: AppColors.white, fontSize: 24.w),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.start,
    );
  }
}

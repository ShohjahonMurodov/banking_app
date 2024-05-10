import 'package:banking_app/screens/tab_box/card/widgets/card_number_input.dart';
import 'package:banking_app/utils/app_colors.dart';
import 'package:banking_app/utils/size_utils.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TextEditingController cardNumberController = TextEditingController();
  String amount = "";

  @override
  Widget build(BuildContext context) {
    Widget buttonItems({required String title}) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 37.w,
            vertical: 25.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: () {
          amount += title;
          setState(() {});
        },
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.w,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF121433),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          160.getH(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: CardNumberInput(
              controller: cardNumberController,
              focusNode: FocusNode(),
            ),
          ),
          40.getH(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: TextField(
              enabled: false,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 22.w,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: amount.isEmpty ? "Enter an amount" : amount,
                hintStyle: TextStyle(
                  color: AppColors.white,
                  fontSize: 22.w,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF2567F9),
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Send",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.w,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          30.getH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonItems(title: "1"),
              buttonItems(title: "2"),
              buttonItems(title: "3"),
            ],
          ),
          25.getH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonItems(title: "4"),
              buttonItems(title: "5"),
              buttonItems(title: "6"),
            ],
          ),
          25.getH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonItems(title: "7"),
              buttonItems(title: "8"),
              buttonItems(title: "9"),
            ],
          ),
          25.getH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonItems(title: ""),
              buttonItems(title: "0  "),
              IconButton(
                onPressed: () {
                  amount = amount.substring(0, amount.length - 1);
                  setState(() {});
                },
                icon: Icon(
                  Icons.backspace,
                  size: 30.w,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

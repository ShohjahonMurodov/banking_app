import 'package:banking_app/blocs/card/user_card_bloc.dart';
import 'package:banking_app/blocs/card/user_card_state.dart';
import 'package:banking_app/blocs/transaction/transaction_state.dart';
import 'package:banking_app/data/models/card_model.dart';
import 'package:banking_app/screens/tab_box/card/widgets/card_number_input.dart';
import 'package:banking_app/screens/transaction/widgets/amount_input.dart';
import 'package:banking_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/transaction/transaction_bloc.dart';
import '../../blocs/transaction/transaction_event.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key, required this.cardModel});

  final CardModel cardModel;

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  CardModel senderCard = CardModel.initial();
  CardModel receiverCard = CardModel.initial();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    senderCard = widget.cardModel;
    List<CardModel> cards = context.read<UserCardsBloc>().state.activeCards;
    cardNumberController.addListener(
      () {
        String receiverCardNumber =
            cardNumberController.text.replaceAll(" ", "");
        if (receiverCardNumber.length == 16) {
          for (var element in cards) {
            if (element.cardNumber == receiverCardNumber &&
                senderCard.cardNumber != receiverCardNumber) {
              receiverCard = element;

              context
                  .read<TransactionBloc>()
                  .add(SetReceiverCardEvent(cardModel: receiverCard));
              context
                  .read<TransactionBloc>()
                  .add(SetSenderCardEvent(cardModel: senderCard));

              setState(() {});
              break;
            } else {
              receiverCard = CardModel.initial();
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF121433),
      body: BlocBuilder<UserCardsBloc, UserCardsState>(
        builder: (context, state) {
          return Column(
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
                child: AmountInput(
                  controller: amountController,
                  focusNode: FocusNode(),
                  amount: (amount) {
                    if (amount >= 1000) {
                      context
                          .read<TransactionBloc>()
                          .add(SetAmountEvent(amount: amount));
                    }
                  },
                ),
              ),
              BlocListener<TransactionBloc, TransactionState>(
                listener: (context, state) {
                  if (state.statusMessage == "not_validated") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Ma'lumotlar xato!"),
                      ),
                    );
                  } else if (state.statusMessage == "validated") {
                    Navigator.pop(context);
                  }
                },
                child: Container(
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
                    onPressed: () {
                      context
                          .read<TransactionBloc>()
                          .add(CheckValidationEvent());
                    },
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
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:banking_app/blocs/auth/auth_state.dart';
import 'package:banking_app/blocs/transaction/transaction_event.dart';
import 'package:banking_app/blocs/transaction/transaction_state.dart';
import 'package:banking_app/data/models/card_model.dart';
import 'package:banking_app/data/models/network_response.dart';
import 'package:banking_app/data/repository/card_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({required this.cardRepository})
      : super(TransactionState(
          receiverCard: CardModel.initial(),
          senderCard: CardModel.initial(),
          amount: 0.0,
          formStatus: FormStatus.pure,
          errorMessage: "",
          statusMessage: "",
        )) {
    on<SetAmountEvent>(_setAmount);
    on<SetReceiverCardEvent>(_setReceiverCard);
    on<SetSenderCardEvent>(_setSenderCard);
    on<CheckValidationEvent>(_checkValidation);
    on<RunTransactionEvent>(_runTransaction);
  }

  final CardRepository cardRepository;

  _setAmount(SetAmountEvent event, emit) {
    emit(state.copyWith(amount: event.amount));
  }

  _setReceiverCard(SetReceiverCardEvent event, emit) {
    emit(state.copyWith(receiverCard: event.cardModel));
  }

  _setSenderCard(SetSenderCardEvent event, emit) {
    emit(state.copyWith(senderCard: event.cardModel));
  }

  _checkValidation(CheckValidationEvent event, emit) {
    if (state.amount < 1000 ||
        state.receiverCard.cardNumber.length != 16 ||
        state.senderCard.balance < 1000 ||
        state.senderCard.balance < state.amount) {
      emit(state.copyWith(statusMessage: "not_validated"));
      return;
    }
    emit(state.copyWith(statusMessage: "validated"));
  }

  _runTransaction(RunTransactionEvent event, emit) async {
    CardModel cardReceiver = state.receiverCard;
    CardModel cardSender = state.senderCard;
    cardSender =
        cardSender.copyWith(balance: cardSender.balance - state.amount);
    cardReceiver =
        cardReceiver.copyWith(balance: cardReceiver.balance + state.amount);
    bool isUpdated1 = await _updateCard(cardSender);
    bool isUpdated2 = await _updateCard(cardReceiver);
    if (isUpdated1 && isUpdated2) {
      emit(
        state.copyWith(
          statusMessage: "transaction_success",
          formStatus: FormStatus.success,
        ),
      );
    }
  }

  Future<bool> _updateCard(CardModel cardModel) async {
    NetworkResponse networkResponse =
        await cardRepository.updateCard(cardModel);
    if (networkResponse.errorText.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

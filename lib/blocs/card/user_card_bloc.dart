import 'package:banking_app/blocs/auth/auth_state.dart';
import 'package:banking_app/blocs/card/user_card_event.dart';
import 'package:banking_app/blocs/card/user_card_state.dart';
import 'package:banking_app/data/models/card_model.dart';
import 'package:banking_app/data/models/network_response.dart';
import 'package:banking_app/data/repository/card_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCardsBloc extends Bloc<UserCardsEvent, UserCardsState> {
  UserCardsBloc({required this.cardRepository})
      : super(
          const UserCardsState(
            userCards: [],
            userCardsDB: [],
            activeCards: [],
            formStatus: FormStatus.pure,
            errorMessage: "",
            statusMessage: "",
          ),
        ) {
    on<AddCardEvent>(_addCard);
    on<UpdateCardEvent>(_updateCard);
    on<DeleteCardEvent>(_deleteCard);
    on<GetCardsByUserIdEvent>(_listenCard);
    on<GetActiveCards>(_listenActiveCard);
    on<GetCardsDatabaseEvent>(_listenCardDatabase);
  }

  final CardRepository cardRepository;

  _addCard(AddCardEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await cardRepository.addCard(event.cardModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
          formStatus: FormStatus.success, statusMessage: "added"));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText));
    }
  }

  _updateCard(UpdateCardEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await cardRepository.updateCard(event.cardModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText));
    }
  }

  _deleteCard(DeleteCardEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await cardRepository.deleteCard(event.cardDocId);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText));
    }
  }

  _listenActiveCard(GetActiveCards event, Emitter emit) async {
    await emit.onEach(
      cardRepository.getActiveCards(),
      onData: (List<CardModel> activeCards) {
        emit(state.copyWith(activeCards: activeCards));
      },
    );
  }

  _listenCard(GetCardsByUserIdEvent event, Emitter emit) async {
    await emit.onEach(
      cardRepository.getCardsByUserId(event.userId),
      onData: (List<CardModel> userCards) {
        emit(
          state.copyWith(userCards: userCards),
        );
      },
    );
  }

  _listenCardDatabase(GetCardsDatabaseEvent event, Emitter emit) async {
    await emit.onEach(
      cardRepository.getCardsDatabase(),
      onData: (List<CardModel> userCards) {
        emit(
          state.copyWith(userCardsDB: userCards),
        );
      },
    );
  }
}

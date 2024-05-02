import 'package:banking_app/blocs/auth/auth_event.dart';
import 'package:banking_app/blocs/auth/auth_state.dart';
import 'package:banking_app/data/models/network_response.dart';
import 'package:banking_app/data/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository})
      : super(
          const AuthState(
            errorMessage: "",
            statusMessage: "",
            formStatus: FormStatus.pure,
          ),
        ) {
    on<LoginUserEvent>(_loginUser);
    on<CheckAuthenticationEvent>(_checkAuthentication);
    on<LogOutEvent>(_logOutUser);
    on<RegisterUserEvent>(_registerUser);
    on<SignInWithGoogleEvent>(_googleSignIn);
  }

  Future<void> _loginUser(LoginUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await authRepository.loginWithEmailAndPassword(
      email: "${event.username}@gmail.com",
      password: event.password,
    );

    if (networkResponse.errorText.isEmpty) {
      // debugPrint("Qonday===============");
      emit(state.copyWith(formStatus: FormStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _checkAuthentication(CheckAuthenticationEvent event, emit) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(state.copyWith(formStatus: FormStatus.unauthenticated));
    } else {
      emit(state.copyWith(formStatus: FormStatus.authenticated));
    }
  }

  _registerUser(RegisterUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await authRepository.registerWithEmailAndPassword(
      username: "${event.userModel.userName}@gmail.com",
      password: event.userModel.passwordName,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.authenticated));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText));
    }
  }

  _logOutUser(LogOutEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse = await authRepository.logOutUser();

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.authenticated));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText));
    }
  }

  _googleSignIn(SignInWithGoogleEvent event, emit) async {}
}

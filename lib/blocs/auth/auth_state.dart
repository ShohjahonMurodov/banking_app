import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState(
      {required this.errorMessage,
      required this.statusMessage,
      required this.formStatus});

  final String errorMessage;
  final String statusMessage;
  final FormStatus formStatus;

  AuthState copyWith({
    String? errorMessage,
    String? statusMessage,
    FormStatus? formStatus,
  }) {
    return AuthState(
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [errorMessage, statusMessage, formStatus];
}

enum FormStatus {
  pure,
  success,
  error,
  loading,
  unauthenticated,
  authenticated,
}

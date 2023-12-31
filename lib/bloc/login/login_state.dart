// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginResponseModel loginResponseModel;
  LoginLoaded({
    required this.loginResponseModel,
  });
}

class LoginError extends LoginState {
  final String message;
  LoginError({
    required this.message,
  });
}

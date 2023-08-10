// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfilLoading extends ProfileState {}

class ProfilLoaded extends ProfileState {
  final ProfileResponseModel profile;
  ProfilLoaded({
    required this.profile,
  });
}

class ProfilError extends ProfileState {
  final String message;
  ProfilError({
    required this.message,
  });
}

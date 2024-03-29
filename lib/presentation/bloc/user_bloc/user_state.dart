part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final User result;

  const UserLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

final class UserUpdated extends UserState {
  final String message;

  const UserUpdated({required this.message});

  @override
  List<Object> get props => [message];
}

final class UserError extends UserState {
  final String message;

  const UserError({required this.message});

  @override
  List<Object> get props => [message];
}

part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class Authenticated extends AuthState {
  final String id;
  final String token;

  const Authenticated({required this.id, required this.token});

  @override
  List<Object> get props => [id, token];
}

final class LogoutError extends AuthState {}

final class Unauthenticated extends AuthState {
  final String message;

  const Unauthenticated({required this.message});

  @override
  List<Object> get props => [message];
}

final class Registered extends AuthState {
  final String message;

  const Registered({required this.message});

  @override
  List<Object> get props => [message];
}

final class Unregistered extends AuthState {
  final String message;

  const Unregistered({required this.message});

  @override
  List<Object> get props => [message];
}

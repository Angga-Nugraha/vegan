import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecase/Auth/login.dart';
import '../../../domain/usecase/Auth/logout.dart';
import '../../../domain/usecase/Auth/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Logout logout;
  final Register register;

  AuthBloc({
    required this.login,
    required this.logout,
    required this.register,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 3));
      final result = await login.execute(event.email, event.password);

      result.fold(
        (failure) => emit(Unauthenticated(message: failure.message)),
        (data) => emit(Authenticated(id: data.id!, token: data.accessToken!)),
      );
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 3));
      final result = await logout.execute();

      result.fold(
        (failure) => null,
        (data) => emit(Unauthenticated(message: data)),
      );
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 3));

      final result = await register.execute(event.user);

      result.fold(
        (failure) => emit(Unregistered(message: failure.message)),
        (data) => emit(Registered(message: data)),
      );
    });
  }
}

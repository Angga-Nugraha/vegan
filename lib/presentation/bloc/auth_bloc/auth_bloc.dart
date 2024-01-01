import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegan/domain/usecase/Auth/login.dart';
import 'package:vegan/domain/usecase/Auth/logout.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Logout logout;

  AuthBloc({required this.login, required this.logout}) : super(AuthInitial()) {
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
  }
}

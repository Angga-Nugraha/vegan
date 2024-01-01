import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/data/utils/failure.dart';
import 'package:vegan/domain/usecase/Auth/login.dart';
import 'package:vegan/domain/usecase/Auth/logout.dart';
import 'package:vegan/presentation/bloc/auth_bloc/auth_bloc.dart';

import '../../dummy_data/object_dummy.dart';
import 'auth_bloc_test.mocks.dart';

@GenerateMocks([Login, Logout])
void main() {
  late AuthBloc authBloc;
  late MockLogin mockLogin;
  late MockLogout mockLogout;

  setUp(() {
    mockLogin = MockLogin();
    mockLogout = MockLogout();
    authBloc = AuthBloc(login: mockLogin, logout: mockLogout);
  });

  group('AuthBloc', () {
    test("should be state initial when AuthEvent initial", () {
      expect(authBloc.state, AuthInitial());
    });

    blocTest<AuthBloc, AuthState>(
      'emits Authenticated state when LoginEvent is added.',
      build: () {
        when(mockLogin.execute("email", "password"))
            .thenAnswer((_) async => const Right(tLogin));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const LoginEvent(email: "email", password: "password")),
      wait: const Duration(seconds: 3),
      expect: () => <AuthState>[
        AuthLoading(),
        Authenticated(id: tLogin.id!, token: tLogin.accessToken!)
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits Unauthenticated state when LoginEvent has error.',
      build: () {
        when(mockLogin.execute("email", "password")).thenAnswer(
            (_) async => const Left(CommonFailure("user not found")));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const LoginEvent(email: "email", password: "password")),
      wait: const Duration(seconds: 3),
      expect: () => <AuthState>[
        AuthLoading(),
        const Unauthenticated(message: 'user not found'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits Unauthenticated state when LogoutEvent is added.',
      build: () {
        when(mockLogout.execute())
            .thenAnswer((_) async => const Right("Logout success"));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      wait: const Duration(seconds: 3),
      expect: () => <AuthState>[
        AuthLoading(),
        const Unauthenticated(message: "Logout success")
      ],
    );
  });
}

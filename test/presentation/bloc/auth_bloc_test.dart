import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/data/utils/failure.dart';
import 'package:vegan/domain/usecase/Auth/login.dart';
import 'package:vegan/domain/usecase/Auth/logout.dart';
import 'package:vegan/domain/usecase/Auth/register.dart';
import 'package:vegan/presentation/bloc/auth_bloc/auth_bloc.dart';

import '../../dummy_data/object_dummy.dart';
import 'auth_bloc_test.mocks.dart';

@GenerateMocks([Login, Logout, Register])
void main() {
  late AuthBloc authBloc;
  late MockLogin mockLogin;
  late MockLogout mockLogout;
  late MockRegister mockRegister;

  setUp(() {
    mockLogin = MockLogin();
    mockLogout = MockLogout();
    mockRegister = MockRegister();
    authBloc = AuthBloc(
      login: mockLogin,
      logout: mockLogout,
      register: mockRegister,
    );
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
            (_) async => const Left(ServerFailure("user not found")));
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
    blocTest<AuthBloc, AuthState>(
      'emits LogoutError state when LogoutEvent is error.',
      build: () {
        when(mockLogout.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Something went wrong')));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      wait: const Duration(seconds: 3),
      expect: () => <AuthState>[AuthLoading(), LogoutError()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits Registered when RegisterEvent is added and success.',
      build: () {
        when(mockRegister.execute(tUserRegister)).thenAnswer(
            (_) async => const Left(ServerFailure("message error")));
        return authBloc;
      },
      wait: const Duration(seconds: 3),
      act: (bloc) => bloc.add(const RegisterEvent(user: tUserRegister)),
      expect: () => <AuthState>[
        AuthLoading(),
        const Unregistered(message: 'message error'),
      ],
    );
    blocTest<AuthBloc, AuthState>(
      'emits Unregistered when RegisterEvent is added and error.',
      build: () {
        when(mockRegister.execute(tUserRegister))
            .thenAnswer((_) async => const Right('register success'));
        return authBloc;
      },
      wait: const Duration(seconds: 3),
      act: (bloc) => bloc.add(const RegisterEvent(user: tUserRegister)),
      expect: () => <AuthState>[
        AuthLoading(),
        const Registered(message: 'register success'),
      ],
    );
  });
}

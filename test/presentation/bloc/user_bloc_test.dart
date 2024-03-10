import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/core/failure.dart';
import 'package:vegan/domain/usecase/User/change_address.dart';
import 'package:vegan/domain/usecase/User/change_password.dart';
import 'package:vegan/domain/usecase/User/get_current_user.dart';
import 'package:vegan/domain/usecase/User/update_user.dart';
import 'package:vegan/presentation/bloc/user_bloc/user_bloc.dart';

import '../../dummy_data/object_dummy.dart';
import 'user_bloc_test.mocks.dart';

@GenerateMocks([GetCurrentUser, UpdateUser, ChangePassword, ChangeAddress])
void main() {
  late UserBloc userBloc;
  late MockGetCurrentUser mockGetCurrentUser;
  late MockUpdateUser mockUpdateUser;
  late MockChangePassword mockChangePassword;
  late MockChangeAddress mockChangeAddress;

  setUp(() {
    mockGetCurrentUser = MockGetCurrentUser();
    mockUpdateUser = MockUpdateUser();
    mockChangePassword = MockChangePassword();
    mockChangeAddress = MockChangeAddress();
    userBloc = UserBloc(
      getCurrentUser: mockGetCurrentUser,
      updateUser: mockUpdateUser,
      changePassword: mockChangePassword,
      changeAddress: mockChangeAddress,
    );
  });

  group('User Bloc', () {
    blocTest<UserBloc, UserState>(
      'emit UserLoaded state if fetchCurretUser event success',
      build: () {
        when(mockGetCurrentUser.execute())
            .thenAnswer((_) async => Right(tUser));
        return userBloc;
      },
      act: (bloc) => bloc.add(const FetchCurrentUser()),
      expect: () => <UserState>[
        UserLoading(),
        UserLoaded(result: tUser),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emit UserError state if fetchCurretUser event success',
      build: () {
        when(mockGetCurrentUser.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Error')));
        return userBloc;
      },
      act: (bloc) => bloc.add(const FetchCurrentUser()),
      expect: () => <UserState>[
        UserLoading(),
        const UserError(message: 'Error'),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits UserLoaded when UpdateUserEvent is added.',
      build: () {
        when(mockUpdateUser.execute(tUserRegister))
            .thenAnswer((_) async => Right(tUser));
        return userBloc;
      },
      wait: const Duration(seconds: 3),
      act: (bloc) => bloc.add(const UpdateUserEvent(user: tUserRegister)),
      expect: () => <UserState>[
        UserLoading(),
        const UserUpdated(message: "User Updated"),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emits UserError when UpdateUserEvent is added.',
      build: () {
        when(mockUpdateUser.execute(tUserRegister))
            .thenAnswer((_) async => const Left(ServerFailure('Error')));
        return userBloc;
      },
      act: (bloc) => bloc.add(const UpdateUserEvent(user: tUserRegister)),
      wait: const Duration(seconds: 3),
      expect: () => <UserState>[
        UserLoading(),
        const UserError(message: 'Error'),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits UserUpdated when ChangePassEvent is added.',
      build: () {
        when(mockChangePassword.execute("currentPassword", "newPassword"))
            .thenAnswer((_) async => const Right("password changed"));
        return userBloc;
      },
      act: (bloc) => bloc.add(const ChangePassEvent(
          currentPassword: "currentPassword", newPassword: "newPassword")),
      wait: const Duration(seconds: 3),
      expect: () => <UserState>[
        UserLoading(),
        const UserUpdated(message: "password changed"),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emits UserLoaded when ChangeAddressEvent is added.',
      build: () {
        when(mockChangeAddress.execute(address))
            .thenAnswer((_) async => Right(tUser));
        return userBloc;
      },
      act: (bloc) => bloc.add(const ChangeAddressEvent(address: address)),
      wait: const Duration(seconds: 3),
      expect: () => <UserState>[
        UserLoading(),
        UserLoaded(result: tUser),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emits UserError when ChangeAddressEvent is added.',
      build: () {
        when(mockChangeAddress.execute(address))
            .thenAnswer((_) async => const Left(ServerFailure("Error")));
        return userBloc;
      },
      act: (bloc) => bloc.add(const ChangeAddressEvent(address: address)),
      wait: const Duration(seconds: 3),
      expect: () => <UserState>[
        UserLoading(),
        const UserError(message: "Error"),
      ],
    );
  });
}

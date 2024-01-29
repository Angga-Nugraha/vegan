import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/data/utils/failure.dart';
import 'package:vegan/domain/usecase/User/get_current_user.dart';
import 'package:vegan/presentation/bloc/user_bloc/user_bloc.dart';

import '../../dummy_data/object_dummy.dart';
import 'user_bloc_test.mocks.dart';

@GenerateMocks([GetCurrentUser])
void main() {
  late UserBloc userBloc;
  late MockGetCurrentUser mockGetCurrentUser;

  setUp(() {
    mockGetCurrentUser = MockGetCurrentUser();
    userBloc = UserBloc(getCurrentUser: mockGetCurrentUser);
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
  });
}
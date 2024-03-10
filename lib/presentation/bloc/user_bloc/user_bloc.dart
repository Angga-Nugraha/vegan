import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecase/User/change_address.dart';
import '../../../domain/usecase/User/change_password.dart';
import '../../../domain/usecase/User/get_current_user.dart';
import '../../../domain/usecase/User/update_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUser getCurrentUser;
  final UpdateUser updateUser;
  final ChangePassword changePassword;
  final ChangeAddress changeAddress;

  UserBloc(
      {required this.getCurrentUser,
      required this.changePassword,
      required this.changeAddress,
      required this.updateUser})
      : super(UserInitial()) {
    on<FetchCurrentUser>((event, emit) async {
      emit(UserLoading());

      final result = await getCurrentUser.execute();

      result.fold(
        (failure) => emit(UserError(message: failure.message)),
        (data) => emit(UserLoaded(result: data)),
      );
    });
    on<UpdateUserEvent>((event, emit) async {
      emit(UserLoading());
      await Future.delayed(const Duration(seconds: 3));
      final result = await updateUser.execute(event.user);

      result.fold(
        (failure) => emit(UserError(message: failure.message)),
        (data) => emit(const UserUpdated(message: "User Updated")),
      );
    });
    on<ChangeAddressEvent>((event, emit) async {
      emit(UserLoading());
      await Future.delayed(const Duration(seconds: 3));
      final result = await changeAddress.execute(event.address);

      result.fold(
        (failure) => emit(UserError(message: failure.message)),
        (data) => emit(UserLoaded(result: data)),
      );
    });
    on<ChangePassEvent>((event, emit) async {
      emit(UserLoading());
      await Future.delayed(const Duration(seconds: 3));
      final result = await changePassword.execute(
          event.currentPassword, event.newPassword);

      result.fold(
        (failure) => emit(UserError(message: failure.message)),
        (data) => emit(UserUpdated(message: data)),
      );

      // add(const FetchCurrentUser());
    });
  }
}

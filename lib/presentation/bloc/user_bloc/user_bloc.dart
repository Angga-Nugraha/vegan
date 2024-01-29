import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan/domain/entities/user.dart';
import 'package:vegan/domain/usecase/User/get_current_user.dart';
import 'package:vegan/domain/usecase/User/update_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUser getCurrentUser;
  final UpdateUser updateUser;

  UserBloc({required this.getCurrentUser, required this.updateUser})
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

      final result = await updateUser.execute(event.user);

      result.fold(
        (failure) => emit(UserError(message: failure.message)),
        (data) => emit(UserLoaded(result: data)),
      );
    });
  }
}

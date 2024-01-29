part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class FetchCurrentUser extends UserEvent {
  const FetchCurrentUser();

  @override
  List<Object> get props => [];
}

final class UpdateUserEvent extends UserEvent {
  final User user;

  const UpdateUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

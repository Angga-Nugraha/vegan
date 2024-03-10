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

final class ChangePassEvent extends UserEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePassEvent(
      {required this.currentPassword, required this.newPassword});

  @override
  List<Object> get props => [currentPassword, newPassword];
}

final class ChangeAddressEvent extends UserEvent {
  final Address address;
  const ChangeAddressEvent({required this.address});

  @override
  List<Object> get props => [address];
}

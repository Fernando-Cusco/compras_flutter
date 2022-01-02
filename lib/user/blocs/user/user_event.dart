part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class OnUserLogin extends UserEvent {
  final bool isCorrectCredentials;
  final bool isUserLoggedIn;
  final User user;

  const OnUserLogin(
      {required this.isCorrectCredentials,
      required this.isUserLoggedIn,
      required this.user});
}

class OnUserRegister extends UserEvent {}

class OnClientUpdate extends UserEvent {
  final Cliente cliente;

  const OnClientUpdate({required this.cliente});
}

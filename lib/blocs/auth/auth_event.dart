part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnUserAuthEvent extends AuthEvent {
  final bool isUserAuth;
  final User? user;

  const OnUserAuthEvent({required this.isUserAuth, this.user});
}

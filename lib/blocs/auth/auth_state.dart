part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool userIsAuth;
  final User? user;

  const AuthState({required this.userIsAuth, this.user});

  AuthState copyWith({bool? userIsAuth, User? user}) => AuthState(
      userIsAuth: userIsAuth ?? this.userIsAuth, user: user ?? this.user);

  @override
  List<Object> get props => [userIsAuth];
}

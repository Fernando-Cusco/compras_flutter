part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool isCorrectCredentials;
  final bool isUserLoggedIn;
  final User user;

  const UserState(
      {this.isCorrectCredentials = false,
      required this.isUserLoggedIn,
      required this.user});

  copyWith({bool? isCorrectCredentials, bool? isUserLoggedIn, User? user}) {
    return UserState(
        isCorrectCredentials: isCorrectCredentials ?? this.isCorrectCredentials,
        isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
        user: user ?? this.user);
  }

  @override
  List<Object> get props => [isCorrectCredentials, isUserLoggedIn, user];
}

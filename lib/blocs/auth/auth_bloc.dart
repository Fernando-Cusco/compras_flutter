import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_auth/service/user_auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final userAuthService = UserAuthService();
  AuthBloc() : super(const AuthState(userIsAuth: false)) {
    on<OnUserAuthEvent>((event, emit) {
      if (event.isUserAuth) {
        emit(state.copyWith(userIsAuth: event.isUserAuth, user: event.user));
      } else {
        emit(state.copyWith(userIsAuth: event.isUserAuth));
      }
    });
  }

  Future loginFacebook() async {
    final UserCredential? authFacebook = await userAuthService.loginFacebook();
    if (authFacebook != null) {
      log(authFacebook.user.toString());
      add(OnUserAuthEvent(isUserAuth: true, user: authFacebook.user));
    }
  }

  Future loginGoogle() async {
    final UserCredential? authGoogle = await userAuthService.loginGoogle();
    if (authGoogle != null) {
      log(authGoogle.user.toString());
      add(OnUserAuthEvent(isUserAuth: true, user: authGoogle.user));
    }
  }

  Future logoutAll() async {
    await userAuthService.logoutAll();
    add(const OnUserAuthEvent(isUserAuth: false));
  }

  Future getAlgo() async {
    await userAuthService.getAlgo();
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_auth/user/models/models.dart';
import 'package:user_auth/user/services/user_services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late SharedPreferences prefs;
  final UserService userService;
  UserBloc(this.userService)
      : super(UserState(
          isUserLoggedIn: false,
          user: User.empty(),
        )) {
    on<OnUserLogin>((event, emit) {
      emit(state.copyWith(
        isCorrectCredentials: event.isCorrectCredentials,
        isUserLoggedIn: event.isUserLoggedIn,
        user: event.user,
      ));
      log(state.user.id.toString());
    });
    on<OnClientUpdate>((event, emit) {
      final user = state.user;
      user.cliente = event.cliente;
      emit(state.copyWith(user: user));
    });
    initPrefs();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<User> login(String correo, String password) async {
    try {
      final user = await userService.login(correo, password);
      if (user.id == 0) {
        add(OnUserLogin(
            isCorrectCredentials: false,
            isUserLoggedIn: false,
            user: User.empty()));
        log("Credenciales incorrectas");
      } else if (user.id == -1) {
        add(OnUserLogin(
            isCorrectCredentials: false,
            isUserLoggedIn: false,
            user: User.empty()));
        log("Error");
      } else {
        add(OnUserLogin(
            isCorrectCredentials: true, isUserLoggedIn: true, user: user));
        log("Correcto");
        if (user.cliente != null) {
          add(OnClientUpdate(cliente: user.cliente!));
        }
      }
      return user;
    } catch (e) {
      add(OnUserLogin(
          isCorrectCredentials: false,
          isUserLoggedIn: false,
          user: User.empty()));
      return User.empty();
    }
  }

  Future<Message> registro(User user) async {
    return await userService.registrar(user);
  }

  void cerrarSesion() async {
    add(OnUserLogin(
        isCorrectCredentials: false,
        isUserLoggedIn: false,
        user: User.empty()));
    await prefs.clear();
  }

  Future<Message> actualizarCliente(Cliente cliente) async {
    final message = await userService.actualizarCliente(cliente);
    if (message.code == 200) {
      add(OnClientUpdate(cliente: cliente));
    } else if (message.code == -1) {
      add(OnClientUpdate(cliente: Cliente.empty()));
    }
    return message;
  }
}
// admin@admin.com

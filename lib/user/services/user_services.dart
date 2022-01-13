import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:user_auth/user/models/models.dart';
import 'package:user_auth/user/services/interceptor_cliente.dart';

class UserService {
  final Dio _dioHttp = Dio();
  final Dio _dioHttpCliente = Dio()..interceptors.add(InterceptorCLiente());
  final String _baseUrl = "http://192.168.0.109:8080/api";
  Future<User> login(String correo, String password) async {
    try {
      Response response = await _dioHttp.post('$_baseUrl/usuario/login',
          data: {'correo': correo, 'password': password});
      final user = User.fromMap(response.data);
      return user;
      // return response.data;
    } catch (e) {
      log(e.toString());
      return User.empty();
    }
  }

  Future<Message> registrar(User user) async {
    try {
      Response response =
          await _dioHttp.post('$_baseUrl/usuario/registro', data: user.toMap());
      final message = Message.fromMap(response.data);
      return message;
    } catch (e) {
      return Message(code: 0, message: 'Error al registrar', status: false);
    }
  }

  Future<Message> actualizarCliente(Cliente cliente) async {
    try {
      Response response =
          await _dioHttpCliente.put('$_baseUrl/cliente', data: cliente.toMap());
      final data = Message.fromMap(response.data);
      return data;
    } catch (e) {
      log(e.toString());
      return Message(message: "error", code: -1, status: false);
    }
  }
}

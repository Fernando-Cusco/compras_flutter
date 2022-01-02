// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

import 'package:user_auth/user/models/models.dart';

class User {
  User({
    this.id,
    this.username,
    required this.correo,
    required this.password,
    required this.telefono,
    required this.estado,
    this.cliente,
    this.token,
    required this.fechaNacimiento,
  });

  final int? id;
  final String? username;
  final String correo;
  final String password;
  final int telefono;
  final bool estado;
  Cliente? cliente;
  final String? token;
  final String fechaNacimiento;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  factory User.empty() => User(
        id: -1,
        username: "",
        correo: "",
        password: "",
        telefono: 0,
        estado: false,
        cliente: Cliente.empty(),
        token: "",
        fechaNacimiento: "",
      );
  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        correo: json["correo"],
        password: json["password"],
        telefono: json["telefono"],
        estado: json["estado"],
        cliente:
            json["cliente"] == null ? null : Cliente.fromMap(json["cliente"]),
        token: json["token"],
        fechaNacimiento: json["fecha_nacimiento"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "correo": correo,
        "password": password,
        "telefono": telefono,
        "estado": estado,
        "cliente": cliente?.toMap(),
        "token": token,
        "fecha_nacimiento": fechaNacimiento,
      };
}

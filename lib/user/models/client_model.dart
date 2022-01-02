// To parse this JSON data, do
//
//     final cliente = clienteFromMap(jsonString);

import 'dart:convert';

class Cliente {
  Cliente({
    this.id,
    required this.nombres,
    required this.apellidos,
    required this.cedula,
    required this.direccion,
    this.correo,
  });

  final int? id;
  final String nombres;
  final String apellidos;
  final String cedula;
  final String direccion;
  final String? correo;

  factory Cliente.empty() => Cliente(
        nombres: '',
        apellidos: '',
        cedula: '',
        direccion: '',
        correo: '',
      );

  factory Cliente.fromJson(String str) => Cliente.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        cedula: json["cedula"],
        direccion: json["direccion"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombres": nombres,
        "apellidos": apellidos,
        "cedula": cedula,
        "direccion": direccion,
        "correo": correo,
      };
}

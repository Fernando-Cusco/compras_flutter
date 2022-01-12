// To parse this JSON data, do
//
//     final compra = compraFromMap(jsonString);

import 'dart:convert';

import 'package:user_auth/products/models/product_model.dart';
import 'package:user_auth/user/models/client_model.dart';

class Compra {
  Compra({
    required this.id,
    required this.fecha,
    this.observaciones,
    required this.cliente,
    required this.estadoCompra,
    required this.detallesCompra,
    required this.total,
  });

  final int id;
  final DateTime fecha;
  final String? observaciones;
  final Cliente cliente;
  final String estadoCompra;
  final List<Detalle> detallesCompra;
  final double total;

  factory Compra.fromJson(String str) => Compra.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Compra.fromMap(Map<String, dynamic> json) => Compra(
        id: json["id"],
        fecha: DateTime.parse(json["fecha"]),
        observaciones: json["observaciones"],
        cliente: Cliente.fromMap(json["cliente"]),
        estadoCompra: json["estadoCompra"],
        detallesCompra: List<Detalle>.from(
            json["detallesCompra"].map((x) => Detalle.fromMap(x))),
        total: json["total"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fecha": fecha.toIso8601String(),
        "observaciones": observaciones,
        "cliente": cliente.toMap(),
        "estadoCompra": estadoCompra,
        "detallesCompra":
            List<dynamic>.from(detallesCompra.map((x) => x.toMap())),
        "total": total,
      };
}

// To parse this JSON data, do
//
//     final producto = productoFromMap(jsonString);

import 'dart:convert';

class Producto {
  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    required this.stock,
    required this.promocion,
    required this.caracteristicas,
    required this.imagenes,
    required this.esFavorito,
    required this.precioInicial,
    required this.descuentoPorcentaje,
    required this.valorDescuento,
    required this.precioFinal,
  });

  final int id;
  final String nombre;
  final dynamic descripcion;
  final bool estado;
  final int stock;
  final bool promocion;
  final List<Caracteristica> caracteristicas;
  final List<Imagen> imagenes;
  final double precioInicial;
  final int descuentoPorcentaje;
  final double valorDescuento;
  final double precioFinal;
  bool esFavorito;

  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        stock: json["stock"],
        esFavorito: json["esFavorito"],
        promocion: json["promocion"],
        caracteristicas: List<Caracteristica>.from(
            json["caracteristicas"].map((x) => Caracteristica.fromMap(x))),
        imagenes:
            List<Imagen>.from(json["imagenes"].map((x) => Imagen.fromMap(x))),
        precioInicial: json["precio_inicial"].toDouble(),
        descuentoPorcentaje: json["descuento_porcentaje"],
        valorDescuento: json["valor_descuento"].toDouble(),
        precioFinal: json["precio_final"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
        "stock": stock,
        "esFavorito": esFavorito,
        "promocion": promocion,
        "caracteristicas":
            List<dynamic>.from(caracteristicas.map((x) => x.toMap())),
        "imagenes": List<dynamic>.from(imagenes.map((x) => x.toMap())),
        "precio_inicial": precioInicial,
        "descuento_porcentaje": descuentoPorcentaje,
        "valor_descuento": valorDescuento,
        "precio_final": precioFinal,
      };
}

class Caracteristica {
  Caracteristica({
    required this.id,
    required this.nombre,
  });

  final int id;
  final String nombre;

  factory Caracteristica.fromJson(String str) =>
      Caracteristica.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Caracteristica.fromMap(Map<String, dynamic> json) => Caracteristica(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}

class Imagen {
  Imagen({
    required this.id,
    required this.path,
  });

  final int id;
  final String path;

  factory Imagen.fromJson(String str) => Imagen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Imagen.fromMap(Map<String, dynamic> json) => Imagen(
        id: json["id"],
        path: json["path"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "path": path,
      };
}

class Detalle {
  Detalle({
    required this.id,
    required this.cantidad,
    required this.producto,
    required this.subtotal,
  });

  final int id;
  final int cantidad;
  final Producto producto;
  final double subtotal;

  factory Detalle.fromJson(String str) => Detalle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Detalle.fromMap(Map<String, dynamic> json) => Detalle(
        id: json["id"],
        cantidad: json["cantidad"],
        producto: Producto.fromMap(json["producto"]),
        subtotal: json["subtotal"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cantidad": cantidad,
        "producto": producto.toMap(),
        "subtotal": subtotal,
      };
}

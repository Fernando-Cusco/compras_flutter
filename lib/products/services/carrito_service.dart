import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:user_auth/products/models/compra_model.dart';
import 'package:user_auth/products/models/product_model.dart';
import 'package:user_auth/user/models/api_message_model.dart';
import 'package:user_auth/user/services/interceptor_cliente.dart';

class CarritoService {
  final Dio _dio = Dio()..interceptors.add(InterceptorCLiente());
  final String _baseUrl = "http://192.168.0.109:8080/api";

  Future<Message> realizarCompra(String cedula) async {
    try {
      final response = await _dio.put("$_baseUrl/compra/$cedula");
      return Message.fromMap(response.data);
    } on DioError catch (e) {
      log(e.toString());
      return Message(message: "error", code: 0, status: false);
    }
  }

  Future<List<Compra>> misCompras(String cedula) async {
    try {
      List<Compra> compras = [];
      final response = await _dio.get("$_baseUrl/compra/$cedula");
      final data = response.data as List;
      data.map((e) {
        compras.add(Compra.fromMap(e));
      }).toList();
      return compras;
    } on DioError catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<Detalle>> verCarrito(String cedula) async {
    final url = "$_baseUrl/compra/carrito/$cedula";
    final List<Detalle> detalles = [];
    try {
      final response = await _dio.get(url);
      final List data = response.data;
      data.map((e) => {detalles.add(Detalle.fromMap(e))}).toList();
      return detalles;
    } on DioError catch (e) {
      log('Error: $e');
      return [];
    }
  }

  Future<Message> actualizarCarrito(
      Producto producto, String cedula, bool add) async {
    final url = "$_baseUrl/compra/carrito/$cedula/$add";
    try {
      final response = await _dio.put(url, data: producto.toMap());
      return Message.fromMap(response.data);
    } on DioError catch (e) {
      log('Error: $e');
      return Message(message: "error", code: 0, status: false);
    }
  }

  Future<Message> eliminarProductoCarrito(
      Producto producto, String cedula) async {
    final url = "$_baseUrl/compra/carrito/eliminar/$cedula";
    try {
      final response = await _dio.put(url, data: producto.toMap());
      return Message.fromMap(response.data);
    } on DioError catch (e) {
      log('Error: $e');
      return Message(message: "error", code: 0, status: false);
    }
  }
}

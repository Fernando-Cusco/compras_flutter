import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:user_auth/products/models/product_model.dart';
import 'package:user_auth/user/services/interceptor_cliente.dart';

class ProductsService {
  final Dio _dio = Dio()..interceptors.add(InterceptorCLiente());
  final String _baseUrl = "http://192.168.0.109:8080/api";

  Future<List<Producto>> getProducts(int id) async {
    log(id.toString());
    try {
      final List<Producto> productos = [];
      final response = await _dio.get("$_baseUrl/producto/lista/$id");
      final List data = response.data;
      data.map((e) => {productos.add(Producto.fromMap(e))}).toList();
      log(productos.length.toString());
      log("prouctos");
      return productos;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}

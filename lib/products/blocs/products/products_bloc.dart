import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_auth/products/models/product_model.dart';
import 'package:user_auth/products/services/products_service.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsService productsService;
  ProductsBloc(this.productsService)
      : super(const ProductsState(productos: [], favoritos: [])) {
    on<OnLimpiarProductosEvent>(
        (event, emit) => {emit(state.copyWith(productos: []))});
    on<OnLoadingProductsEvent>((event, emit) {
      emit(state.copyWith());
    });
    on<OnLoadedProductsEvent>((event, emit) {
      emit(state.copyWith(productos: event.products));
    });

    on<OnCargarFavoritosEvent>(
        (event, emit) => {emit(state.copyWith(favoritos: event.favoritos))});
  }
  Future getProducts(int id) async {
    final productos = await productsService.getProducts(id);
    add(OnLoadedProductsEvent(products: productos));
  }

  Future listarFavoritosCliente(int id) async {
    List<int> productosId = await productsService.listarFavoritosCliente(id);
    List<Producto> productos = [];
    if (productosId.isNotEmpty) {
      for (var p in state.productos) {
        log(p.id.toString());
        for (var e in productosId) {
          if (p.id == e) {
            productos.add(p);
          }
        }
      }
      add(OnCargarFavoritosEvent(favoritos: productos));
    } else {
      add(const OnCargarFavoritosEvent(favoritos: []));
    }
  }

  Future agregarFavorito(String cedula, int idProducto) async {
    await productsService.agregarFavorito(cedula, idProducto);
  }

  Future eliminarFavorito(String cedula, int idProducto) async {
    await productsService.eliminarFavorito(cedula, idProducto);
  }
}

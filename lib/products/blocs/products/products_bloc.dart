import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_auth/products/models/product_model.dart';
import 'package:user_auth/products/services/products_service.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsService productsService;
  ProductsBloc(this.productsService)
      : super(const ProductsState(productos: [])) {
    on<OnLimpiarProductosEvent>(
        (event, emit) => {emit(state.copyWith(productos: []))});
    on<OnLoadingProductsEvent>((event, emit) {
      emit(state.copyWith());
    });
    on<OnLoadedProductsEvent>((event, emit) {
      emit(state.copyWith(productos: event.products));
    });
  }
  Future getProducts(int id) async {
    final productos = await productsService.getProducts(id);
    add(OnLoadedProductsEvent(products: productos));
  }

  Future agregarFavorito(String cedula, int idProducto) async {
    await productsService.agregarFavorito(cedula, idProducto);
  }

  Future eliminarFavorito(String cedula, int idProducto) async {
    await productsService.eliminarFavorito(cedula, idProducto);
  }
}

part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class OnLoadingProductsEvent extends ProductsEvent {
  final bool isLoading;

  const OnLoadingProductsEvent({required this.isLoading});
}

class OnLoadedProductsEvent extends ProductsEvent {
  final List<Producto> products;

  const OnLoadedProductsEvent({required this.products});
}

class OnLimpiarProductosEvent extends ProductsEvent {}

class OnCargarFavoritosEvent extends ProductsEvent {
  final List<Producto> favoritos;

  const OnCargarFavoritosEvent({required this.favoritos});
}

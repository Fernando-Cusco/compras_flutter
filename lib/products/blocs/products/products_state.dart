part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final List<Producto> productos;
  final List<Producto> favoritos;

  const ProductsState({required this.productos, required this.favoritos});

  @override
  List<Object> get props => [productos, favoritos];

  copyWith({List<Producto>? productos, List<Producto>? favoritos}) {
    return ProductsState(
      productos: productos ?? this.productos,
      favoritos: favoritos ?? this.favoritos,
    );
  }
}

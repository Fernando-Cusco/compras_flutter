part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final List<Producto> productos;

  const ProductsState({required this.productos});

  @override
  List<Object> get props => [productos];

  copyWith({List<Producto>? productos}) {
    return ProductsState(
      productos: productos ?? this.productos,
    );
  }
}

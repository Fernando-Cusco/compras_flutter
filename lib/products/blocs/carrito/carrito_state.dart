part of 'carrito_bloc.dart';

class CarritoState extends Equatable {
  final List<Compra> compras;
  final List<Detalle> detalles;
  const CarritoState({required this.detalles, required this.compras});

  @override
  List<Object> get props => [detalles, compras];

  copyWith({List<Detalle>? detalles, List<Compra>? compras}) {
    return CarritoState(
        detalles: detalles ?? this.detalles, compras: compras ?? this.compras);
  }
}

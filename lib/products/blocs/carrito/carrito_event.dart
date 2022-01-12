part of 'carrito_bloc.dart';

abstract class CarritoEvent extends Equatable {
  const CarritoEvent();

  @override
  List<Object> get props => [];
}

class ONCargarComprasEvent extends CarritoEvent {
  final List<Compra> compras;

  const ONCargarComprasEvent({required this.compras});
}

class OnCargarCarritoComprasEvent extends CarritoEvent {
  final List<Detalle> detalles;

  const OnCargarCarritoComprasEvent({required this.detalles});
}

class OnActualizarCarritoCompras extends CarritoEvent {
  const OnActualizarCarritoCompras();
}

class OnEliminaProductoCarritoEvent extends CarritoEvent {
  const OnEliminaProductoCarritoEvent();
}

class OnVaciarCarritoComprasEvent extends CarritoEvent {
  const OnVaciarCarritoComprasEvent();
}

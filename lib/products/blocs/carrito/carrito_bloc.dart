import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_auth/products/models/compra_model.dart';
import 'package:user_auth/products/models/product_model.dart';
import 'package:user_auth/products/services/carrito_service.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/models/api_message_model.dart';

part 'carrito_event.dart';
part 'carrito_state.dart';

class CarritoBloc extends Bloc<CarritoEvent, CarritoState> {
  final CarritoService carritoService;
  final UserBloc userBloc;
  CarritoBloc(this.carritoService, this.userBloc)
      : super(const CarritoState(detalles: [], compras: [])) {
    on<CarritoEvent>((event, emit) {});

    on<OnCargarCarritoComprasEvent>(
        (event, emit) => {emit(state.copyWith(detalles: event.detalles))});

    on<OnVaciarCarritoComprasEvent>((event, emit) {
      emit(state.copyWith(detalles: []));
    });

    on<ONCargarComprasEvent>(
        (event, emit) => {emit(state.copyWith(compras: event.compras))});
  }

  Future cargarCompras(String cedula) async {
    final compras = await carritoService.misCompras(cedula);
    add(ONCargarComprasEvent(compras: compras));
  }

  Future<Message> realizarCompra(String cedula) async {
    final message = await carritoService.realizarCompra(cedula);
    if (message.code == 200) {
      add(const OnVaciarCarritoComprasEvent());
    }
    return message;
  }

  Future<void> cargarCarrito() async {
    log("cedula del cliente");
    if (userBloc.state.user.cliente != null) {
      final detalles =
          await carritoService.verCarrito(userBloc.state.user.cliente!.cedula);
      add(OnCargarCarritoComprasEvent(detalles: detalles));
    }
  }

  Future actalizarCarritoCompras(Producto producto, bool add) async {
    if (userBloc.state.user.cliente != null) {
      final message = await carritoService.actualizarCarrito(
          producto, userBloc.state.user.cliente!.cedula, add);
      if (message.code == 100) {
        cargarCarrito();
      } else if (message.code == 0) {
        // TODO: Mostrar mensaje de error
      }
    }
  }

  Future eliminarProductoCarritoCompras(Producto producto) async {
    if (userBloc.state.user.cliente != null) {
      final message = await carritoService.eliminarProductoCarrito(
          producto, userBloc.state.user.cliente!.cedula);
      if (message.code == 200) {
        cargarCarrito();
      } else if (message.code == 400) {
        // TODO: Mostrar mensaje de error
      }
    }
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/helpers/show_loading_messages.dart';
import 'package:user_auth/products/blocs/carrito/carrito_bloc.dart';
import 'package:user_auth/products/models/product_model.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';

class CarritoView extends StatelessWidget {
  const CarritoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carritoBloc = BlocProvider.of<CarritoBloc>(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text('Carrito de compras',
                  style: TextStyle(color: Colors.black, fontSize: 25)),
              centerTitle: true,
            ),
            body: BlocBuilder<CarritoBloc, CarritoState>(
              builder: (context, state) {
                if (state.detalles.isEmpty) {
                  return const Center(
                    child: Text("Carrito vacío"),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: state.detalles.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Row(
                                children: [
                                  Text(state.detalles[index].producto.nombre),
                                  const SizedBox(width: 10),
                                  Text(
                                      "\$${state.detalles[index].producto.precioFinal}")
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        carritoBloc.actalizarCarritoCompras(
                                            state.detalles[index].producto,
                                            true);
                                      },
                                      icon:
                                          const Icon(Icons.add_circle_rounded)),
                                  IconButton(
                                      onPressed: () {
                                        if (state.detalles[index].cantidad >
                                            1) {
                                          carritoBloc.actalizarCarritoCompras(
                                              state.detalles[index].producto,
                                              false);
                                        }
                                      },
                                      icon: const Icon(
                                          Icons.remove_circle_rounded)),
                                  const SizedBox(width: 30),
                                  Text(
                                      "Cantidad ${state.detalles[index].cantidad}"),
                                ],
                              ),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  carritoBloc.eliminarProductoCarritoCompras(
                                      state.detalles[index].producto);
                                },
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Total: ", style: TextStyle(fontSize: 20)),
                        total(state.detalles),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                                color: Colors.black,
                                shape: const StadiumBorder(),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text("Comprar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                ),
                                onPressed: () async {
                                  showLoadingMessage(context);
                                  if (userState.user.cliente != null) {
                                    final message =
                                        await carritoBloc.realizarCompra(
                                            userState.user.cliente!.cedula);
                                    final snackBar = SnackBar(
                                        content: Text(message.message),
                                        duration: const Duration(seconds: 2));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                  Navigator.pop(context);
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ));
      },
    );
  }

  Widget total(List<Detalle> detalles) {
    double total = 0;
    detalles.map((detalle) => total += detalle.subtotal).toList();
    return Text("\$ ${total.toStringAsFixed(2)}",
        style: const TextStyle(fontSize: 20));
  }
}

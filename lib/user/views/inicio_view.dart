import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/products/blocs/carrito/carrito_bloc.dart';
import 'package:user_auth/products/blocs/products/products_bloc.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/views/detalle_producto_view.dart';
import 'package:user_auth/user/views/perfil_view.dart';

class InicioView extends StatefulWidget {
  const InicioView({Key? key}) : super(key: key);

  @override
  State<InicioView> createState() => _InicioViewState();
}

class _InicioViewState extends State<InicioView> {
  @override
  Widget build(BuildContext context) {
    final carritoBloc = BlocProvider.of<CarritoBloc>(context);
    final productoBloc = BlocProvider.of<ProductsBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
        if (state.productos.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.productos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetalleProductoView(
                              producto: state.productos[index],
                            )));
              },
              child: SizedBox(
                height: 260,
                child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    top: -10,
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: state.productos[index].id,
                      child: Image.network(
                        "http://192.168.0.109:8080/api/imagen/get/${state.productos[index].imagenes[0].path}",
                        fit: BoxFit.fill,
                        width: size.width * 0.4,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    child: Container(
                      width: size.width * 0.7,
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.09),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(state.productos[index].nombre,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text("\$${state.productos[index].precioFinal}",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text("Ver más",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18)),
                                  )),
                              IconButton(
                                iconSize: 30,
                                onPressed: () {
                                  final cliente = userBloc.state.user.cliente;
                                  if (cliente?.apellidos != "" &&
                                      cliente?.nombres != "" &&
                                      cliente?.cedula != "") {
                                    if (state.productos[index].esFavorito) {
                                      setState(() {
                                        productoBloc.eliminarFavorito(
                                            userBloc.state.user.cliente!.cedula,
                                            state.productos[index].id);
                                        state.productos[index].esFavorito =
                                            false;
                                      });
                                    } else {
                                      setState(() {
                                        productoBloc.agregarFavorito(
                                            userBloc.state.user.cliente!.cedula,
                                            state.productos[index].id);
                                        state.productos[index].esFavorito =
                                            true;
                                      });
                                    }
                                  } else {
                                    _showMessage();
                                  }
                                },
                                icon: (!state.productos[index].esFavorito)
                                    ? const Icon(Icons.favorite_border,
                                        color: Colors.black)
                                    : const Icon(Icons.favorite_sharp,
                                        color: Colors.red),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 40,
                    child: IconButton(
                      iconSize: 35,
                      splashColor: Colors.black54,
                      splashRadius: 20,
                      onPressed: () {
                        final cliente = userBloc.state.user.cliente;
                        if (cliente?.apellidos != "" &&
                            cliente?.nombres != "" &&
                            cliente?.cedula != "") {
                          carritoBloc.actalizarCarritoCompras(
                              state.productos[index], true);
                        } else {
                          _showMessage();
                        }
                      },
                      icon: const Icon(Icons.add_shopping_cart,
                          color: Colors.black),
                    ),
                  ),
                ]),
              ),
            );
          },
        );
      }),
    );
  }

  _showMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("¡Completa tu información de perfil!"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
              )
            ],
          );
        });
  }
}

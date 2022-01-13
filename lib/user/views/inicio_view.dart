import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/products/blocs/carrito/carrito_bloc.dart';
import 'package:user_auth/products/blocs/products/products_bloc.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';

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
    final imagenes = [
      'assets/img/productos/airpods.png',
      'assets/img/productos/mac.png',
      'assets/img/productos/watch.png'
    ];
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child:
          BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
        return ListView.builder(
          itemCount: state.productos.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 250,
              child: Stack(children: [
                Positioned(
                  left: 20,
                  child: Image.network(
                    "http://192.168.0.109:8080/api/imagen/get/${state.productos[index].imagenes[0].path}",
                    fit: BoxFit.fill,
                    width: 140,
                  ),
                ),
                Positioned(
                  top: 80,
                  child: Container(
                    width: 200,
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
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text("Ver más",
                                      style: TextStyle(color: Colors.black)),
                                )),
                            IconButton(
                              onPressed: () {
                                if (state.productos[index].esFavorito) {
                                  setState(() {
                                    productoBloc.eliminarFavorito(
                                        userBloc.state.user.cliente!.cedula,
                                        state.productos[index].id);
                                    state.productos[index].esFavorito = false;
                                  });
                                } else {
                                  setState(() {
                                    productoBloc.agregarFavorito(
                                        userBloc.state.user.cliente!.cedula,
                                        state.productos[index].id);
                                    state.productos[index].esFavorito = true;
                                  });
                                }
                              },
                              icon: (!state.productos[index].esFavorito)
                                  ? const Icon(Icons.favorite_border,
                                      color: Colors.black)
                                  : const Icon(Icons.favorite_sharp,
                                      color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 170,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(
                      onPressed: () {
                        carritoBloc.actalizarCarritoCompras(
                            state.productos[index], true);
                      },
                      icon: const Icon(Icons.add_shopping_cart,
                          color: Colors.black, size: 25),
                    ),
                  ),
                ),
              ]),
            );
          },
        );
      }),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/products/blocs/carrito/carrito_bloc.dart';
import 'package:user_auth/products/blocs/products/products_bloc.dart';
import 'package:user_auth/products/models/product_model.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/views/carrito_view.dart';
import 'package:user_auth/user/views/content_views.dart';

class DetalleProductoView extends StatefulWidget {
  final Producto producto;
  const DetalleProductoView({Key? key, required this.producto})
      : super(key: key);

  @override
  _DetalleProductoViewState createState() => _DetalleProductoViewState();
}

class _DetalleProductoViewState extends State<DetalleProductoView> {
  @override
  Widget build(BuildContext context) {
    final productosBloc = BlocProvider.of<ProductsBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    final carritoBloc = BlocProvider.of<CarritoBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                actions: [
                  Stack(
                    children: [
                      IconButton(
                          iconSize: 30,
                          color: Colors.black,
                          icon: const Icon(Icons.shopping_cart),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CarritoView()));
                          }),
                      Positioned(
                          right: 1,
                          child: BlocBuilder<CarritoBloc, CarritoState>(
                            builder: (context, state) {
                              return CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white,
                                child: Text(
                                    carritoBloc.state.detalles.length
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.red)),
                              );
                            },
                          )),
                    ],
                  )
                ],
                leading: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContentViews()));
                  },
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    transitionOnUserGestures: true,
                    tag: widget.producto.id,
                    child: Image.network(
                        "http://192.168.0.109:8080/api/imagen/get/${widget.producto.imagenes[0].path}",
                        fit: BoxFit.cover),
                  ),
                )),
            //3
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.producto.nombre,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\$ ${widget.producto.precioFinal}",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text("Caracteristicas",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                        const SizedBox(height: 15),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...widget.producto.caracteristicas
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Chip(label: Text(e.nombre)),
                                      ))
                                  .toList(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              iconSize: 30,
                              onPressed: () {
                                if (widget.producto.esFavorito) {
                                  setState(() {
                                    productosBloc.eliminarFavorito(
                                        userBloc.state.user.cliente!.cedula,
                                        widget.producto.id);
                                    widget.producto.esFavorito = false;
                                  });
                                } else {
                                  setState(() {
                                    productosBloc.agregarFavorito(
                                        userBloc.state.user.cliente!.cedula,
                                        widget.producto.id);
                                    widget.producto.esFavorito = true;
                                  });
                                }
                              },
                              icon: (!widget.producto.esFavorito)
                                  ? const Icon(Icons.favorite_border,
                                      color: Colors.black)
                                  : const Icon(Icons.favorite_sharp,
                                      color: Colors.red),
                            ),
                            Row(
                              children: [
                                const Text("Agregar al carrito",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54)),
                                IconButton(
                                  iconSize: 35,
                                  splashColor: Colors.black54,
                                  splashRadius: 20,
                                  onPressed: () {
                                    carritoBloc.actalizarCarritoCompras(
                                        widget.producto, true);
                                  },
                                  icon: const Icon(Icons.add_shopping_cart,
                                      color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

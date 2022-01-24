import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/products/blocs/carrito/carrito_bloc.dart';
import 'package:user_auth/products/blocs/products/products_bloc.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/views/carrito_view.dart';
import 'package:user_auth/user/views/compras_view.dart';
import 'package:user_auth/user/views/inicio_view.dart';
import 'package:user_auth/user/views/login_view.dart';
import 'package:user_auth/user/views/opciones_view.dart';
import 'package:user_auth/user/views/perfil_view.dart';

class ContentViews extends StatefulWidget {
  ContentViews({Key? key}) : super(key: key);

  @override
  _ContentViewsState createState() => _ContentViewsState();
}

class _ContentViewsState extends State<ContentViews> {
  @override
  void initState() {
    final userBloc = BlocProvider.of<UserBloc>(context);
    BlocProvider.of<ProductsBloc>(context).getProducts(userBloc.state.user.id!);
    BlocProvider.of<CarritoBloc>(context).cargarCarrito();
    super.initState();
  }

  final pages = const [
    InicioView(),
    OpcionesView(),
    CarritoView(),
    ComprasView(),
    PerfilView()
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: onTap,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Productos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_sharp), label: "Favoritos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded), label: "Carrito"),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: "Compras"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }

  void onTap(int index) {
    log(index.toString());
    setState(() {
      currentIndex = index;
    });
  }
}

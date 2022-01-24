import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/products/blocs/carrito/carrito_bloc.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/views/detalle_compra_view.dart';

class ComprasView extends StatefulWidget {
  const ComprasView({Key? key}) : super(key: key);

  @override
  _ComprasViewState createState() => _ComprasViewState();
}

class _ComprasViewState extends State<ComprasView> {
  @override
  void initState() {
    super.initState();
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state.user.cliente != null) {
      BlocProvider.of<CarritoBloc>(context)
          .cargarCompras(userBloc.state.user.cliente!.cedula);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Mis compras',
            style: TextStyle(color: Colors.black, fontSize: 25)),
        centerTitle: true,
      ),
      body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: BlocBuilder<CarritoBloc, CarritoState>(
            builder: (context, state) {
              return Container(
                child: state.compras.isEmpty
                    ? const Center(
                        child: Text('No hay compras'),
                      )
                    : ListView.builder(
                        itemCount: state.compras.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetalleCompraView(
                                        compra: state.compras[index])),
                              );
                            },
                            title: Text(state.compras[index].estadoCompra),
                            subtitle: Text(
                                "Total \$${state.compras[index].total.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            trailing: Text(
                                "${state.compras[index].fecha.day}/${state.compras[index].fecha.month}/${state.compras[index].fecha.year}"),
                          );
                        },
                      ),
              );
            },
          )),
    );
  }
}

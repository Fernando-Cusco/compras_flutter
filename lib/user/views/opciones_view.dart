import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/products/blocs/products/products_bloc.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';

class OpcionesView extends StatefulWidget {
  const OpcionesView({Key? key}) : super(key: key);

  @override
  State<OpcionesView> createState() => _OpcionesViewState();
}

class _OpcionesViewState extends State<OpcionesView> {
  @override
  void initState() {
    super.initState();
    final userBloc = BlocProvider.of<UserBloc>(context);
    BlocProvider.of<ProductsBloc>(context)
        .listarFavoritosCliente(userBloc.state.user.cliente!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Favoritos',
            style: TextStyle(color: Colors.black, fontSize: 25)),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state.favoritos.isEmpty) {
            return const Center(
              child: Text('No tienes productos favoritos'),
            );
          }
          return ListView.builder(
            itemCount: state.favoritos.length,
            itemBuilder: (context, index) {
              final producto = state.favoritos[index];
              return ListTile(
                title: Text(producto.nombre),
                subtitle: Text(producto.descripcion ?? ""),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
              );
            },
          );
        },
      ),
    );
  }
}

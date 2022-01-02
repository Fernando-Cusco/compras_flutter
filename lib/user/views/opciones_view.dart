import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';

class OpcionesView extends StatelessWidget {
  const OpcionesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              state.user.username ?? "",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(state.user.correo),
                Text(state.user.username ?? ""),
                Text(state.user.estado.toString()),
              ])),
        );
      },
    );
  }
}

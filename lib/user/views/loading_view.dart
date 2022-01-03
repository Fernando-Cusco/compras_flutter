import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/views/content_views.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        log("ESPERANDO DATOS");
        log(state.user.estado.toString());
        return (state.user.estado)
            ? ContentViews()
            : const _LoadingViewInicio();
      },
    );
  }
}

class _LoadingViewInicio extends StatelessWidget {
  const _LoadingViewInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        Text("Espere por favor..."),
      ],
    )));
  }
}

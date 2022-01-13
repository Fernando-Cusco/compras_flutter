import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/products/blocs/products/products_bloc.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/views/content_views.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  void initState() {
    super.initState();
    final userBloc = BlocProvider.of<UserBloc>(context);
    BlocProvider.of<ProductsBloc>(context).getProducts(userBloc.state.user.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
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

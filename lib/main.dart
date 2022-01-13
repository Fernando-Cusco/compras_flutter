import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_auth/blocs/auth/auth_bloc.dart';
import 'package:user_auth/products/blocs/carrito/carrito_bloc.dart';
import 'package:user_auth/products/blocs/products/products_bloc.dart';
import 'package:user_auth/products/services/carrito_service.dart';
import 'package:user_auth/products/services/products_service.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/services/user_services.dart';
import 'package:user_auth/user/views/loading_view.dart';
import 'package:user_auth/user/views/user_views.dart';
import 'package:jwt_decode/jwt_decode.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthBloc()),
    BlocProvider(create: (context) => UserBloc(UserService())),
    BlocProvider(create: (context) => ProductsBloc(ProductsService())),
    BlocProvider(
        create: (context) =>
            CarritoBloc(CarritoService(), BlocProvider.of<UserBloc>(context)))
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;
  bool _isCorrectToken = false;
  int _id = 0;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        log(e.toString());
        _error = true;
      });
    }
  }

  void validToken() async {
    final prefs = await SharedPreferences.getInstance();
    final userBloc = BlocProvider.of<UserBloc>(context);
    final token = prefs.getString('token');
    final correo = prefs.getString('correo');
    final password = prefs.getString('password');
    token != null
        ? setState(() {
            if (!Jwt.isExpired(token)) {
              if (correo != null && password != null) {
                userBloc.login(correo, password).then((user) {
                  if (user.id == 0) {
                    _isCorrectToken = false;
                  } else if (user.id == -1) {
                    _isCorrectToken = false;
                  } else {
                    prefs.setString('token', user.token!);
                    _isCorrectToken = true;
                  }
                });
              } else {
                _isCorrectToken = false;
              }
            }
            _isCorrectToken = Jwt.isExpired(token) ? false : true;
          })
        : setState(() {
            _isCorrectToken = false;
          });
  }

  @override
  void initState() {
    initializeFlutterFire();
    validToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) return _container('Error', Colors.red);

    if (!_initialized) return _container('Loading', Colors.blue);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (!_isCorrectToken) ? const LoginView() : const LoadingView());
  }

  Widget _container(String title, Color color) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Text(title,
          style: TextStyle(color: color), textDirection: TextDirection.ltr),
    );
  }
}

/*
return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Scaffold(
                  appBar: AppBar(
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.exit_to_app),
                        onPressed: () {
                          authBloc.logoutAll();
                        },
                      ),
                      (state.userIsAuth)? CircleAvatar(child: Image.network("${state.user!.photoURL}")) : Container(),
                    ],
                    leading: const Icon(Icons.facebook),
                    title: (state.userIsAuth)? Text("${state.user!.displayName}") : const Text("Inicio")),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (state.userIsAuth)? MaterialButton(
                              color: Colors.black,
                              textColor: Colors.white,
                              shape: const StadiumBorder(),
                              child: const Text("Cerrar sesión"),
                              onPressed: () async {
                                await authBloc.logoutAll();
                              },
                            ): MaterialButton(
                            color: Colors.black,
                            textColor: Colors.white,
                            shape: const StadiumBorder(),
                            child: const Text("Login Facebook"),
                            onPressed: () async {
                              await authBloc.loginFacebook();
                            },
                          ),
                          MaterialButton(
                            color: Colors.black,
                            textColor: Colors.white,
                            shape: const StadiumBorder(),
                            child: const Text("Get"),
                            onPressed: () async {
                              await authBloc.getAlgo();
                            },
                          ),
                          MaterialButton(
                            color: Colors.black,
                            textColor: Colors.white,
                            shape: const StadiumBorder(),
                            child: const Text("Login Google"),
                            onPressed: () async {
                              await authBloc.loginGoogle();
                            },
                          ),
                        ],
                      )
                    )
            );
          },
        ),
    );
  */

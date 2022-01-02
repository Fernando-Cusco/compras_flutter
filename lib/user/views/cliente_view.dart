import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/helpers/show_loading_messages.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/models/models.dart';

class ClienteView extends StatefulWidget {
  ClienteView({Key? key}) : super(key: key);

  @override
  State<ClienteView> createState() => _ClienteViewState();
}

class _ClienteViewState extends State<ClienteView> {
  final _nombresController = TextEditingController();

  final _apellidosController = TextEditingController();

  final _cedulaController = TextEditingController();

  final _direccioController = TextEditingController();

  @override
  void initState() {
    final userBloc = BlocProvider.of<UserBloc>(context);
    _nombresController.text = userBloc.state.user.cliente?.nombres ?? "";
    _apellidosController.text = userBloc.state.user.cliente?.apellidos ?? "";
    _cedulaController.text = userBloc.state.user.cliente?.cedula ?? "";
    _direccioController.text = userBloc.state.user.cliente?.direccion ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final _keyForm = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Datos del cliente', style: TextStyle(fontSize: 20)),
          Form(
            key: _keyForm,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                      controller: _nombresController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          labelText: "Nombres",
                          hintText: "Nombres",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(Icons.group,
                              color: Colors.black, size: 18),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 2,
                          )),
                          floatingLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 1.5)))),
                  TextFormField(
                    controller: _apellidosController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        labelText: "Apellidos",
                        hintText: "Apellidos",
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.group,
                            color: Colors.black, size: 18),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey.shade200,
                          width: 2,
                        )),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5))),
                  ),
                  TextFormField(
                    controller: _cedulaController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        labelText: "Cédula",
                        hintText: "Cédula",
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.person,
                            color: Colors.black, size: 18),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey.shade200,
                          width: 2,
                        )),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5))),
                  ),
                  TextFormField(
                    controller: _direccioController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        labelText: "Dirección",
                        hintText: "Dirección",
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.place,
                            color: Colors.black, size: 18),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey.shade200,
                          width: 2,
                        )),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5))),
                  ),
                  MaterialButton(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    color: Colors.black,
                    onPressed: () async {
                      // if (_keyForm.currentState!.validate()) {
                      //   _keyForm.currentState!.save();

                      //   // userBloc.actualizarCliente(cliente)
                      // }
                      final nombres = _nombresController.text;
                      final apellidos = _apellidosController.text;
                      final cedula = _cedulaController.text;
                      final direccion = _direccioController.text;
                      final cliente = Cliente(
                          nombres: nombres,
                          apellidos: apellidos,
                          cedula: cedula,
                          direccion: direccion,
                          correo: userBloc.state.user.correo);
                      showLoadingMessage(context);
                      await userBloc.actualizarCliente(cliente);
                      Navigator.pop(context);
                    },
                    child: const Text('Actualizar datos',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    shape: const StadiumBorder(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

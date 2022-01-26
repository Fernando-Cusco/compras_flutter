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
  static final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  bool enable = false;

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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _keyForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Datos del cliente',
                      style: TextStyle(fontSize: 20)),
                  Switch(
                      activeColor: Colors.black,
                      value: enable,
                      onChanged: (value) {
                        setState(() {
                          enable = value;
                          FocusScope.of(context).unfocus();
                        });
                      })
                ],
              ),
              TextFormField(
                enabled: enable,
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
                    prefixIcon:
                        const Icon(Icons.group, color: Colors.black, size: 18),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 2,
                    )),
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey.shade200,
                      width: 2,
                    ))),
              ),
              TextFormField(
                enabled: enable,
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
                    prefixIcon:
                        const Icon(Icons.group, color: Colors.black, size: 18),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 2,
                    )),
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey.shade200,
                      width: 2,
                    ))),
              ),
              TextFormField(
                enabled: enable,
                controller: _cedulaController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
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
                    prefixIcon:
                        const Icon(Icons.person, color: Colors.black, size: 18),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 2,
                    )),
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey.shade200,
                      width: 2,
                    ))),
              ),
              TextFormField(
                enabled: enable,
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
                    prefixIcon:
                        const Icon(Icons.place, color: Colors.black, size: 18),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 2,
                    )),
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey.shade200,
                      width: 2,
                    ))),
              ),
              MaterialButton(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                color: Colors.black,
                onPressed: () async {
                  if (enable) {
                    final nombres = _nombresController.text;
                    final apellidos = _apellidosController.text;
                    final cedula = _cedulaController.text;
                    final direccion = _direccioController.text;
                    final cliente = Cliente(
                        id: userBloc.state.user.cliente!.id,
                        nombres: nombres,
                        apellidos: apellidos,
                        cedula: cedula,
                        direccion: direccion,
                        correo: userBloc.state.user.correo);
                    showLoadingMessage(context);
                    final message = await userBloc.actualizarCliente(cliente);
                    if (message.code == 200) {
                      const snackBar = SnackBar(
                          content: Text('Cliente actualizado correctamente'),
                          duration: Duration(seconds: 2));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    Navigator.pop(context);
                    setState(() {
                      enable = false;
                    });
                  } else {
                    const snackBar = SnackBar(
                        content: Text('No hay cambios para actualizar'),
                        duration: Duration(seconds: 2));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Actualizar datos',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                shape: const StadiumBorder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/helpers/focus_node.dart';
import 'package:user_auth/helpers/show_loading_messages.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/models/client_model.dart';
import 'package:user_auth/user/models/user_model.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({Key? key}) : super(key: key);

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final _formKey = GlobalKey<FormState>();
  final _textControllerDate = TextEditingController();
  final _textControllerPassword = TextEditingController();
  final _textControllerPassword1 = TextEditingController();
  final _textControllerCorreo = TextEditingController();
  final _textControllerTelefono = TextEditingController();

  bool _showPassword = false;
  bool _showPassword1 = false;

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Row(
                  children: const [
                    Text(
                      'Registro',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: _textControllerCorreo,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Correo incorrecto';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      labelText: "Correo",
                      hintText: "Correo",
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      suffixIcon: const Icon(Icons.email,
                          color: Colors.black, size: 20),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade200, width: 2)),
                      floatingLabelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                    )),
                const SizedBox(height: 20),
                TextFormField(
                    controller: _textControllerPassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      final containsNumbers = RegExp(r'([0-9])');
                      if (value.length < 6) {
                        return 'La contraseña debe contener mínimo 6 caracteres';
                      }
                      if (!containsNumbers.hasMatch(value)) {
                        return 'La contraseña debe contener números';
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    obscureText: !_showPassword1,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      labelText: "Contraseña",
                      hintText: "Contraseña",
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      suffixIcon: IconButton(
                        icon: Icon(
                            (!_showPassword1)
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                            color: Colors.black,
                            size: 18),
                        onPressed: () {
                          setState(() {
                            _showPassword1 = !_showPassword1;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade200, width: 2)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                    )),
                const SizedBox(height: 20),
                TextFormField(
                    controller: _textControllerPassword1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (value != _textControllerPassword.text) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        labelText: "Repita la Contraseña",
                        hintText: "Repita la Contraseña",
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                        suffixIcon: IconButton(
                          icon: Icon(
                              (!_showPassword)
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off,
                              color: Colors.black,
                              size: 18),
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade200, width: 2)),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(20)))),
                const SizedBox(height: 20),
                TextFormField(
                    controller: _textControllerTelefono,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      labelText: "Teléfono",
                      hintText: "Teléfono",
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      suffixIcon: const Icon(Icons.phone,
                          color: Colors.black, size: 20),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade200, width: 2)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                    )),
                const SizedBox(height: 20),
                TextFormField(
                    focusNode: AlwaysDisabledFocusNode(),
                    controller: _textControllerDate,
                    onTap: () {
                      _selectDate(context);
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      labelText: "Fecha de Nacimiento",
                      hintText: "01-12-2000",
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      suffixIcon: const Icon(Icons.calendar_today,
                          color: Colors.black, size: 20),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade200, width: 2)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                    )),
                const SizedBox(height: 20),
                MaterialButton(
                    onPressed: () async {
                      showLoadingMessage(context);
                      if (_formKey.currentState!.validate()) {
                        final user = User(
                            correo: _textControllerCorreo.text,
                            password: _textControllerPassword.text,
                            telefono: int.parse(_textControllerTelefono.text),
                            fechaNacimiento: _textControllerDate.text,
                            cliente: Cliente.empty(),
                            estado: true);
                        final message = await userBloc.registro(user);
                        final snackBar = SnackBar(
                            content: Text(message.message),
                            duration: const Duration(seconds: 2));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        if (message.status) {
                          Navigator.of(context).pop();
                        }
                      }
                      Navigator.of(context).pop();
                    },
                    height: 45,
                    color: Colors.black,
                    child: const Text("Registrarse",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ya tienes cuenta?",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ingresa ahora",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _textControllerDate.text =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
        log(selectedDate.day.toString() +
            "/" +
            selectedDate.month.toString() +
            "/" +
            selectedDate.year.toString());
      });
    }
  }
}

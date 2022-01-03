import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/helpers/show_loading_messages.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/views/cliente_view.dart';
import 'package:user_auth/user/views/login_view.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({Key? key}) : super(key: key);

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _textControllerDate = TextEditingController();
  final _textControllerPassword = TextEditingController();
  final _textControllerPassword1 = TextEditingController();
  final _textControllerCorreo = TextEditingController();
  final _textControllerTelefono = TextEditingController();

  @override
  void initState() {
    final userBloc = BlocProvider.of<UserBloc>(context);
    _textControllerCorreo.text = userBloc.state.user.correo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    final userBloc = BlocProvider.of<UserBloc>(context);
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Perfil",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.black),
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context).cerrarSesion();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.all(20),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.black,
                tabs: const [
                  Text("Cliente"),
                  Text("Credenciales"),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Expanded(child: ClienteView()),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(20),
                                          labelText: "Correo",
                                          hintText: "Correo",
                                          labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          hintStyle: const TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                          suffixIcon: const Icon(Icons.email,
                                              color: Colors.black, size: 20),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade200,
                                                  width: 2)),
                                          floatingLabelStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.black,
                                                      width: 1.5),
                                                  borderRadius: BorderRadius
                                                      .circular(20)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        )),
                                    MaterialButton(
                                        onPressed: () {
                                          showLoadingMessage(context);
                                          Navigator.of(context).pop();
                                        },
                                        height: 45,
                                        color: Colors.black,
                                        child: const Text("Registrarse",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                    fontWeight:
                                                        FontWeight.w400)))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
      });
    }
  }
}

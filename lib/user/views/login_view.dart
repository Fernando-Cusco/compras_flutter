import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_auth/helpers/show_loading_messages.dart';
import 'package:user_auth/user/blocs/user/user_bloc.dart';
import 'package:user_auth/user/views/content_views.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_auth/user/views/registro_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final correoController = TextEditingController();

  final passwordController = TextEditingController();

  bool showPasword = false;

  bool saveCredentials = true;

  @override
  void initState() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((prefs) {
      if (prefs.getString('correo') != null) {
        setState(() {
          correoController.text = prefs.getString('correo') ?? "";
        });
      }
      if (prefs.getString('password') != null) {
        setState(() {
          passwordController.text = prefs.getString('password') ?? "";
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image(
                width: size.width * 0.8,
                height: size.height * 0.4,
                fit: BoxFit.cover,
                image: const AssetImage("assets/img/baner-login.png")),
            const SizedBox(height: 40),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: correoController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  labelText: 'Emial',
                  hintText: 'Email',
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon:
                      const Icon(Icons.email, color: Colors.black, size: 18),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 2)),
                  floatingLabelStyle:
                      const TextStyle(color: Colors.black, fontSize: 18),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: passwordController,
              obscureText: !showPasword,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        (!showPasword)
                            ? Icons.remove_red_eye
                            : Icons.visibility_off,
                        color: Colors.black,
                        size: 18),
                    onPressed: () {
                      setState(() {
                        showPasword = !showPasword;
                      });
                    },
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  labelText: 'Contraseña',
                  hintText: 'Contraseña',
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon:
                      const Icon(Icons.password, color: Colors.black, size: 18),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 2)),
                  floatingLabelStyle:
                      const TextStyle(color: Colors.black, fontSize: 18),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("Recordar credenciales?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                Checkbox(
                  value: saveCredentials,
                  onChanged: (value) {
                    setState(() {
                      saveCredentials = value!;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text("Olvidaste Tu Contraseña?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)))
              ],
            ),
            const SizedBox(height: 20),
            MaterialButton(
                onPressed: () async {
                  final correo = correoController.text.trim();
                  final password = passwordController.text.trim();
                  if (correo.isEmpty || password.isEmpty) return;
                  showLoadingMessage(context);
                  final user = await userBloc.login(
                      correoController.text, passwordController.text);
                  Navigator.pop(context);
                  if (user.id == 0) {
                    const snackBar = SnackBar(
                        content: Text('Credenciales Incorrectas'),
                        duration: Duration(seconds: 2));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (user.id == -1) {
                    const snackBar = SnackBar(
                        content: Text('Ocurrio un error'),
                        duration: Duration(seconds: 2));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    if (saveCredentials) {
                      userBloc.prefs.setString('correo', correo);
                      userBloc.prefs.setString('password', password);
                      userBloc.prefs.setString('token', user.token!);
                    } else {
                      await userBloc.prefs.clear();
                    }
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContentViews()));
                  }
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadingScreen()));
                },
                height: 45,
                color: Colors.black,
                child: const Text("Iniciar Sesión",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No tiene cuenta?",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistroView()));
                    },
                    child: const Text("Registrate ahora",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)))
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

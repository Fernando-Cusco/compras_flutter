import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void showLoadingMessage(BuildContext context) {
  // android
  if (Platform.isAndroid) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Espere por favor"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Verificando datos..."),
                  CircularProgressIndicator()
                ],
              ),
            ));
    return;
  }
  showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [Text("Espere por favor")],
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Verificando datos..."),
                CupertinoActivityIndicator()
              ],
            ),
          ));
}

import 'package:flutter/material.dart';
import 'package:user_auth/products/models/compra_model.dart';

class DetalleCompraView extends StatelessWidget {
  final Compra compra;

  const DetalleCompraView({Key? key, required this.compra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const styleTitle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const styleTotal = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    const styleDetalle = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Detalle de la compra',
              style: TextStyle(color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("Fecha: ", style: styleTitle),
                  Text(compra.fecha.toString()),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text("Estado: ", style: styleTitle),
                  Text(compra.estadoCompra),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text("Cliente: ", style: styleTitle),
                  Text("${compra.cliente.nombres} ${compra.cliente.apellidos}"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text("Dirección: ", style: styleTitle),
                  Text("${compra.cliente.nombres} ${compra.cliente.direccion}"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Detalle de la compra", style: styleTitle),
              const SizedBox(
                height: 10,
              ),
              Table(
                children: [
                  const TableRow(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                    ),
                    children: [
                      Text('Producto', style: styleTotal),
                      Text('Cantidad', style: styleTotal),
                      Text('Precio', style: styleTotal),
                    ],
                  ),
                  ...compra.detallesCompra.map((producto) {
                    return TableRow(
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                      ),
                      children: [
                        Text(producto.producto.nombre, style: styleDetalle),
                        Text(producto.cantidad.toString(), style: styleDetalle),
                        Text(producto.producto.precioFinal.toString(),
                            style: styleDetalle),
                      ],
                    );
                  }).toList(),
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                    ),
                    children: [
                      const Text(""),
                      const Text('Total', style: styleTotal),
                      Text(compra.total.toStringAsFixed(2), style: styleTotal),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

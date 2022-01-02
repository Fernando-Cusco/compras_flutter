import 'dart:convert';

class Alerta {
  Alerta({
    required this.codigo,
    required this.descripcion,
    required this.fecha,
    required this.tipoalerta,
    required this.idTemp,
    required this.mensajealerta,
  });

  final int codigo;
  final String descripcion;
  final String fecha;
  final Tipoalerta? tipoalerta;
  final int idTemp;
  final List<dynamic> mensajealerta;

  factory Alerta.fromJson(String str) => Alerta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Alerta.fromMap(Map<String, dynamic> json) => Alerta(
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        fecha: json["fecha"],
        tipoalerta: json["tipoalerta"] == null
            ? null
            : Tipoalerta.fromMap(json["tipoalerta"]),
        idTemp: json["idTemp"],
        mensajealerta: List<dynamic>.from(json["mensajealerta"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "descripcion": descripcion,
        "fecha": fecha,
        "tipoalerta": tipoalerta == null ? null : tipoalerta!.toMap(),
        "idTemp": idTemp,
        "mensajealerta": List<dynamic>.from(mensajealerta.map((x) => x)),
      };
}

class Tipoalerta {
  Tipoalerta({
    required this.codigo,
    required this.descripcion,
  });

  final int codigo;
  final String descripcion;

  factory Tipoalerta.fromJson(String str) =>
      Tipoalerta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tipoalerta.fromMap(Map<String, dynamic> json) => Tipoalerta(
        codigo: json["codigo"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "descripcion": descripcion,
      };
}

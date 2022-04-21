// To parse this JSON data, do
//
//     final prospecto = prospectoFromMap(jsonString);

import 'dart:convert';

List<Prospecto> prospectoFromJson(String str) =>
    List<Prospecto>.from(json.decode(str).map((x) => Prospecto.fromJson(str)));
String prospectoToJson(List<Prospecto> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

class Prospecto {
  Prospecto({
    this.id,
    required this.name,
    required this.linkedin,
    required this.puesto,
    required this.numero,
    required this.email,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String name;
  String linkedin;
  String puesto;
  String numero;
  String email;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Prospecto.fromJson(String str) => Prospecto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Prospecto.fromMap(Map<String, dynamic> json) => Prospecto(
        id: json["id"],
        name: json["name"],
        linkedin: json["linkedin"],
        puesto: json["puesto"],
        numero: json["numero"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "linkedin": linkedin,
        "puesto": puesto,
        "numero": numero,
        "email": email,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };

  Prospecto copy() => Prospecto(
      id: id,
      name: name,
      linkedin: linkedin,
      puesto: puesto,
      numero: numero,
      email: email,
      createdAt: createdAt,
      updatedAt: updatedAt);
}

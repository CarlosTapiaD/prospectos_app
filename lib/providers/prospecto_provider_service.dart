import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prospectos_app/models/prospecto.dart';
import 'package:http/http.dart' as http;

class ProspectosProviderService extends ChangeNotifier {
  final String _baseUrl = "https://api.carlostapiad.com/api";
  final List<Prospecto> listaProspectos = [];
  final List<Prospecto> listaProspectossearch = [];
  late Prospecto selectProspecto;
  bool isLoading = true;

  ProspectosProviderService() {
    loadProspectos();
  }
  Future loadProspectos() async {
    var url = Uri.parse(_baseUrl + "/app");
    print(url);
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    // print(data["prospecto"]);
    for (var item in data["prospecto"]) {
      listaProspectos.add(Prospecto.fromMap(item));
    }
    listaProspectos;
    notifyListeners();
  }

  Future buscarProspectos({required String nombre}) async {
    var url = Uri.parse(_baseUrl + "/like/app/$nombre");
    print(url);
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    // print(data["prospecto"]);
    for (var item in data["prospecto"]) {
      listaProspectossearch.add(Prospecto.fromMap(item));
    }
    listaProspectossearch;
    notifyListeners();
  }

  Future guardar({required Prospecto prospecto}) async {
    // try {
    if (prospecto.id == null) {
      var url = Uri.parse(_baseUrl + "/prospectos");
      var data = {
        "name": prospecto.name,
        "linkedin": prospecto.linkedin,
        "puesto": prospecto.puesto,
        "numero": prospecto.numero,
        "email": prospecto.email
      };
      var response = await http.post(url, body: data);
      var respuesta = jsonDecode(response.body);
      listaProspectos.add(Prospecto.fromMap(respuesta));
      notifyListeners();
      return true;
    } else {
      var url = Uri.parse(_baseUrl + "/prospectos/update");
      var data = {
        "id": "${prospecto.id}",
        "name": prospecto.name,
        "linkedin": prospecto.linkedin,
        "puesto": prospecto.puesto,
        "numero": prospecto.numero,
        "email": prospecto.email
      };
      var response = await http.put(url, body: data);
      final index =
          listaProspectos.indexWhere((element) => element.id == prospecto.id);
      listaProspectos[index] = prospecto;
      notifyListeners();
      return true;
    }
    // } catch (e) {
    //   return false;
    // }
  }
}

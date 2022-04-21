import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prospectos_app/models/prospecto.dart';

class ApiProspectos {
  var url = "";
  Future getProspectos(String nombre) async {
    List<Prospecto> listaProspectossearch = [];
    var url = Uri.parse("https://api.carlostapiad.com/api/app/like/$nombre");
    print(url);
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    // print(data["prospecto"]);
    for (var item in data["prospecto"]) {
      listaProspectossearch.add(Prospecto.fromMap(item));
    }
    return listaProspectossearch;
  }
}

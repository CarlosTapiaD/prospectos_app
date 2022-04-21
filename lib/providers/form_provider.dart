import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prospectos_app/models/prospecto.dart';

class FormProvider extends ChangeNotifier {
  final String _baseUrl = "https://api.carlostapiad.com/api";
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  int id = 0;
  Prospecto prospecto;
  FormProvider(this.prospecto);

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return keyForm.currentState?.validate() ?? false;
  }

  Future guardar(BuildContext context) async {
    try {
      var url = Uri.parse(_baseUrl + "/prospectos");
      var data = {
        "name": prospecto.name,
        "linkedin": prospecto.linkedin,
        "puesto": prospecto.puesto,
        "numero": prospecto.numero,
        "email": prospecto.email
      };
      // var data = {};
      await http.post(url, body: data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future update() async {
    try {
      var url = Uri.parse(_baseUrl + "/prospectos/update");
      var data = {
        "id": prospecto.id,
        "name": prospecto.name,
        "linkedin": prospecto.linkedin,
        "puesto": prospecto.puesto,
        "numero": prospecto.numero,
        "email": prospecto.email
      };
      var response = await http.put(url, body: data);
    } catch (e) {
      return false;
    }
  }
}

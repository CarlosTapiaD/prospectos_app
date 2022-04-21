import 'package:flutter/material.dart';
import 'package:prospectos_app/apis/prospectos_api.dart';

import '../models/prospecto.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  ApiProspectos apiProspectos = ApiProspectos();
  Future<List<Prospecto>> getProspecto(String strNombre) async {
    List<Prospecto> Prospectos = [];
    final response = await apiProspectos.getProspectos(strNombre);
    if (response != null) {
      Prospectos = response;
    }
    return Prospectos;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: las acciones del appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
    // throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono izquierda appbar
    return IconButton(
      icon: AnimatedIcon(
        progress: transitionAnimation,
        icon: AnimatedIcons.menu_arrow,
      ),
      onPressed: () {
        close(context, null);
      },
    );
    //throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: getProspecto(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Prospecto>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data!.map((e) {
              return ListTile(
                title: Text("Folio ${e.id} ${e.name}"),
                subtitle: Text("\$" + e.numero),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, 'form', arguments: e);
                },
              );
            }).toList());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
        future: getProspecto(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Prospecto>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data!.map((e) {
              return Card(
                child: ListTile(
                  title: Text("Folio ${e.id} ${e.name}"),
                  subtitle: Text("Telefono " + e.numero),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    close(context, null);
                    Navigator.pushNamed(context, 'form', arguments: e);
                  },
                ),
              );
            }).toList());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:prospectos_app/models/prospecto.dart';
import 'package:prospectos_app/providers/prospecto_provider_service.dart';
import 'package:prospectos_app/search/search_data.dart';
import 'package:prospectos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prospectosProviderService =
        Provider.of<ProspectosProviderService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Candidatos"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: const DrawerWidget(),
      body: prospectosProviderService.listaProspectos.length == 0
          ? const Center(
              child: Text("Sin Candidatos"),
            )
          : ListView.builder(
              itemCount: prospectosProviderService.listaProspectos.length,
              itemBuilder: (_, index) {
                Prospecto p = prospectosProviderService.listaProspectos[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      onTap: () {
                        Prospecto pc = p.copy();
                        Navigator.pushNamed(context, "form", arguments: pc);
                      },
                      leading: const Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                        size: 24,
                      ),
                      title: Text("Folio: ${p.id} ${p.name}"),
                      subtitle: Text(
                          "Numero ${p.numero} Puesto ${p.puesto} Email ${p.email} Linkeding ${p.linkedin} "),
                      trailing: const Icon(
                        Icons.arrow_right,
                        size: 24,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
                heroTag: "btn1",
                onPressed: (() {
                  Prospecto p = Prospecto(
                      email: "",
                      name: "",
                      linkedin: "",
                      numero: "",
                      puesto: "");
                  Navigator.pushNamed(context, "form", arguments: p);
                }),
                child: Icon(Icons.person_add))
          ]),
    );
  }
}

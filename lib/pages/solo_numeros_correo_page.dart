import 'package:flutter/material.dart';
import 'package:prospectos_app/models/prospecto.dart';
import 'package:prospectos_app/providers/prospecto_provider_service.dart';
import 'package:prospectos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SoloNumerosCorreoPage extends StatelessWidget {
  const SoloNumerosCorreoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prospectosProviderService =
        Provider.of<ProspectosProviderService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Candidatos"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
          itemCount: prospectosProviderService.listaProspectos.length,
          itemBuilder: (_, index) {
            Prospecto p = prospectosProviderService.listaProspectos[index];
            return Padding(
              padding: EdgeInsets.all(10),
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
                  subtitle: Text("Numero: ${p.numero} Correo: ${p.email}"),
                  trailing: const Icon(
                    Icons.arrow_right,
                    size: 24,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            );
          }),
    );
  }
}

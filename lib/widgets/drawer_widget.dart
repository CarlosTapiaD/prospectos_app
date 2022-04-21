import 'package:flutter/material.dart';
import 'package:prospectos_app/models/prospecto.dart';

import '../apis/auth_api.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Pantallas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Home'),
            onTap: () {
              Navigator.popAndPushNamed(context, "/");
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Nuevo Candidato'),
            onTap: () {
              Prospecto p = Prospecto(
                  email: "", name: "", linkedin: "", numero: "", puesto: "");
              Navigator.popAndPushNamed(context, "form", arguments: p);
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: const Text('Solo Numeros'),
            onTap: () {
              Navigator.popAndPushNamed(context, "soloNumeros");
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: const Text('Numero y Correo'),
            onTap: () {
              Navigator.popAndPushNamed(context, "numeroycorreo");
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Correos'),
            onTap: () {
              Navigator.popAndPushNamed(context, "solocorreo");
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Personas'),
            onTap: () {
              Navigator.popAndPushNamed(context, "solopersona");
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Salir'),
            onTap: () async {
              await authService.logout();
              Navigator.pushReplacementNamed(context, "login");
            },
          ),
        ],
      ),
    );
  }
}

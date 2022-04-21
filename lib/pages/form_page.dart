import 'package:flutter/material.dart';
import 'package:prospectos_app/models/prospecto.dart';

import '../providers/form_provider.dart';
import '../providers/prospecto_provider_service.dart';
import '../ui/input_decoration.dart';
import 'package:provider/provider.dart';

class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prospectosProviderService =
        Provider.of<ProspectosProviderService>(context);
    final args = ModalRoute.of(context)!.settings.arguments as Prospecto;
    if (args != null) {
      prospectosProviderService.selectProspecto = args;
    }
    return ChangeNotifierProvider(
      create: (_) => FormProvider(prospectosProviderService.selectProspecto),
      child: _formBody(),
    );
  }
}

class _formBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Candidato"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                  width: 500,
                  child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _LoginForm(),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prospectosProviderService2 =
        Provider.of<ProspectosProviderService>(context);
    final loginForm = Provider.of<FormProvider>(context);
    return Container(
      child: Form(
          key: loginForm.keyForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                initialValue: loginForm.prospecto.name,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: "",
                    labelText: "Nombre",
                    prefixIcon: Icons.person),
                onChanged: (value) => loginForm.prospecto.name = value,
                validator: (value) {
                  if (value != null && value.length >= 3) {
                    return null;
                  }
                  return "El nombre debe tener el un minimo de 3 letras";
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                initialValue: loginForm.prospecto.linkedin,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: "",
                    labelText: "Linkedin",
                    prefixIcon: Icons.link),
                onChanged: (value) => loginForm.prospecto.linkedin = value,
                validator: (value) {
                  if (value != null && value.length >= 1) {
                    return null;
                  }
                  return "este campo no puede ir vacio";
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: loginForm.prospecto.puesto,
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: "",
                    labelText: "Puesto",
                    prefixIcon: Icons.card_travel),
                onChanged: (value) => loginForm.prospecto.puesto = value,
                validator: (value) {
                  if (value != null && value.length >= 3) {
                    return null;
                  }
                  return "El puesto debe tener el un minimo de 3 letras";
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                initialValue: loginForm.prospecto.numero,
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: "",
                    labelText: "Numero",
                    prefixIcon: Icons.phone_android),
                onChanged: (value) =>
                    loginForm.prospecto.numero = value.toString(),
                validator: (value) {
                  if (value != null && value.length >= 3) {
                    return null;
                  }
                  return "Este campo no puede ir vacio";
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: loginForm.prospecto.email,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: "",
                    labelText: "Email",
                    prefixIcon: Icons.alternate_email_sharp),
                onChanged: (value) => loginForm.prospecto.email = value,
                validator: (a) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(a ?? "")
                      ? null
                      : "Este correo no es valido";
                },
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: (loginForm.isLoading
                    ? null
                    : () async {
                        print(loginForm.prospecto.id);
                        if (loginForm.isValidForm()) {
                          loginForm.isLoading = true;
                          // await Future.delayed(const Duration(seconds: 2));
                          // if (loginForm.id != 0
                          //     ? await loginForm.update()
                          //     : await loginForm.guardar(context)) {
                          if (await prospectosProviderService2.guardar(
                              prospecto: loginForm.prospecto)) {
                            const snackBar = SnackBar(
                              content: Text("Se guardo"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            loginForm.isLoading = false;
                            return;
                          } else {
                            loginForm.isLoading = true;
                            const snackBar = SnackBar(
                              content: Text("No se guardo"),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          loginForm.isLoading = false;
                          return;
                        }
                        loginForm.isLoading = true;
                        const snackBar = SnackBar(
                          content: Text("No se guardo"),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        loginForm.isLoading = false;
                        // Navigator.pushReplacementNamed(context, "/");
                      }),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: const Text(
                    "guardar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

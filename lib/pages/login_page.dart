import 'package:flutter/material.dart';
import 'package:prospectos_app/providers/login_form_provider.dart';
import 'package:prospectos_app/services/notification_service.dart';
import 'package:prospectos_app/ui/input_decoration.dart';
import 'package:prospectos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../apis/auth_api.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 200),
        CardContainer(
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Login",
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 30,
            ),
            Text("Formulario"),
            ChangeNotifierProvider(
              create: (_) => LoginFormProvider(),
              child: _LoginForm(),
            )
          ]),
        ),
        const SizedBox(
          height: 50,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "register");
            },
            child: const Text(
              "Crear una nueva cuenta",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ))
      ]),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Container(
      child: Form(
          key: loginForm.keyForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          //TODO mantener la referencia KEY
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: "Usuario",
                    labelText: "User",
                    prefixIcon: Icons.alternate_email_sharp),
                onChanged: (value) => loginForm.email = value,
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
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: "Contraseña",
                    labelText: "password",
                    prefixIcon: Icons.password),
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  if (value != null && value.length >= 6) {
                    return null;
                  }
                  return "La contraseña debe tener minimo 6 caracteres";
                },
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: (loginForm.isLoading
                    ? null
                    : () async {
                        if (loginForm.isValidForm()) {
                          loginForm.isLoading = true;
                          final String? token = await authService.authUser(
                              loginForm.email, loginForm.password);
                          loginForm.isLoading = false;
                          if (token == null) {
                            Navigator.pushReplacementNamed(context, "/");
                          }
                          NotificationService.showSnackbar(token!);
                        }
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
                  child: Text(
                    loginForm.isLoading ? "Validando..." : "Ingresar",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

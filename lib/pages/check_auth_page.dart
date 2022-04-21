import 'package:flutter/material.dart';
import 'package:prospectos_app/apis/auth_api.dart';
import 'package:prospectos_app/pages/home_page.dart';
import 'package:prospectos_app/pages/login_page.dart';
import 'package:provider/provider.dart';

class CheckAuthPage extends StatelessWidget {
  const CheckAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            return const Text("Esper");
          }
          if (asyncSnapshot.data == '') {
            Future.microtask(() => {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) {
                          return const LoginPage();
                        },
                        transitionDuration: const Duration(seconds: 0)),
                  )
                });
          } else {
            Future.microtask(() => {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) {
                          return const HomePage();
                        },
                        transitionDuration: const Duration(seconds: 0)),
                  )
                });
          }

          return Container();
        },
      )),
    );
  }
}

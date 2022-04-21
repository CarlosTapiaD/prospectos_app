import 'package:flutter/material.dart';
import 'package:prospectos_app/apis/auth_api.dart';
import 'package:prospectos_app/pages/pages.dart';
import 'package:prospectos_app/pages/solo_personas_page.dart';
import 'package:prospectos_app/providers/prospecto_provider_service.dart';
import 'package:prospectos_app/services/notification_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProspectosProviderService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: NotificationService.messenger,
        initialRoute: "check",
        routes: {
          "/": (context) => HomePage(),
          "login": (context) => LoginPage(),
          "form": (context) => FormPage(),
          "soloNumeros": (context) => SoloNumerosPage(),
          "numeroycorreo": (context) => SoloNumerosCorreoPage(),
          "solocorreo": (context) => SoloCorreoPage(),
          "solopersona": (context) => SoloPersonasPage(),
          "register": (context) => RegisterPage(),
          "check": (context) => CheckAuthPage()
        },
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}

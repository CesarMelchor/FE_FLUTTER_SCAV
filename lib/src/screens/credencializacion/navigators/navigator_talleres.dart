import 'package:flutter/material.dart';
import 'package:scav/src/pages/credencializacion/add_new/add_taller.dart';
import 'package:scav/src/pages/credencializacion/listas/list_talleres.dart';

class NavigatorTalleres extends StatefulWidget {
  const NavigatorTalleres({super.key});

  @override
  State<NavigatorTalleres> createState() => _NavigatorTalleresState();
}

class _NavigatorTalleresState extends State<NavigatorTalleres> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'listTalleres',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'listTalleres':
            return MaterialPageRoute(
                builder: (context) => const ListTalleresScreen(), settings: settings);
          case 'addTaller':
            return MaterialPageRoute(
                builder: (context) => const AddTallerScreen(), settings: settings); 
             
          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
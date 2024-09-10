import 'package:flutter/material.dart';
import 'package:scav/src/pages/credencializacion/add_new/add_rama.dart';
import 'package:scav/src/pages/credencializacion/listas/list_ramas.dart';
import 'package:scav/src/pages/credencializacion/listas/list_tecnicas.dart';

class NavigatorRamas extends StatefulWidget {
  const NavigatorRamas({super.key});

  @override
  State<NavigatorRamas> createState() => _NavigatorRamasState();
}

class _NavigatorRamasState extends State<NavigatorRamas> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'listRamas',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'listRamas':
            return MaterialPageRoute(
                builder: (context) => const ListRamasScreen(), settings: settings);
           case 'listTecnicas':
            return MaterialPageRoute(
                builder: (context) => const ListTecnicasScreen(), settings: settings);
          case 'addRama':
            return MaterialPageRoute(
                builder: (context) => const AddRamaScreen(), settings: settings); 
          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
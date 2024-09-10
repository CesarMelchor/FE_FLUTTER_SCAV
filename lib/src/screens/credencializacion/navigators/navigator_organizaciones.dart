import 'package:flutter/material.dart';
import 'package:scav/src/pages/credencializacion/add_new/add_organizacion.dart';
import 'package:scav/src/pages/credencializacion/listas/list_organizaciones.dart';

class NavigatorOrganizaciones extends StatefulWidget {
  const NavigatorOrganizaciones({super.key});

  @override
  State<NavigatorOrganizaciones> createState() => _NavigatorOrganizacionesState();
}

class _NavigatorOrganizacionesState extends State<NavigatorOrganizaciones> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'listOrganizaciones',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'listOrganizaciones':
            return MaterialPageRoute(
                builder: (context) => const ListOrganizacionesScreen(), settings: settings);
          case 'addOrganizacion':
            return MaterialPageRoute(
                builder: (context) => const AddOrganizacionScreen(), settings: settings); 
         
          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
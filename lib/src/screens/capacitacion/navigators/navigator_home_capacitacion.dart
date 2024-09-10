import 'package:flutter/material.dart';
import 'package:scav/src/pages/capacitacion/list_inscripciones.dart';
import 'package:scav/src/pages/credencializacion/add_new/add_artesano.dart';

class NavigatorHomeCapacitacion extends StatefulWidget {
  const NavigatorHomeCapacitacion({super.key});

  @override
  State<NavigatorHomeCapacitacion> createState() => _NavigatorHomeCapacitacionState();
}

class _NavigatorHomeCapacitacionState extends State<NavigatorHomeCapacitacion> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'listInscripciones',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'listInscripciones':
            return MaterialPageRoute(
                builder: (context) => const ListInscripcionesScreen(), settings: settings);
          case 'addArtesano':
            return MaterialPageRoute(
                builder: (context) => const AddArtesanoScreen(), settings: settings); 
          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
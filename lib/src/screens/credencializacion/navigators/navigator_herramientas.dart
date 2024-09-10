import 'package:flutter/material.dart';
import 'package:scav/src/pages/credencializacion/herramientas.dart';
import 'package:scav/src/pages/credencializacion/listas/list_distritos.dart';
import 'package:scav/src/pages/credencializacion/listas/list_localidades.dart';
import 'package:scav/src/pages/credencializacion/listas/list_municipios.dart';
import 'package:scav/src/pages/credencializacion/listas/list_regiones.dart';
import 'package:scav/src/pages/credencializacion/listas/list_usuarios.dart';

class NavigatorComplements extends StatefulWidget {
  const NavigatorComplements({super.key});

  @override
  State<NavigatorComplements> createState() => _NavigatorComplementsState();
}

class _NavigatorComplementsState extends State<NavigatorComplements> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'herramientas',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'herramientas':
            return MaterialPageRoute(
                builder: (context) => const HerramientasPage(), settings: settings);
          case 'usuarios':
            return MaterialPageRoute(
                builder: (context) => const ListUsuariosPage(), settings: settings);
          case 'municipios':
            return MaterialPageRoute(
                builder: (context) => const ListMunicipiiosPage(), settings: settings); 
                case 'regiones':
            return MaterialPageRoute(
                builder: (context) => const ListRegionesPage(), settings: settings); 
                case 'localidades':
            return MaterialPageRoute(
                builder: (context) => const ListLocalidadesPage(), settings: settings); 
                case 'distritos':
            return MaterialPageRoute(
                builder: (context) => const ListDistritosPage(), settings: settings); 
          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
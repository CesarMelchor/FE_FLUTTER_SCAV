import 'package:flutter/material.dart';
import 'package:scav/src/pages/credencializacion/users/capturista/add_artesano_cap.dart';
import 'package:scav/src/pages/credencializacion/users/consultor/list_agrupaciones_con.dart';
import 'package:scav/src/pages/credencializacion/users/consultor/list_artesanos_con.dart';

class NavigatorArtesanosCon extends StatefulWidget {
  const NavigatorArtesanosCon({super.key});

  @override
  State<NavigatorArtesanosCon> createState() => _NavigatorArtesanosConState();
}

class _NavigatorArtesanosConState extends State<NavigatorArtesanosCon> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'listArtesanosCon',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'listArtesanosCon':
            return MaterialPageRoute(
                builder: (context) => const ListArtesanosConScreen(), settings: settings);
          case 'listTalleresCon':
            return MaterialPageRoute(
                builder: (context) => const AddArtesanoCapScreen(), settings: settings); 
                case 'listAgrupacionesCon':
            return MaterialPageRoute(
                builder: (context) => const ListAgrupacionesConScreen(), settings: settings); 
          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
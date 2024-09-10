import 'package:flutter/material.dart';
import 'package:scav/src/pages/credencializacion/users/capturista/add_artesano_cap.dart';
import 'package:scav/src/pages/credencializacion/users/capturista/edit_artesano_cap.dart';
import 'package:scav/src/pages/credencializacion/users/capturista/list_artesanos_cap.dart';

class NavigatorArtesanosCap extends StatefulWidget {
  const NavigatorArtesanosCap({super.key});

  @override
  State<NavigatorArtesanosCap> createState() => _NavigatorArtesanosCapState();
}

class _NavigatorArtesanosCapState extends State<NavigatorArtesanosCap> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'listArtesanosCap',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'listArtesanosCap':
            return MaterialPageRoute(
                builder: (context) => const ListArtesanosCapScreen(), settings: settings);
          case 'addArtesano':
            return MaterialPageRoute(
                builder: (context) => const AddArtesanoCapScreen(), settings: settings); 
                case 'viewEditArtesano':
            return MaterialPageRoute(
                builder: (context) => const ViewEditArtesanoCapScreen(), settings: settings); 
          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:scav/src/pages/credencializacion/offline/add_artesano.dart';
import 'package:scav/src/pages/credencializacion/offline/edit_artesano.dart';
import 'package:scav/src/pages/credencializacion/offline/edit_organizacion.dart';
import 'package:scav/src/pages/credencializacion/offline/list_artesanos.dart';
import 'package:scav/src/pages/credencializacion/offline/list_organizaciones.dart';


class NavigatorArtesanosOffline extends StatefulWidget {
  const NavigatorArtesanosOffline({super.key});

  @override
  State<NavigatorArtesanosOffline> createState() => _NavigatorArtesanosOfflineState();
}

class _NavigatorArtesanosOfflineState extends State<NavigatorArtesanosOffline> {

  @override
  Widget build(BuildContext context) {
    
    return Navigator(
      initialRoute: 'listArtesanos',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'listArtesanos':
            return MaterialPageRoute(
                builder: (context) => const ListArtesanosOfflineScreen(), settings: settings);
          case 'addArtesano':
            return MaterialPageRoute(
                builder: (context) => const AddArtesanoOfflineScreen(), settings: settings); 
                case 'viewEditArtesano':
            return MaterialPageRoute(
                builder: (context) => const ViewEditArtesanoOfflineScreen(), settings: settings); 
                case 'organizaciones':
            return MaterialPageRoute(
                builder: (context) => const OrganizacionesOfflineScreen(), settings: settings); 
                 case 'viewEditOrganizacion':
            return MaterialPageRoute(
                builder: (context) => const ViewEditOrganizacionOfflineScreen(), settings: settings); 
          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
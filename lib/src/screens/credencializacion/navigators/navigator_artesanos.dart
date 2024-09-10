import 'package:flutter/material.dart';
import 'package:scav/src/pages/credencializacion/add_new/add_artesano.dart';
import 'package:scav/src/pages/credencializacion/listas/list_artesanos.dart';
import 'package:scav/src/pages/credencializacion/listas/list_organizaciones.dart';
import 'package:scav/src/pages/credencializacion/view_edit/view_edit_artesano.dart';
import 'package:scav/src/pages/credencializacion/view_edit/view_edit_organizacion.dart';


class NavigatorArtesanos extends StatefulWidget {
  const NavigatorArtesanos({super.key});

  @override
  State<NavigatorArtesanos> createState() => _NavigatorArtesanosState();
}

class _NavigatorArtesanosState extends State<NavigatorArtesanos> {

  @override
  Widget build(BuildContext context) {
    

    return Navigator(
      initialRoute: 'listArtesanos',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'listArtesanos':
            return MaterialPageRoute(
                builder: (context) => const ListArtesanosScreen(), settings: settings);
          case 'addArtesano':
            return MaterialPageRoute(
                builder: (context) => const AddArtesanoScreen(), settings: settings); 
                case 'viewEditArtesano':
            return MaterialPageRoute(
                builder: (context) => const ViewEditArtesanoScreen(), settings: settings); 
                case 'organizaciones':
            return MaterialPageRoute(
                builder: (context) => const ListOrganizacionesScreen(), settings: settings); 
                 case 'viewEditOrganizacion':
            return MaterialPageRoute(
                builder: (context) => const ViewEditOrganizacionScreen(), settings: settings); 
          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
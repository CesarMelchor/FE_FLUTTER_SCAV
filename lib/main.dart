import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scav/main_screen.dart';
import 'package:scav/src/pages/capacitacion/offline/home_capacitacion.dart';
import 'package:scav/src/pages/capacitacion/users/capturista/home_capturista.dart';
import 'package:scav/src/pages/capacitacion/users/consultor/home_consultor.dart';
import 'package:scav/src/pages/credencializacion/add_new/add_artesano.dart';
import 'package:scav/src/pages/credencializacion/add_new/add_organizacion.dart';
import 'package:scav/src/pages/credencializacion/listas/list_artesanos.dart';
import 'package:scav/src/pages/credencializacion/listas/list_organizaciones.dart';
import 'package:scav/src/pages/credencializacion/listas/list_ramas.dart';
import 'package:scav/src/pages/credencializacion/listas/list_talleres.dart';
import 'package:scav/src/pages/credencializacion/offline/home_offline.dart';
import 'package:scav/src/pages/credencializacion/users/capturista/home_artesano_cap.dart';
import 'package:scav/src/pages/credencializacion/users/consultor/home_artesano_con.dart';
import 'package:scav/src/providers/credenciales_provider.dart';
import 'package:scav/src/providers/login_provider_c.dart';
import 'package:scav/src/screens/capacitacion/home_capacitacion.dart';
import 'package:scav/src/screens/capacitacion/login_capacitacion.dart';
import 'package:scav/src/screens/credencializacion/home_art.dart';
import 'package:scav/src/screens/credencializacion/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/screens/ferias/home_ferias.dart';
import 'package:scav/src/screens/ferias/login_ferias.dart';
import 'package:scav/src/utils/colors.dart';
import 'package:vrouter/vrouter.dart';


void main() {
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) {
    return VRouter(
      theme: ThemeData(
         primarySwatch: primary,
      ),
      localizationsDelegates: const [
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
                  ],
      supportedLocales: const [
      Locale('es'),
      ],
      initialUrl: '/home',
      title: 'SCAV',
      debugShowCheckedModeBanner: false,
      routes: [
        
        VWidget(path: '/home',widget: const MyHomePage(title: '',)),

        // credencializacion

        VWidget(path: '/loginCredencial', widget: ChangeNotifierProvider(create: (_) => LoginProvider(),
          child: const LoginScreenCredenciales())),
        VWidget(path: '/homeCredencializacion', widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const HomeArtesanosScreen())),
        VWidget(path: '/homeCredencializacionCap', widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const HomeArtesanosCapScreen())),
           VWidget(path: '/homeCredencializacionCon', widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const HomeArtesanosConScreen())),
        VWidget(path: '/addArtesano', 
        widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const AddArtesanoScreen())),
        VWidget(path: '/addOrganizacion', 
        widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const AddOrganizacionScreen())),
        VWidget(path: '/listArtesanos', 
        widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const ListArtesanosScreen())),
        VWidget(path: '/listOrganizaciones', 
        widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const ListOrganizacionesScreen())),
        VWidget(path: '/listRamas', 
        widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const ListRamasScreen())),
        VWidget(path: '/listTalleres', 
        widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const ListTalleresScreen())),

        // capacitacion

        VWidget(path: '/loginCapacitacion', widget: ChangeNotifierProvider(create: (_) => LoginProvider(),
          child: const LoginScreenCapacitacion())),
        VWidget(path: '/homeCapacitacion', widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const HomeCapacitacionScreen())),
          VWidget(path: '/homeCapacitacionCap', widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const HomeCapturistaCapacitacionScreen())),
          VWidget(path: '/homeCapacitacionCon', widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const HomeConsultorCapacitacionScreen())),

          //offline
          
        VWidget(path: '/homeOffline', widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const HomeArtesanosOfflineScreen())),
          
        VWidget(path: '/homeOfflineCapacitacion', widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const HomeCapacitacionOfflineScreen())),
// ferias

        VWidget(path: '/loginFerias', widget: ChangeNotifierProvider(create: (_) => LoginProvider(),
          child: const LoginScreenFerias())),
        VWidget(path: '/homeFerias', widget: ChangeNotifierProvider(create: (_) => CredencialProvider(),
          child: const HomeFeriasScreen())),
      ],
    );
  }));
}


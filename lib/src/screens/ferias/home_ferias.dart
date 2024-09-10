import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/pages/capacitacion/list_acciones.dart';
import 'package:scav/src/pages/capacitacion/list_comprobaciones.dart';
import 'package:scav/src/pages/capacitacion/list_users.dart';
import 'package:scav/src/screens/capacitacion/navigators/navigator_home_capacitacion.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:vrouter/vrouter.dart';
import 'package:cooky/cooky.dart' as cookie;


class HomeFeriasScreen extends StatefulWidget {
  const HomeFeriasScreen({super.key});

  @override
  State<HomeFeriasScreen> createState() => _HomeFeriasScreenState();
}

class _HomeFeriasScreenState extends State<HomeFeriasScreen> {
  @override
  Widget build(BuildContext context) {
    
    var value = cookie.get('idFer');
    if (value != "") {
    }else{

       context.vRouter.to("/loginFerias");
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              width: Adaptive.w(100),
              height: Adaptive.h(30),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/ORGANIZACION_INFORMACION-03.png"))),
              child: Column(
                children: [
                  SizedBox(
                    height: Adaptive.h(5),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/images/ORGANIZACION_INFORMACION-09.png",
                        width: Adaptive.w(20),
                      ),
                      SizedBox(width: Adaptive.w(28),),
                      ElevatedButton.icon(
                          icon: const Icon(Icons.logout),
                          style: Styles.buttonLogoutArtesano,
                          onPressed: () {
                            cookie.remove('idFer');
                            context.vRouter.to("/loginFerias");
                          },
                          label: Text(
                            "CERRAR SESION",
                            style: TextStyle(fontSize: Adaptive.sp(11)),
                          )),
                    ],
                  ),
                  SizedBox(
                    width: Adaptive.w(90),
                    height: Adaptive.h(10),
                    child: const TabBar(
                      indicatorColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: TextStyle(color: Colors.white),
                      tabs: [
                        Tab(text: "FERIAS,CONCURSOS,EXPOSICIONES"),
                        Tab(text: "SORTEOS"),
                        Tab(text: "USUARIOS"),
                        Tab(text: "PENDIENTE"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Adaptive.w(100),
              height: Adaptive.h(70),
              child: const TabBarView(
                children: [
                  NavigatorHomeCapacitacion(),
                  ListAccionesScreen(),
                  ListUsuariosCapacitacionPage(),
                  ListComprobacionesScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

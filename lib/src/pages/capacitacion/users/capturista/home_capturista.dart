import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/pages/capacitacion/users/capturista/acciones_cap.dart';
import 'package:scav/src/pages/capacitacion/users/capturista/inscripciones_cap.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:vrouter/vrouter.dart';

class HomeCapturistaCapacitacionScreen extends StatefulWidget {
  const HomeCapturistaCapacitacionScreen({super.key});

  @override
  State<HomeCapturistaCapacitacionScreen> createState() => _HomeCapturistaCapacitacionScreenState();
}

class _HomeCapturistaCapacitacionScreenState extends State<HomeCapturistaCapacitacionScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                            context.vRouter.to("/loginCapacitacion");
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
                      labelColor: Colors.white,
                      tabs: [
                        Tab(text: "INSCRIPCIONES"),
                        Tab(text: "ACCIONES"),
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
                  ListInscripcionesCapturistaScreen(),
                  ListAccionesCapturistaScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

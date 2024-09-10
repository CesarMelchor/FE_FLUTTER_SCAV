import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/screens/credencializacion/navigators/navigator_Artesanos.dart';
import 'package:scav/src/screens/credencializacion/navigators/navigator_herramientas.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:vrouter/vrouter.dart';
import 'package:cooky/cooky.dart' as cookie;


class HomeArtesanosScreen extends StatefulWidget {
  const HomeArtesanosScreen({super.key});

  @override
  State<HomeArtesanosScreen> createState() => _HomeArtesanosScreenState();
}

class _HomeArtesanosScreenState extends State<HomeArtesanosScreen> {
  @override
  Widget build(BuildContext context) {
    
var value = cookie.get('idCred');
    if (value != "") {
    }else{
       context.vRouter.to("/loginCredencial");
    }

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
                            
                            cookie.remove('idCred');
                            context.vRouter.to("/loginCredencial");
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
                        Tab(text: "PERSONAS ARTESANAS"),
                        Tab(text: "COMPLEMENTOS"),
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
                  NavigatorArtesanos(),
                  NavigatorComplements(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

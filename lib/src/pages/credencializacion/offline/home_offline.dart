import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/pages/credencializacion/offline/navigator_offline.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:vrouter/vrouter.dart';


class HomeArtesanosOfflineScreen extends StatefulWidget {
  const HomeArtesanosOfflineScreen({super.key});

  @override
  State<HomeArtesanosOfflineScreen> createState() => _HomeArtesanosOfflineScreenState();
}

class _HomeArtesanosOfflineScreenState extends State<HomeArtesanosOfflineScreen> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 1,
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
                            
                            context.vRouter.to("/loginCredencial");
                          },
                          label: Text(
                            "SALIR",
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
                  NavigatorArtesanosOffline(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
